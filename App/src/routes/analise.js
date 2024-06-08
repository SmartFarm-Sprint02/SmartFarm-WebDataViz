var express = require("express");
var router = express.Router();

var analiseController = require("../controllers/analiseController");

// router.get("/qtdAlertasMes/:idEstufa", function (req, res) {
//     analiseController.qtdAlertasMes(req, res);
// });

router.get("/horarioMaisProblemas/:idEstufa", function (req, res) {
    analiseController.horarioMaisProblemas(req, res);
})

// router.get("/qtdAlertasTotais/:idEstufa", function (req, res) {
//     analiseController.qtdAlertasTotais(req, res);                    
// })


module.exports = router;