var express = require("express");
var router = express.Router();

var estufasController = require ("../controllers/estufasController");

router.get("/:token", function(req, res){
  estufasController.buscarEstufasPorEmpresa(req, res);
});

router.post("/cadastrar", function (req, res) {
    estufasController.cadastrar(req, res);
});

router.get("/graficoProblemasTotaisMes/:token", function(req, res){
  estufasController.graficoProblemasTotaisMes(req, res);
});

router.get("/KPIProblemasMes/:token", function(req, res){
  estufasController.KPIProblemasMes(req, res);
});

router.get("/KPIProblemasTotais/:token", function(req, res){
  estufasController.KPIProblemasTotais(req, res);
});

router.get("/graficoProblemasDiarios/:token", function(req, res){
  estufasController.graficoProblemasDiarios(req, res);
});


module.exports = router;