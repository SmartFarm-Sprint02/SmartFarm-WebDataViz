var database = require("../database/config");

function buscarMetricas(estufaID) {

    var instrucaoSql = `
    SELECT * FROM smartfarm.metricas
    WHERE fk_estufa = ${estufaID};
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function atualizarTemperatura(tempMinima, tempMaxima, estufaID) {

    var instrucaoSql = `
    update smartfarm.metricas set TempMinima = '${tempMinima}', TempMaxima = '${tempMaxima}' where fk_estufa = ${estufaID};
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


function atualizarUmidade(umidMinima, umidMaxima, estufaID) {

    var instrucaoSql = `
    update smartfarm.metricas set UmidMinima = '${umidMinima}', UmidMaxima = '${umidMaxima}' where fk_estufa = ${estufaID};
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function atualizarLuminosidade(lumiMinima, lumiMaxima, estufaID) {

    var instrucaoSql = `
    update smartfarm.metricas set LuminMinima = '${lumiMinima}', LuminMaxima = '${lumiMaxima}' where fk_estufa = ${estufaID};
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


module.exports = {
    buscarMetricas,
    atualizarTemperatura,
    atualizarUmidade,
    atualizarLuminosidade
}
