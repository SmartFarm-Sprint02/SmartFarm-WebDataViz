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

function graficoHorarios(req, res) {
    var idEstufa = req.params.idEstufa;

    analiseModel.graficoHorarios(idEstufa)
        .then(
            function (resultado) {
                if (resultado.length > 0) {
                    res.status(200).json(resultado);
                } else {
                    res.status(204).send("Nenhum resultado encontrado!");
                }
            }
        )
        .catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "Houve um erro",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function graficoProblemasMes(req, res) {
    var idEstufa = req.params.idEstufa;

    analiseModel.graficoProblemasMes(idEstufa)
        .then(
            function (resultado) {
                if (resultado.length > 0) {
                    res.status(200).json(resultado);
                } else {
                    res.status(204).send("Nenhum resultado encontrado!");
                }
            }
        )
        .catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "Houve um erro",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}


module.exports = {
    qtdAlertasMes,
    horariosMaisProblemas,
    qtdAlertasTotais,
    graficoHorarios,
    graficoProblemasMes,
}