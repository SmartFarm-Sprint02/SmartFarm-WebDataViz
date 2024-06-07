// var analiseModel = require("../models/analiseModel");

// function qtdAlertasMes(req, res) {

//     const limite_linhas = 7;

//     var idEstufa = req.params.idEstufa;

//     console.log(`Recuperando as ultimas ${limite_linhas} medidas`);

//     analiseModel.qtdAlertasMes(idEstufa, limite_linhas).then(function (resultado) {
//         if (resultado.length > 0) {
//             res.status(200).json(resultado);
//         } else {
//             res.status(204).send("Nenhum resultado encontrado!")
//         }
//     }).catch(function (erro) {
//         console.log(erro);
//         console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
//         res.status(500).json(erro.sqlMessage);
//     });
// }


// function horarioMaisProblemas(req, res) {

//     var idEstufa = req.params.idEstufa;

//     console.log(`Recuperando medidas em tempo real`);

//     analiseModel.horarioMaisProblemas(idEstufa).then(function (resultado) {
//         if (resultado.length > 0) {
//             res.status(200).json(resultado);
//         } else {
//             res.status(204).send("Nenhum resultado encontrado!")
//         }
//     }).catch(function (erro) {
//         console.log(erro);
//         console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
//         res.status(500).json(erro.sqlMessage);
//     });
// }

// function qtdAlertasTotais(req, res) {

//     var idEstufa = req.params.idEstufa;

//     console.log(`Recuperando medidas em tempo real`);

//     analiseModel.qtdAlertasTotais(idEstufa).then(function (resultado) {
//         if (resultado.length > 0) {
//             res.status(200).json(resultado);
//         } else {
//             res.status(204).send("Nenhum resultado encontrado!")
//         }
//     }).catch(function (erro) {
//         console.log(erro);
//         console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
//         res.status(500).json(erro.sqlMessage);
//     });
// }

// module.exports = {
//     qtdAlertasMes,
//     horarioMaisProblemas,
//     qtdAlertasTotais
// }