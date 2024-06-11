var database = require("../database/config");

function buscarUltimasMedidas(idEstufa, limite_linhas) {

    var instrucaoSql = `SELECT 
        lei.id,
        lei.temperatura 'Temperatura',
        lei.umidade 'Umidade',
        lei.luminosidade 'Luminosidade',
        lei.DataHora_medida,
        sen.id 'Conjunto Sensores',
        est.id 'Estufa',
                    DATE_FORMAT(DataHora_medida, '%d/%m/%Y - %H:%i') as DataHoraMedida
                    FROM smartfarm.leitura as lei
                    INNER JOIN smartfarm.conjuntoSensores as sen on lei.fk_sensores = sen.id
                    INNER JOIN smartfarm.estufa as est on sen.fk_estufa = est.id
                    WHERE est.id = ${idEstufa}
                    ORDER BY lei.id DESC LIMIT ${limite_linhas}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idEstufa) {

    var instrucaoSql = `SELECT 
    lei.id,
    lei.temperatura 'Temperatura',
    lei.umidade 'Umidade',
    lei.luminosidade 'Luminosidade',
    lei.DataHora_medida,
    sen.id 'Conjunto Sensores',
    est.id 'Estufa',
                DATE_FORMAT(DataHora_medida, '%d/%m/%Y - %H:%i') as DataHoraMedida
                FROM smartfarm.leitura as lei
                INNER JOIN smartfarm.conjuntoSensores as sen on lei.fk_sensores = sen.id
                INNER JOIN smartfarm.estufa as est on sen.fk_estufa = est.id
                WHERE est.id = ${idEstufa}
                ORDER BY lei.id DESC LIMIT 1`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal
}