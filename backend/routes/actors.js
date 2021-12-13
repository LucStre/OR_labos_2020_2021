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
  const date = new Date(req.body.birthdate);
  if (
    req.body.name == undefined ||
    req.body.surname == undefined ||
    req.body.birthdate == undefined ||
    req.body.birthplace == undefined ||
    req.body.height == undefined ||
    req.body.marriage == undefined ||
    req.body.children == undefined ||
    req.body.siblings == undefined ||
    req.body.startyear == undefined
  ) {
    res
      .status(400)
      .send(
        "Name, surname, birthdate, birthplace, height, marriage, children, siblings and startyear values must be stated."
      );
  } else if (
    !Number.isInteger(Number(req.body.children)) ||
    !Number.isInteger(Number(req.body.siblings)) ||
    !Number.isInteger(Number(req.body.startyear))
  ) {
    res
      .status(400)
      .send("Children, siblings and startyear values must be integer!");
  } else if (parseInt(Number(req.body.height)) == Number(req.body.height)) {
    res.status(400).send("Height value must be float!");
  } else if (typeof req.body.marriage != "boolean") {
    res.status(400).send("Marriage value must be boolean!");
  } else if (!(date >= 0)) {
    res.status(400).send("Birthdate value must be date!");
  } else if (
    typeof req.body.name != "string" ||
    typeof req.body.surname != "string" ||
    typeof req.body.birthplace != "string"
  ) {
    res.status(400).send("Name, surname and birthplace value must be string!");
  } else if (
    (req.body.middlename == undefined
      ? false
      : typeof req.body.middlename != "string") ||
    (req.body.favfood == undefined
      ? false
      : typeof req.body.favfood != "string") ||
    (req.body.favcolor == undefined
      ? false
      : typeof req.body.favcolor != "string") ||
    (req.body.favbook == undefined
      ? false
      : typeof req.body.favbook != "string")
  ) {
    res
      .status(400)
      .send(
        "Middlename, favfood, favcolor and favbook value must be string if they are stated!"
      );
  } else {
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
  }
});

module.exports = router;
