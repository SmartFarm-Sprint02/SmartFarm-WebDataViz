var metricaModel = require("../models/metricaModel");

function buscarMetricas(req, res) {
    var estufaId = req.params.estufaID;

    metricaModel.buscarMetricas(estufaId)
        .then(
            function (resultadoBuscarMetricas) {
                console.log(`\nResultados encontrados: ${resultadoBuscarMetricas.length}`);
                console.log(`Resultados: ${JSON.stringify(resultadoBuscarMetricas)}`); // transforma JSON em String

                if (resultadoBuscarMetricas.length > 0) {
                    console.log(resultadoBuscarMetricas);

                    res.json(resultadoBuscarMetricas);

                } else if (resultadoBuscarMetricas.length == 0) {
                    res.status(403).send("Erro ao buscar as métricas");
                } else {
                    res.status(403).send("Erro buscando varias métricas.");
                }
            }
        ).catch(
            function (erro) {
                console.log(erro);
                console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        );
}


function atualizarTemperatura(req, res) {
    var estufaId = req.params.estufaID;
    var tempMaxima = req.body.temperaturaMaximaServer;
    var tempMinima = req.body.temperaturaMinimaServer;

    if (!tempMaxima || !tempMinima || !estufaId) {
        return res.status(400).send("Parâmetros inválidos");
    }

    metricaModel.atualizarTemperatura(tempMinima, tempMaxima, estufaId)
        .then(function (resultadoAtualizarTemperatura) {
            console.log(resultadoAtualizarTemperatura);

            if (resultadoAtualizarTemperatura.affectedRows > 0) {
                res.json({ message: "Temperaturas atualizadas com sucesso" });
            } else {
                res.status(403).send("Erro ao atualizar as temperaturas");
            }
        })
        .catch(function (erro) {
            console.log(erro);
            console.log("Houve um erro ao atualizar a temperatura! Erro: ", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}


function atualizarUmidade(req, res) {
    var estufaId = req.params.estufaID;
    var umidMaxima = req.body.umidadeMaximaServer;
    var umidMinima = req.body.umidadeMinimaServer;

    if (!umidMaxima || !umidMinima || !estufaId) {
        return res.status(400).send("Parâmetros inválidos");
    }

    metricaModel.atualizarUmidade(umidMinima, umidMaxima, estufaId)
        .then(function (resultadoAtualizarUmidade) {
            console.log(resultadoAtualizarUmidade);

            if (resultadoAtualizarUmidade.affectedRows > 0) {
                res.json({ message: "Umidades atualizadas com sucesso" });
            } else {
                res.status(403).send("Erro ao atualizar as umidades");
            }
        })
        .catch(function (erro) {
            console.log(erro);
            console.log("Houve um erro ao atualizar a umidade! Erro: ", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}



function atualizarLuminosidade(req, res) {
    var estufaId = req.params.estufaID;
    var lumiMaxima = req.body.luminosidadeMaximaServer;
    var lumiMinima = req.body.luminosidadeMinimaServer;

    if (!lumiMaxima || !lumiMinima || !estufaId) {
        return res.status(400).send("Parâmetros inválidos");
    }

    metricaModel.atualizarLuminosidade(lumiMinima, lumiMaxima, estufaId)
        .then(function (resultadoAtualizarLuminosidade) {
            console.log(resultadoAtualizarLuminosidade);

            if (resultadoAtualizarLuminosidade.affectedRows > 0) {
                res.json({ message: "Luminosidades atualizadas com sucesso" });
            } else {
                res.status(403).send("Erro ao atualizar as luminosidades");
            }
        })
        .catch(function (erro) {
            console.log(erro);
            console.log("Houve um erro ao atualizar a luminosidades! Erro: ", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}


module.exports = { 
    buscarMetricas,
    atualizarTemperatura,
    atualizarUmidade,
    atualizarLuminosidade
    }