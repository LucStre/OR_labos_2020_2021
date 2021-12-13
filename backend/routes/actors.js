var express = require("express");
var router = express.Router();
const db = require("../db");

router.get("/", async (req, res) => {
  const data = await db.query(
    "SELECT actor.*, array_to_string(array_agg(distinct award.awardname), ',') as awards, array_to_string(array_agg(distinct film.name), ',') as films FROM actor LEFT JOIN acts ON actor.actorid = acts.actorid LEFT JOIN film ON film.filmid = acts.filmid LEFT JOIN award ON award.actorid = actor.actorid GROUP BY actor.actorid"
  );
  res.json({ data: data.rows });
});

router.post("/", async (req, res) => {
  await db.query(
    "INSERT INTO actor (name, surname, middlename, birthdate, birthplace, height, marriage, children, siblings, startyear, favfood, favcolor, favbook) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)",
    [
      req.body.name,
      req.body.surname,
      req.body.middlename == undefined ? null : req.body.middlename,
      req.body.birthdate,
      req.body.birthplace,
      req.body.height,
      req.body.marriage,
      req.body.children,
      req.body.siblings,
      req.body.startyear,
      req.body.favfood == undefined ? null : req.body.favfood,
      req.body.favcolor == undefined ? null : req.body.favcolor,
      req.body.favbook == undefined ? null : req.body.favbook,
    ]
  );
  res.status(201).send("New actor created.");
});

module.exports = router;
