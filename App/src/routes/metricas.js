var express = require("express");
var router = express.Router();

var metricaController = require("../controllers/metricaController");

//Recebendo os dados do html e direcionando para a função cadastrar de metricaController.js
router.get("/buscarMetricas/:estufaID", function (req, res) {
    metricaController.buscarMetricas(req, res);
})

router.post("/atualizarTemperatura/:estufaID", function (req, res) {
    metricaController.atualizarTemperatura(req, res);
})

router.post("/atualizarUmidade/:estufaID", function (req, res) {
    metricaController.atualizarUmidade(req, res);
})

router.post("/atualizarLuminosidade/:estufaID", function (req, res) {
    metricaController.atualizarLuminosidade(req, res);
})



module.exports = router;