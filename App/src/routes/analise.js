var express = require("express");
var router = express.Router();

var analiseController = require("../controllers/analiseController");

router.get("/qtdAlertasMes/:idEstufa", function (req, res) {
    analiseController.qtdAlertasMes(req, res);
});

router.get("/horariosMaisProblemas/:idEstufa", function (req, res) {
    analiseController.horariosMaisProblemas(req, res);
})

router.get("/qtdAlertasTotais/:idEstufa", function (req, res) {
    analiseController.qtdAlertasTotais(req, res);                    
})

router.get("/graficoHorarios/:idEstufa", function (req, res) {
    analiseController.graficoHorarios(req, res);                    
})

module.exports = router;