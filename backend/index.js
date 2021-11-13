require('dotenv').config()

const express = require('express')
const cors = require('cors')
const { Client } = require('pg')
const port = 3000

const client = new Client()

const app = express()

app.use(cors())

app.get('/data', async(req, res) => {
    const data = await client.query("SELECT actor.name, actor.surname, actor.birthdate, actor.birthplace, actor.height, actor.startyear, actor.favcolor, array_to_string(array_agg(distinct award.awardname), ',') as awards, array_to_string(array_agg(distinct film.name), ',') as films FROM actor LEFT JOIN acts ON actor.actorid = acts.actorid LEFT JOIN film ON film.filmid = acts.filmid LEFT JOIN award ON award.actorid = actor.actorid GROUP BY actor.actorid");
    res.json({data : data.rows});
})

app.listen(port, async() => {
    await client.connect()
    console.log(`Example app listening at http://localhost:${port}`)
})