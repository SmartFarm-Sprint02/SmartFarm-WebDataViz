var analiseModel = require("../models/analiseModel");

function qtdAlertasMes(req, res) {
    var idEstufa = req.params.idEstufa;

    analiseModel.qtdAlertasMes(idEstufa).then((resposta) => {
        res.status(200).json(resposta);
    });
}

function horariosMaisProblemas(req, res) {
    var idEstufa = req.params.idEstufa;

    analiseModel.horariosMaisProblemas(idEstufa).then((resposta) => {
        res.status(200).json(resposta);
    });
}

function qtdAlertasTotais(req, res) {
    var idEstufa = req.params.idEstufa;

    analiseModel.qtdAlertasTotais(idEstufa).then((resposta) => {
        res.status(200).json(resposta);
    });
}

module.exports = {
    qtdAlertasMes,
    horariosMaisProblemas,
    qtdAlertasTotais
}