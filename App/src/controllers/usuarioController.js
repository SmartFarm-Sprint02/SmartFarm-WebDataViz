var usuarioModel = require("../models/usuarioModel");
var estufasModel = require("../models/estufasModel");
var empresaModel = require("../models/empresaModel");

function autenticar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else {

        usuarioModel.autenticar(email, senha)
            .then(
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String
                    console.log(resultadoAutenticar);
                    if (resultadoAutenticar.length == 1) {


                        estufasModel.buscarEstufasPorEmpresa(resultadoAutenticar[0].token)
                            .then((resultadoEstufas) => {
                                if (resultadoEstufas.length > 0) {
                                    res.json({
                                        idUsuario: resultadoAutenticar[0].idUsuario,
                                        emailUsuario: resultadoAutenticar[0].emailUsuario,
                                        nomeUsuario: resultadoAutenticar[0].nomeUsuario,
                                        senhaUsuario: resultadoAutenticar[0].senhaUsuario,
                                        nome_fantasia: resultadoAutenticar[0].nome_fantasia,
                                        token: resultadoAutenticar[0].token,
                                        estufas: resultadoEstufas,
                                    });
                                } else {
                                    res.status(204).json({ estufas: [] });
                                }
                            })
                    } else if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Email e/ou senha inválido(s)");
                    } else {
                        res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

function cadastrar(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var nome = req.body.nomeServer;
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;
    var mensagem = req.body.mensagemServer;
    var token = req.body.tokenServer;

    // Faça as validações dos valores
    if (nome == undefined) {
        res.status(400).send("Seu nome está undefined!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está undefined!");
    } else if (mensagem == undefined) {
        res.status(400).send("Sua mensagem está undefined!");
    } else if (token == undefined) {
        res.status(400).send("Seu token está undefined!");
    } else {

        // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
        usuarioModel.cadastrar(nome, email, senha, mensagem, token)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}





function lembrarSenha(req, res) {
    var email = req.body.emailServer;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else {

        usuarioModel.lembrarSenha(email)
            .then(
                function (resultadoLembrarSenha) {
                    console.log(`\nResultados encontrados: ${resultadoLembrarSenha.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoLembrarSenha)}`); // transforma JSON em String
                    console.log(resultadoLembrarSenha);
                    if (resultadoLembrarSenha.length == 1) {
                        res.json(resultadoLembrarSenha);
                    } else if (resultadoLembrarSenha.length == 0) {
                        res.status(403).send("Email não cadastrado, ou usuário não cadastrou mensagem.");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

module.exports = {
    autenticar,
    cadastrar,
    lembrarSenha
}