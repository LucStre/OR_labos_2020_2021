var express = require("express");
var router = express.Router();
const db = require("../db");

router.get("/", async (req, res) => {
  const data = await db.query(
    "SELECT film.*, array_to_string(array_agg(distinct actor.name || ' ' || actor.surname), ',') as actors FROM actor LEFT JOIN acts ON actor.actorid = acts.actorid LEFT JOIN film ON film.filmid = acts.filmid GROUP BY film.filmid"
  );
  res.json({ data: data.rows });
});

module.exports = router;
