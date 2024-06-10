var database = require("../database/config");

// function qtdAlertasMes(idUsuario) {
//   console.log("ACESSEI O ANALISE MODEL para buscar a quantidade de alertas nesse mês, function qtdAlertasMes()", idUsuario);

//   var instrucao = `
//   SELECT MONTH(dataJogo) AS mes FROM qtdJogos WHERE fkUsuario = ${idUsuario} AND dataJogo BETWEEN '2024-01-01' AND '2024-12-31' GROUP BY mes order by COUNT(idJogo) desc limit 1;`;

//   console.log("Executando a instrução SQL: \n" + instrucao);
//   return database.executar(instrucao);
// }

function horariosMaisProblemas(idLeitura, periodo) {
  console.log("ACESSEI O ANALISE MODEL para buscar o período que mais teve alertas, function horariosMaisProblemas()", idLeitura, periodo);

  var instrucao = `select * from alertas_leituras;`;

  console.log("Executando a instrução SQL: \n" + instrucao);
  return database.executar(instrucao);
}

// function qtdAlertasTotais(idUsuario) {
//   console.log("ACESSEI O ANALISE MODEL para buscar a quantidade de alertas no total, function qtdAlertasTotais()", idUsuario);

//   var instrucao = `
//   SELECT MONTH(dataJogo) AS mes FROM qtdJogos WHERE fkUsuario = ${idUsuario} AND dataJogo BETWEEN '2024-01-01' AND '2024-12-31' GROUP BY mes order by COUNT(idJogo) desc limit 1;`;

//   console.log("Executando a instrução SQL: \n" + instrucao);
//   return database.executar(instrucao);
// }


module.exports = {
  // qtdAlertasMes,
  horariosMaisProblemas,
  // qtdAlertasTotais
}
