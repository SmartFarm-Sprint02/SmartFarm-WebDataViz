var database = require("../database/config");

// function qtdAlertasMes(idUsuario) {
//   console.log("ACESSEI O ANALISE MODEL para buscar a quantidade de alertas nesse mês, function qtdAlertasMes()", idUsuario);

//   var instrucao = `
//   SELECT MONTH(dataJogo) AS mes FROM qtdJogos WHERE fkUsuario = ${idUsuario} AND dataJogo BETWEEN '2024-01-01' AND '2024-12-31' GROUP BY mes order by COUNT(idJogo) desc limit 1;`;

//   console.log("Executando a instrução SQL: \n" + instrucao);
//   return database.executar(instrucao);
// }

function horarioMaisProblemas(fk_sensores) {
  console.log("ACESSEI O ANALISE MODEL para buscar o período que mais teve alertas, function horariosMaisProblemas()", fk_sensores);

  var instrucao = `
select count(*) 'quantidade'
from leitura lei
inner join conjuntoSensores coSe on lei.fk_sensores = coSe.id
inner join estufa est on est.id = coSe.fk_estufa
where lei.fk_sensores = ${fk_sensores};`;

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
  horarioMaisProblemas,
  // qtdAlertasTotais
}
