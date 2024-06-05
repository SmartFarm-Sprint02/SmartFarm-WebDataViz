var express = require("express");
var router = express.Router();

var metricaController = require("../controllers/metricaController");

//Recebendo os dados do html e direcionando para a função cadastrar de metricaController.js
router.get("/buscarMetricas/:estufaID", function (req, res) {
    metricaController.buscarMetricas(req, res);
})



module.exports = router;