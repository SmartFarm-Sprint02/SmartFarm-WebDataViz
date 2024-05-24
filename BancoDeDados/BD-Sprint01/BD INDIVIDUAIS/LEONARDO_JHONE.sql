CREATE DATABASE SMARTFARM;

use SMARTFARM;

CREATE TABLE empresas (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    CNPJ CHAR(15) NOT NULL,
    nome VARCHAR(45) NOT NULL,
    telefone varchar (15) null,
    endereco varchar (150) not null,
    email varchar (45),
    qtd_estufas INT NOT NULL
);

insert into empresas(CNPJ, nome, telefone, endereco, email, qtd_estufas)
values (23545579000231 , 'FarmTech', '11927839874','avenida chico mendes 31 - sp' , 'FarmTech@gmail.com', 1);
		
select * from empresas;

CREATE TABLE usuarios (
    idUsuario INT PRIMARY KEY auto_increment, 
    nome VARCHAR(50)not null,
	CPF char (14) not null,
    senha VARCHAR(8) not null,
    email VARCHAR(40) not null,
    fk_empresas int not null,
    CONSTRAINT fk_usuarios_empresas FOREIGN KEY (fk_empresas)
        REFERENCES empresas (idEmpresa)
) auto_increment = 100;

insert into usuarios(nome, CPF, senha, email,fk_empresas) 
values ('Leonardo J N Silva', '502.489.984-09','senha123', 'leonardojhone@gmail.com', '1');
		
select * from usuarios;

CREATE TABLE estufas (
    idEstufa INT PRIMARY KEY AUTO_INCREMENT,
    tipoPimentao varchar(20),
    qtd_pimentoes INT NOT NULL,
	fk_empresas INT NOT NULL,
    CONSTRAINT fk_empresas_estufas FOREIGN KEY (fk_empresas)
        REFERENCES empresas (idEmpresa)
)AUTO_INCREMENT=500; 

insert into estufas(tipoPimentao, qtd_pimentoes, fk_empresas)
values ('vermelho', 567, 1);
	
select * from estufas;

 create table sensores(
id int primary key auto_increment,
codigo varchar (20), 
fk_estufas int,
constraint fk_sensores_estufas foreign key (fk_estufas) references estufas (idEstufa)
)auto_increment = 1000;

insert into sensores(codigo, fk_estufas)
values ('TF456', 500);
		

 select * from sensores;

CREATE TABLE leituras (
    idLeitura INT PRIMARY KEY AUTO_INCREMENT,
    temperatura DECIMAL(4 , 2 ) NOT NULL,
    umidade DECIMAL(4 , 2 ) NOT NULL,
    luminosidade DECIMAL(8 , 2 ) NOT NULL,
    fk_estufas INT NOT NULL,
    DataHora_medida TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fk_sensores int,
   CONSTRAINT fk_leituras_estufas FOREIGN KEY (fk_estufas) REFERENCES estufas (idEstufa)

)AUTO_INCREMENT=2000;


insert into leituras(temperatura, umidade, luminosidade, fk_estufas, fk_sensores)
values (27.5, 65, 7567.00, 500, 1000);
		

select * from leituras;