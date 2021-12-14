require("dotenv").config();

const express = require("express");
const cors = require("cors");
const { Client } = require("pg");
const port = 3000;

const actorsRouter = require("./routes/actors");
const birthplaceRouter = require("./routes/birthplace");
const actingRouter = require("./routes/acting");
const marriedRouter = require("./routes/married");
const movieRouter = require("./routes/movie");
const moviesRouter = require("./routes/movies");
const awardsRouter = require("./routes/awards");
const openapiRouter = require("./routes/openapi");

const client = new Client();

const app = express();

app.use(cors());

app.use(express.json());

app.get("/data", async (req, res) => {
  const data = await client.query(
    "SELECT actor.name, actor.surname, actor.birthdate, actor.birthplace, actor.height, actor.marriage, actor.startyear, actor.favcolor, array_to_string(array_agg(distinct award.awardname), ',') as awards, array_to_string(array_agg(distinct film.name), ',') as films FROM actor LEFT JOIN acts ON actor.actorid = acts.actorid LEFT JOIN film ON film.filmid = acts.filmid LEFT JOIN award ON award.actorid = actor.actorid GROUP BY actor.actorid"
  );
  res.json({ data: data.rows });
});

app.use("/actors", actorsRouter);
app.use("/birthplace", birthplaceRouter);
app.use("/acting", actingRouter);
app.use("/married", marriedRouter);
app.use("/movie", movieRouter);
app.use("/movies", moviesRouter);
app.use("/awards", awardsRouter);
app.use("/openapi", openapiRouter);

app.listen(port, async () => {
  await client.connect();
  console.log(`Example app listening at http://localhost:${port}`);
});

module.exports = app;
