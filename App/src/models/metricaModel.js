var database = require("../database/config");

function buscarMetricas(estufaID) {

    var instrucaoSql = `
    SELECT * FROM smartfarm.metricas
    WHERE fk_estufa = ${estufaID};
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarMetricas
}
