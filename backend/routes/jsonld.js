var express = require("express");
var router = express.Router();
const db = require("../db");

router.get("/:id", async (req, res) => {
  if (!Number.isInteger(Number(req.params.id))) {
    res.status(400).send("Actor id must be integer!");
  } else {
    var json = {
      "@context": {
        head: "https://schema.org/Person",
        "@vocab": "http://schema.org/",
        name: "givenName",
        additionalName: "middlename",
        surname: "familyName",
        birthdate: "birthDate",
        birthplace: "birthPlace",
      },
    };
    const data = await db.query(
      "SELECT actor.name, actor.middlename, actor.surname, actor.birthdate, actor.birthplace, actor.height FROM actor WHERE actor.actorid = $1",
      [req.params.id]
    );
    data.rows.unshift(json);
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
