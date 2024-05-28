var database = require("../database/config");

  function buscarNomeEmpresa(email, nome){
    console.log(nome, email);
          var instrucaoSql = `select 
                          em.nome_fantasia as nomeEm
                          from smartfarm.empresa as em
                          inner join smartfarm.usuario as usu ON usu.fk_empresa = em.id
                          where usu.email = ? and usu.nome = ?;`
            
      return database.executar(instrucaoSql, [email, nome]);
  }



// function buscarPorId(id) {
//   var instrucaoSql = `SELECT * FROM empresa WHERE id = '${id}'`;

//   return database.executar(instrucaoSql);
// }

// function listar() {
//   var instrucaoSql = `SELECT * FROM empresa`;

//   return database.executar(instrucaoSql);
// }

// function buscarPorCnpj(cnpj) {
//   var instrucaoSql = `SELECT * FROM empresa WHERE cnpj = '${cnpj}'`;

//   return database.executar(instrucaoSql);
// }

// function cadastrar(razaoSocial, cnpj) {
//   var instrucaoSql = `INSERT INTO empresa (razao_social, cnpj) VALUES ('${razaoSocial}', '${cnpj}')`;

//   return database.executar(instrucaoSql);
// }

module.exports = {buscarNomeEmpresa};
