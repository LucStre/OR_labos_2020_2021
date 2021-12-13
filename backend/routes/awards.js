var express = require("express");
var router = express.Router();
const db = require("../db");

router.get("/", async (req, res) => {
  const data = await db.query(
    "SELECT award.*, array_to_string(array_agg(distinct actor.name || ' ' || actor.surname), ',') as actors FROM actor LEFT JOIN award ON award.actorid = actor.actorid GROUP BY award.awardid"
  );
  res.json({ data: data.rows });
});

module.exports = router;
