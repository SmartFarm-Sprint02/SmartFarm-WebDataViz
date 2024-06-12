var database = require("../database/config");

function qtdAlertasMes(idEstufa) {
  console.log("ACESSEI O ANALISE MODEL para buscar a quantidade de alertas nesse mês, function qtdAlertasMes()", idEstufa);

  var instrucao = `
SELECT
    MONTH(lei.DataHora_medida) AS mes,
    COUNT(*) AS quantidade
FROM leitura lei
JOIN conjuntoSensores cs ON lei.fk_sensores = cs.id
JOIN estufa est ON cs.fk_estufa = est.id
JOIN metricas met ON est.id = met.fk_estufa
WHERE (lei.temperatura < met.TempMinima OR lei.temperatura > met.TempMaxima
    OR lei.umidade < met.UmidMinima OR lei.umidade > met.UmidMaxima
    OR lei.luminosidade < met.LuminMinima OR lei.luminosidade > met.LuminMaxima)
    AND est.id = ${idEstufa}
     AND MONTH(lei.DataHora_medida) = MONTH(CURRENT_DATE)
GROUP BY mes
ORDER BY quantidade DESC
LIMIT 1;
`;

  console.log("Executando a instrução SQL: \n" + instrucao);
  return database.executar(instrucao);
}

function horariosMaisProblemas(idEstufa) {
  console.log("ACESSEI O ANALISE MODEL para buscar o período que mais teve alertas, function horariosMaisProblemas()", idEstufa);

  var instrucao = `SELECT 
	periodo,
    COUNT(*) AS quantidade
    FROM (
      SELECT
        lei.id,
        CASE
            WHEN HOUR(lei.DataHora_medida) BETWEEN 0 AND 5 THEN 'Madrugada'
            WHEN HOUR(lei.DataHora_medida) BETWEEN 6 AND 11 THEN 'Manhã'
            WHEN HOUR(lei.DataHora_medida) BETWEEN 12 AND 17 THEN 'Tarde'
            WHEN HOUR(lei.DataHora_medida) BETWEEN 18 AND 23 THEN 'Noite'
        END AS periodo
    FROM leitura lei
    JOIN conjuntoSensores cs ON lei.fk_sensores = cs.id
    JOIN estufa est ON cs.fk_estufa = est.id
    JOIN metricas met ON est.id = met.fk_estufa
    WHERE (lei.temperatura < met.TempMinima OR lei.temperatura > met.TempMaxima
        OR lei.umidade < met.UmidMinima OR lei.umidade > met.UmidMaxima
        OR lei.luminosidade < met.LuminMinima OR lei.luminosidade > met.LuminMaxima)
        AND est.id = ${idEstufa}
) AS subquery
GROUP BY periodo
ORDER BY periodo DESC LIMIT 1;   
`;

  console.log("Executando a instrução SQL: \n" + instrucao);
  return database.executar(instrucao);
}

function qtdAlertasTotais(idEstufa) {
  console.log("ACESSEI O ANALISE MODEL para buscar a quantidade de alertas no total, function qtdAlertasTotais()", idEstufa);

  var instrucao = `
  SELECT
    COUNT(*) AS quantidade
    FROM (
    SELECT
        lei.id
    FROM leitura lei
    JOIN conjuntoSensores cs ON lei.fk_sensores = cs.id
    JOIN estufa est ON cs.fk_estufa = est.id
    JOIN metricas met ON est.id = met.fk_estufa
    WHERE (lei.temperatura < met.TempMinima OR lei.temperatura > met.TempMaxima
        OR lei.umidade < met.UmidMinima OR lei.umidade > met.UmidMaxima
        OR lei.luminosidade < met.LuminMinima OR lei.luminosidade > met.LuminMaxima)
        AND est.id = ${idEstufa}
) AS subquery;
`;

  console.log("Executando a instrução SQL: \n" + instrucao);
  return database.executar(instrucao);
}

function graficoHorarios(idEstufa) {
  console.log("ACESSEI O ANALISE MODEL para montar o grafico de horas, function graficoHorarios()", idEstufa);

  var instrucao = `
SELECT 
	periodo,
    COUNT(*) AS quantidade
    FROM (
      SELECT
        lei.id,
        CASE
            WHEN HOUR(lei.DataHora_medida) BETWEEN 0 AND 5 THEN 'Madrugada'
            WHEN HOUR(lei.DataHora_medida) BETWEEN 6 AND 11 THEN 'Manhã'
            WHEN HOUR(lei.DataHora_medida) BETWEEN 12 AND 17 THEN 'Tarde'
            WHEN HOUR(lei.DataHora_medida) BETWEEN 18 AND 23 THEN 'Noite'
        END AS periodo
    FROM leitura lei
    JOIN conjuntoSensores cs ON lei.fk_sensores = cs.id
    JOIN estufa est ON cs.fk_estufa = est.id
    JOIN metricas met ON est.id = met.fk_estufa
    WHERE (lei.temperatura < met.TempMinima OR lei.temperatura > met.TempMaxima
        OR lei.umidade < met.UmidMinima OR lei.umidade > met.UmidMaxima
        OR lei.luminosidade < met.LuminMinima OR lei.luminosidade > met.LuminMaxima)
        AND est.id = ${idEstufa}
) AS subquery
GROUP BY periodo;`;

  console.log("Executando a instrução SQL: \n" + instrucao);
  return database.executar(instrucao);
}

function graficoProblemasMes(idEstufa) {
  console.log("ACESSEI O ANALISE MODEL para montar o grafico de problemas em cada mês, function graficoHorarios()", idEstufa);

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
    AND est.id = ${idEstufa}
GROUP BY mes, ano
ORDER BY mes DESC LIMIT 6;
`;

  console.log("Executando a instrução SQL: \n" + instrucao);
  return database.executar(instrucao);
}

module.exports = {
  qtdAlertasMes,
  horariosMaisProblemas,
  qtdAlertasTotais,
  graficoHorarios,
  graficoProblemasMes
}
