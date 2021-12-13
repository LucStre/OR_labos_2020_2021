require("dotenv").config();

const express = require("express");
const cors = require("cors");
const { Client } = require("pg");
const port = 3000;

const actorsRouter = require("./routes/actors");
const actorRouter = require("./routes/actor");
const birthplaceRouter = require("./routes/birthplace");
const isactingRouter = require("./routes/isacting");
const marriedRouter = require("./routes/married");
const movieRouter = require("./routes/movie");

const client = new Client();

const app = express();

app.use(cors());

app.get("/data", async (req, res) => {
  const data = await client.query(
    "SELECT actor.name, actor.surname, actor.birthdate, actor.birthplace, actor.height, actor.marriage, actor.startyear, actor.favcolor, array_to_string(array_agg(distinct award.awardname), ',') as awards, array_to_string(array_agg(distinct film.name), ',') as films FROM actor LEFT JOIN acts ON actor.actorid = acts.actorid LEFT JOIN film ON film.filmid = acts.filmid LEFT JOIN award ON award.actorid = actor.actorid GROUP BY actor.actorid"
  );
  res.json({ data: data.rows });
});

app.use("/actors", actorsRouter);
app.use("/actor", actorRouter);
app.use("/birthplace", birthplaceRouter);
app.use("/isacting", isactingRouter);
app.use("/married", marriedRouter);
app.use("/movie", movieRouter);

app.listen(port, async () => {
  await client.connect();
  console.log(`Example app listening at http://localhost:${port}`);
});

module.exports = app;
