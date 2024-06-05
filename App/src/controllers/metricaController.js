var jogoModel = require("../models/metricaModel");

function buscarMetricas(req, res) {
    var estufaId = req.params.estufaID;

    jogoModel.buscarMetricas(estufaId)
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

module.exports = {buscarMetricas}