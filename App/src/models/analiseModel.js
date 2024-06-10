var database = require("../database/config");

function qtdAlertasMes(idEstufa) {
  console.log("ACESSEI O ANALISE MODEL para buscar a quantidade de alertas nesse mês, function qtdAlertasMes()", idEstufa);

  var instrucao = `
  SELECT MONTH(DataHora_medida) AS mes,
         COUNT(DataHora_medida) AS quantidade 
FROM leitura WHERE fk_sensores = 1001 AND DataHora_medida BETWEEN '2024-01-01' AND '2024-12-31' GROUP BY mes order by COUNT(DataHora_medida) desc;
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


module.exports = {
  qtdAlertasMes,
  horariosMaisProblemas,
  qtdAlertasTotais
}
