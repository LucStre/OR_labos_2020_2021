var express = require("express");
var router = express.Router();
const db = require("../db");

router.get("/:place", async (req, res) => {
  const data = await db.query(
    "SELECT actor.*, array_to_string(array_agg(distinct award.awardname), ',') as awards, array_to_string(array_agg(distinct film.name), ',') as films FROM actor LEFT JOIN acts ON actor.actorid = acts.actorid LEFT JOIN film ON film.filmid = acts.filmid LEFT JOIN award ON award.actorid = actor.actorid WHERE actor.birthplace = $1::text GROUP BY actor.actorid",
    [req.params.place]
  );
  if (data.rowCount == 0) {
    res
      .status(404)
      .send("Actor with birthplace " + req.params.place + " does not exist.");
  } else {
    res.json({ data: data.rows });
  }
});

module.exports = router;
