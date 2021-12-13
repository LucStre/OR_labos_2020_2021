var express = require("express");
var router = express.Router();
const db = require("../db");

router.get("/:id", async (req, res) => {
  if (!Number.isInteger(Number(req.params.id))) {
    res.status(400).send("Actor id must be integer!");
  } else {
    const data = await db.query(
      "SELECT actor.*, array_to_string(array_agg(distinct award.awardname), ',') as awards, array_to_string(array_agg(distinct film.name), ',') as films FROM actor LEFT JOIN acts ON actor.actorid = acts.actorid LEFT JOIN film ON film.filmid = acts.filmid LEFT JOIN award ON award.actorid = actor.actorid WHERE actor.actorid = $1 GROUP BY actor.actorid",
      [req.params.id]
    );
    if (!data.rowCount) {
      res
        .status(404)
        .send("Actor with id " + req.params.id + " does not exist.");
    } else {
      res.json({ data: data.rows });
    }
  }
});

module.exports = router;
