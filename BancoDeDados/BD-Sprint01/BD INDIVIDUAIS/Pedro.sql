CREATE TABLE Estufas (
    idEstufas INT PRIMARY KEY,
    nome VARCHAR(100),
    capacidade INT,
    Pimentão VARCHAR(30) CHECK (tipo in('verde', 'vermelho', 'amarelo')),
    peso DECIMAL(5,2),
    preco DECIMAL(8,2),
    qtdPimentão int,
    qtdEstufas int,
    fkEmpresa int,
   constraint fk_Estufa_Empresa foreign key (empresa_id) references Empresa(idEmpresa)
);
insert into Estufas(idEstufa,nome,capacidade,pimentão,peso,preco,qtdPimentão,qtdEstufas,empresa_id)
Values(1,'Estufa 1',5,'Vermelho', '1,25kg', 'R$ 9 por Kg',5,2,1),
(2,'Estufa 2',8,'Verde', '1,84kg', 'R$ 11,49 por Kg.',8,4,2),
(3,'Estufa 3',6,'Amarelo', '1,56kg', 'R$ 15,98 por Kg',6,5,3);

-- Tabela Empresa
CREATE TABLE Empresa (
    idEmpresa INT PRIMARY KEY,
    nome VARCHAR(100),
    razão_social Varchar(50),
    cnpj VARCHAR(14),
	telefone VARCHAR(20),
	email VARCHAR(50),
	cidade VARCHAR(100),
    qtdEstufas INT,
    constraint fk_Empresa_Estufa foreign key (estufa_id) references Estufa(idEstufa)
);
insert into Empresa(idEmpresa,nome ,razão_social,cnpj,telefone ,email ,cidade,endereco,qtdEstufas,estufa_id )
values(1,'EmpresaResk','Resk','59 438 908',98062-8798,'resk.empresa@gmail.com','São Paulo',2,1),
(2,'EmpresaTechFarm','TechFarm','70 491 258',99622-8618,'techfarm.empresa@gmail.com','São Paulo',4,2),
(3,'EmpresaDasFrutas','As Frutas','90 788 408',97022-8592,'frutas.empresa@gmail.com','São Paulo',5,3);


CREATE TABLE Clientes (
    idClientes INT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(255),
    telefone VARCHAR(20),
    cidade VARCHAR(100),
    estado VARCHAR(50),
    cep VARCHAR(10)
);
insert into Clientes(idClientes,nome ,email,telefone ,cidade,estado,cep)
values(1,'João','joão.pedro@gmail.com','90984-7641','São Paulo','São Paulo','78093-080'),
(2,'Felipe','felipe.rodovalho@gmail.com',96875-8054,'São Paulo','São Paulo',89321-072),
(3,'Kaio','kaio.angelo@gmail.com',95654-8701,'São Paulo','São Paulo',69342-083);


create table sensor(
idSensor int Primary key,
tipo_sensor1 varchar(40),
tipo_sensor2 varchar(40),
tipo_sensor3 varchar(40),
fkEstufa int,
constraint fk_sensor_Estufa foreign key (estufa_id) references Estufa(idEstufa)

);
insert into sensor(idSensor,tipo_sensor1,tipo_sensor2,tipo_sensor3,estufa_id)
values(1,'umidade','temperatura','luminosidade',1),
(2,'umidade','temperatura','luminosidade',2),
(3,'umidade','temperatura','luminosidade',3);





    
    