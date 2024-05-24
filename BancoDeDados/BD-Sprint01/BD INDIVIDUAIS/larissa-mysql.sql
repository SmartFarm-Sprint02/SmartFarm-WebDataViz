create database SmartFarm;
use SmartFarm;


CREATE TABLE Cliente(
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    cpf VARCHAR(14),
    data_nascimento DATE,
    genero varchar(20),
    telefone VARCHAR(20),
    email VARCHAR(30),
    idEmpresa INT,
    FOREIGN KEY (idEmpresa) REFERENCES Empresa(idEmpresa)
);

CREATE TABLE Empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    diretor VARCHAR(50),
    email VARCHAR(30),
    telefone VARCHAR(20),
    cep VARCHAR(10),
    rua VARCHAR(50),
    estado VARCHAR(20),
    pais VARCHAR(10)
);


CREATE TABLE Sensores (
    idSensores INT AUTO_INCREMENT PRIMARY KEY,
    temperatura DECIMAL(10,2),
    luminosidade DECIMAL(10,2),
    umidade DECIMAL(10,2)
);


CREATE TABLE Instalacao (
    idInstalacao INT AUTO_INCREMENT PRIMARY KEY,
    dia_instalacao DATE,
    local VARCHAR(50),
    porte_estufa VARCHAR(50),
    nome_instaladores VARCHAR(200)
);


CREATE TABLE Financas (
    idFinancas INT AUTO_INCREMENT PRIMARY KEY,
    data_pedido DATE,
    metodo_pagamento VARCHAR(50),
    parcelamento VARCHAR(50)
);


INSERT INTO Empresa (nome, diretor, email, telefone, cep, rua, estado, pais) VALUES
('Empresa A', 'João Diretor', 'joao@empresaabc.com', '123456789', '12345-678', 'Rua A', 'Estado X', 'País Y'),
('Empresa X', 'Maria Diretora', 'maria@empresaxyz.com', '987654321', '98765-432', 'Avenida B', 'Estado Z', 'País W');


INSERT INTO Cliente (nome, cpf, data_nascimento, genero, telefone, email, idEmpresa) VALUES
('Fernando costa', '123.456.789-00', '1990-05-15', 'Masculino', '9999-8888', 'fernando.costa@gmail.com', 1),
('vanessa vivian', '987.654.321-00', '1985-10-20', 'Feminino', '7777-6666', 'vanessa.vivian@gmail.com', 2);


INSERT INTO Sensores (temperatura, luminosidade, umidade) VALUES
(25.5, 800, 60),
(27.8, 700, 55);

INSERT INTO Instalacao (dia_instalacao, local, porte_estufa, nome_instaladores) VALUES
('2024-01-10', 'Local A', 'Grande', 'Equipe 1'),
('2024-02-20', 'Local B', 'Pequeno', 'Equipe 4');


INSERT INTO Financas (data_pedido, metodo_pagamento, parcelamento) VALUES
('2024-01-05', 'Cartão de Crédito', '2x sem juros'),
('2024-02-15', 'Boleto Bancário', 'À vista');

select * from cliente;
select * from empresa;
select * from sensores;
select * from financas;
select * from instalacao;


