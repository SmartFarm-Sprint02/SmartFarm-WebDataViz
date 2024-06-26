var leituraModel = require("../models/leituraModel");

function buscarUltimasMedidas(req, res) {


    const limite_linhas = 7;
    var idEstufa = req.params.idEstufa;

    console.log(`Recuperando as ultimas ${limite_linhas} leituras`);
    leituraModel.buscarUltimasMedidas(idEstufa, limite_linhas).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas leituras.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function buscarMedidasEmTempoReal(req, res) {

    var idEstufa = req.params.idEstufa;

    console.log(`Recuperando medidas em tempo real`);

    leituraModel.buscarMedidasEmTempoReal(idEstufa).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas leituras.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}



module.exports = {
    buscarUltimasMedidas, buscarMedidasEmTempoReal}