// sessão
function validarSessao() {
    var email = sessionStorage.EMAIL_USUARIO;
    var nome = (sessionStorage.NOME_USUARIO);
    var nomeEmpresa = sessionStorage.NOME_EMPRESA;

    console.log(email + " " + nome);
    // o console está mostrando certo os dados
    var b_usuario = document.getElementById("b_usuario");
    var b_empresa = document.getElementById("nome_empresa");

    



    // no if estamos entendendo que não está nulo
    if (email != null && nome != null && nomeEmpresa != null) {
        b_usuario.innerHTML = nome;
        b_empresa.innerHTML = nomeEmpresa;
        


        // fetch("/empresas/buscarNome", {
        //     method: "post",
        //     headers: {
        //         "Content-Type": "application/json"
        //     },
        //     body: JSON.stringify({
        //         emailServer: email,
        //         nomeServer: nome   
        //     })
        // }).then(function (resposta) {
        //     console.log("resposta: ", resposta);
        //     if (resposta.ok) {
        //         resposta.json().then(json => {
        //             console.log(json);
        //         }).catch(function (erro) {
        //             console.log("Erro ao converter resposta para JSON: ", erro);
        //         });
        //     } else {
        //         console.log("Erro na resposta do servidor: ", resposta.statusText);
        //     }
        // }).catch(function (erro) {
        //     console.log("Erro na requisição: ", erro);
        // });

    } else {
        window.location = "../../Login/login.html";
    }
}

function limparSessao() {
    sessionStorage.clear();
    window.location = "../../CTA.html";
}

// carregamento (loading)
function aguardar() {
    var divAguardar = document.getElementById("div_aguardar");
    divAguardar.style.display = "flex";
}

function finalizarAguardar(texto) {
    var divAguardar = document.getElementById("div_aguardar");
    divAguardar.style.display = "none";

    var divErrosLogin = document.getElementById("div_erros_login");
    if (texto) {
        divErrosLogin.style.display = "flex";
        divErrosLogin.innerHTML = texto;
    }
}
