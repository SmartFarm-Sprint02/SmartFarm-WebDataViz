function carregarInformacoes(){
    
    fetch("/estufas/mostrarQntdEstufas", {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
      }).then(function (resposta) {
        console.log("ESTOU NO THEN DO entrar()!")
  
        if (resposta.ok) {
          console.log(resposta);
  
          resposta.json().then(json => {
            console.log(json);
            console.log(JSON.stringify(json));

            qtd_estufas_empresa.innerHTML = resposta;  
          });
        } else {
          console.log("Houve um erro ao tentar escontrar a quantidade de estufas!");
  
          resposta.text().then(texto => {
            console.error(texto);
            finalizarAguardar(texto);
          });
        }
  
      }).catch(function (erro) {
        console.log(erro);
      })
}