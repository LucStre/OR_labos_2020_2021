var express = require("express");
var router = express.Router();
const db = require("../db");

router.get("/", async (req, res) => {
  const data = await db.query(
    "SELECT actor.*, array_to_string(array_agg(distinct award.awardname), ',') as awards, array_to_string(array_agg(distinct film.name), ',') as films FROM actor LEFT JOIN acts ON actor.actorid = acts.actorid LEFT JOIN film ON film.filmid = acts.filmid LEFT JOIN award ON award.actorid = actor.actorid GROUP BY actor.actorid"
  );
  res.json({ data: data.rows });
});

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

router.put("/:id", async (req, res) => {
  if (Object.keys(req.body).length == 0) {
    res.status(400).send("No columns stated in body, nothing to update.");
  } else {
    const data = await db.query(
      "UPDATE actor SET name=$2, surname=$3, middlename=$4, birthdate=$5, birthplace=$6, height=$7, marriage=$8, children=$9, siblings=$10, startyear=$11, favfood=$12, favcolor=$13, favbook=$14 WHERE actorid = $1",
      [
        req.params.id,
        req.body.name == undefined
          ? await (
              await db.query("SELECT name FROM actor WHERE actorid = $1", [
                req.params.id,
              ])
            ).rows[0].name
          : req.body.name,
        req.body.surname == undefined
          ? await (
              await db.query("SELECT surname FROM actor WHERE actorid = $1", [
                req.params.id,
              ])
            ).rows[0].surname
          : req.body.surname,
        req.body.middlename == undefined
          ? await (
              await db.query(
                "SELECT middlename FROM actor WHERE actorid = $1",
                [req.params.id]
              )
            ).rows[0].middlename
          : req.body.middlename,
        req.body.birthdate == undefined
          ? await (
              await db.query("SELECT birthdate FROM actor WHERE actorid = $1", [
                req.params.id,
              ])
            ).rows[0].birthdate
          : req.body.birthdate,
        req.body.birthplace == undefined
          ? await (
              await db.query(
                "SELECT birthplace FROM actor WHERE actorid = $1",
                [req.params.id]
              )
            ).rows[0].birthplace
          : req.body.birthplace,
        req.body.height == undefined
          ? await (
              await db.query("SELECT height FROM actor WHERE actorid = $1", [
                req.params.id,
              ])
            ).rows[0].height
          : req.body.height,
        req.body.marriage == undefined
          ? await (
              await db.query("SELECT marriage FROM actor WHERE actorid = $1", [
                req.params.id,
              ])
            ).rows[0].marriage
          : req.body.marriage,
        req.body.children == undefined
          ? await (
              await db.query("SELECT children FROM actor WHERE actorid = $1", [
                req.params.id,
              ])
            ).rows[0].children
          : req.body.children,
        req.body.siblings == undefined
          ? await (
              await db.query("SELECT siblings FROM actor WHERE actorid = $1", [
                req.params.id,
              ])
            ).rows[0].siblings
          : req.body.siblings,
        req.body.startyear == undefined
          ? await (
              await db.query("SELECT startyear FROM actor WHERE actorid = $1", [
                req.params.id,
              ])
            ).rows[0].startyear
          : req.body.startyear,
        req.body.favfood == undefined
          ? await (
              await db.query("SELECT favfood FROM actor WHERE actorid = $1", [
                req.params.id,
              ])
            ).rows[0].favfood
          : req.body.favfood,
        req.body.favcolor == undefined
          ? await (
              await db.query("SELECT favcolor FROM actor WHERE actorid = $1", [
                req.params.id,
              ])
            ).rows[0].favcolor
          : req.body.favcolor,
        req.body.favbook == undefined
          ? await (
              await db.query("SELECT favbook FROM actor WHERE actorid = $1", [
                req.params.id,
              ])
            ).rows[0].favbook
          : req.body.favbook,
      ]
    );
    res.status(200).send("Actor " + req.params.id + " succefully updated.");
  }
});

router.delete("/:id", async (req, res) => {
  if (!Number.isInteger(Number(req.params.id))) {
    res.status(400).send("Actor id must be integer!");
  } else {
    if (
      (await (
        await db.query("SELECT actorid FROM actor WHERE actorid = $1", [
          req.params.id,
        ])
      ).rowCount) == 1
    ) {
      await db.query("DELETE FROM actor WHERE actorid = $1", [req.params.id]);
      res.status(200).send("Actor deleted with id: " + req.params.id);
    } else {
      res
        .status(404)
        .send("Actor with id " + req.params.id + " does not exist.");
    }
  }
});

module.exports = router;
