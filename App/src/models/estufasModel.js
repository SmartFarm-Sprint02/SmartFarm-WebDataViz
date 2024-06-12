var database = require("../database/config");

function buscarEstufasPorEmpresa(token) {

    var instrucaoSql = `select * from smartfarm.estufa WHERE fk_empresa = ${token}`;


    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listar() {
    var instrucao = `
        SELECT * FROM estufa;
        `;
    console.log("Executando" + instrucao);

    return database.executar(instrucao);
}

function cadastrar(nome) {
    var instrucao = `
    INSERT INTO estufa (nome) VALUES ('${nome}');
    `;
    console.log("Executando" + instrucao);

    return database.executar(instrucao);

}

function graficoProblemasTotaisMes(token) {
    console.log("ACESSEI O ANALISE MODEL para montar o grafico de problemas em cada mês, function graficoProblemasTotaisMes()", token);

    var instrucao = `
  SELECT
      DATE_FORMAT(lei.DataHora_medida, '%m') AS mes,
      DATE_FORMAT(lei.DataHora_medida, '%y') AS ano,
      COUNT(*) AS quantidade
  FROM leitura lei
  JOIN conjuntoSensores cs ON lei.fk_sensores = cs.id
  JOIN estufa est ON cs.fk_estufa = est.id
  JOIN metricas met ON est.id = met.fk_estufa
  WHERE (lei.temperatura < met.TempMinima OR lei.temperatura > met.TempMaxima
      OR lei.umidade < met.UmidMinima OR lei.umidade > met.UmidMaxima
      OR lei.luminosidade < met.LuminMinima OR lei.luminosidade > met.LuminMaxima)
      AND est.fk_empresa = ${token}
  GROUP BY mes, ano
  ORDER BY mes DESC LIMIT 4;
  `;

    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function KPIProblemasMes(token) {
    console.log("ACESSEI O ANALISE MODEL para buscar a quantidade de alertas nesse mês, function KPIProblemasMes()", token);

    var instrucao = `
  SELECT 
    COUNT(DISTINCT est.id) AS quantidade
FROM leitura lei
JOIN conjuntoSensores cs ON lei.fk_sensores = cs.id
JOIN estufa est ON cs.fk_estufa = est.id
JOIN metricas met ON est.id = met.fk_estufa
WHERE (lei.temperatura < met.TempMinima OR lei.temperatura > met.TempMaxima
    OR lei.umidade < met.UmidMinima OR lei.umidade > met.UmidMaxima
    OR lei.luminosidade < met.LuminMinima OR lei.luminosidade > met.LuminMaxima)
    AND est.fk_empresa = ${token}
    AND MONTH(lei.DataHora_medida) = MONTH(CURRENT_DATE);
  `;

    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function KPIProblemasTotais(token) {
    console.log("ACESSEI O ANALISE MODEL para buscar a quantidade de alertas no total, function KPIProblemasTotais()", token);

    var instrucao = `
SELECT 
    COUNT(DISTINCT est.id) AS quantidade
FROM leitura lei
JOIN conjuntoSensores cs ON lei.fk_sensores = cs.id
JOIN estufa est ON cs.fk_estufa = est.id
JOIN metricas met ON est.id = met.fk_estufa
WHERE (lei.temperatura < met.TempMinima OR lei.temperatura > met.TempMaxima
    OR lei.umidade < met.UmidMinima OR lei.umidade > met.UmidMaxima
    OR lei.luminosidade < met.LuminMinima OR lei.luminosidade > met.LuminMaxima)
    AND est.fk_empresa = ${token};
  `;

    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function graficoProblemasDiarios(token) {
    console.log("ACESSEI O ANALISE MODEL para montar o grafico de problemas em cada dia, function graficoProblemasDiarios()", token);

    var instrucao = `
SELECT
	dia,
    mes,
    COUNT(*) AS quantidade
FROM (
    SELECT
		DATE_FORMAT(lei.DataHora_medida, '%d') AS dia,
		DATE_FORMAT(lei.DataHora_medida, '%m') AS mes        
    FROM leitura lei
    JOIN conjuntoSensores cs ON lei.fk_sensores = cs.id
    JOIN estufa est ON cs.fk_estufa = est.id
    JOIN metricas met ON est.id = met.fk_estufa
    WHERE (lei.temperatura < met.TempMinima OR lei.temperatura > met.TempMaxima
        OR lei.umidade < met.UmidMinima OR lei.umidade > met.UmidMaxima
        OR lei.luminosidade < met.LuminMinima OR lei.luminosidade > met.LuminMaxima)
        AND est.id = 501
) AS subquery
GROUP BY dia, mes
ORDER BY mes DESC, dia DESC LIMIT 7;`;

    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}


module.exports = {
    cadastrar,
    listar,
    buscarEstufasPorEmpresa,
    graficoProblemasTotaisMes,
    graficoProblemasDiarios,
    KPIProblemasMes,
    KPIProblemasTotais
};