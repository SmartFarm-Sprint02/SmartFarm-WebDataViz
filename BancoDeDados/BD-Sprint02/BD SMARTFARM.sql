
CREATE DATABASE smartfarm;


use smartfarm;

CREATE TABLE endereco (
idEndereco INT PRIMARY KEY AUTO_INCREMENT,
logradouro VARCHAR(45) NOT NULL,
numero INT NOT NULL,
complemento VARCHAR(20) NULL,
bairro VARCHAR(45) NOT NULL,
CEP CHAR(9) NOT NULL,
cidade VARCHAR(45) NOT NULL,
estado CHAR(2) NOT NULL
) auto_increment = 100;

insert into endereco (logradouro, numero, complemento, bairro, cidade, CEP, estado)
values ('Rua Presidente Altino', 124, NULL, 'Morumbi', 'São Paulo', '06326-290', 'SP'),
        ('Rua Visconde do Pirajá', '3579', NULL, 'Ipanema', 'Rio de Janeiro', '06879-512', 'RJ'),
        ('Avenida Amazonas', '154', NULL, 'Prado', 'Belo Horizonte', '04278-456', 'MG');

CREATE TABLE empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    CNPJ CHAR(14) NOT NULL,
    razao_social VARCHAR(50) NOT NULL,
    nome_fantasia VARCHAR(50) NOT NULL,
    telefone varchar (15) NULL,
    email varchar (50),
    qtd_estufas INT NOT NULL,
    tokenEmpresa char (7) NOT NULL,
    fk_endereco INT NOT NULL,
    constraint fk_endereco_empresa foreign key (fk_endereco) references endereco (idEndereco)
);

insert into empresa(CNPJ, razao_social, nome_fantasia, telefone, email, qtd_estufas, tokenEmpresa, fk_endereco)
values (12345678000190, 'AgroTech Soluções Agricolas Plantio Ltda.', 'AgroTech', '11967314567', 'comunicacoesagrotech@gmail.com', 1, 'FGY7637', 100),
		(98345678000140, 'Gestão Verde Agro SA', 'GV Agro', '11947310967', 'vendasgvagro@gmail.com', 1, '9FGF653', 101),
        (09871678000140, 'Agri Futura Planções Ltda.','Agri Futura', '11913560989', 'financeiroagriplantacoes@gmail.com', 1, 'GR73482', 102);
        
select * from empresa;

CREATE TABLE usuario (
idUser INT PRIMARY KEY auto_increment, 
nome VARCHAR(50)not null,
CPF char (14) not null,
senha VARCHAR(15) not null,
email VARCHAR(60) not null,
permissao char (3) not null,
fk_empresa int not null,
CONSTRAINT fk_usuario_empresa FOREIGN KEY (fk_empresa) REFERENCES empresa (idEmpresa),
CONSTRAINT chk_usuario_empresa CHECK (permissao IN ('não' , 'sim'))
) auto_increment = 50;

insert into usuario (nome, CPF, senha, email, permissao, fk_empresa) 
values ('Samuel Sales de Souza', '123.456.789-00','#samuca1867', 'samu674@gmail.com','não', '1'),
		('Rose Miranda Freitas', '987.654.321-01','Rose123.', 'rose735@gmail.com','sim', '2'),
        ('Paulo Marques Santos', '456.789.012-02','Paulo827#', 'paulot6te64@gmail.com', 'sim', '3');
	
select *
from empresa as emp
inner join usuario as us on us.fk_empresa = emp.idEmpresa;

create table metricas (
idMetrica	INT AUTO_INCREMENT,
TempMinima  DECIMAL(3,1) NOT NULL,
TempMaxima  DECIMAL(3,1) NOT NULL,
UmidMinima  DECIMAL(3,1) NOT NULL, 
UmidMaxima  DECIMAL (3,1) NOT NULL,
LuminMinima INT NOT NULL,
LuminMaxima INT NOT NULL,
PRIMARY KEY(idMetrica)
) AUTO_INCREMENT = 10;

insert into metricas (idMetrica, TempMinima, TempMaxima, UmidMinima, UmidMaxima, LuminMinima, LuminMaxima)
values		(null, '15.1', '25.8', '60.5', '80.0', '600', '800');

CREATE TABLE estufa (
idEstufa INT PRIMARY KEY AUTO_INCREMENT,
tipoPimentao varchar(15),
qtd_pimentoes INT NOT NULL,
fk_empresa INT NOT NULL,
fk_metricas INT NOT NULL,
CONSTRAINT ck_tipo_pimentao check (tipoPimentao in('verde', 'amarelo', 'vermelho')),
CONSTRAINT fk_empresa_estufa FOREIGN KEY (fk_empresa) REFERENCES empresa (idEmpresa),
CONSTRAINT fk_metricas_estufa FOREIGN KEY (fk_metricas) REFERENCES metricas (idMetrica)
)AUTO_INCREMENT=500; 

insert into estufa(tipoPimentao, qtd_pimentoes, fk_empresa, fk_metricas)
values ('verde', 1000, 1, 10),
	('amarelo', 2000, 2, 10),
    ('vermelho', 3000, 3, 10);

select * from estufa;
select * 
from estufa as est
inner join empresa as emp on est.fk_empresa = emp.idEmpresa;
 
 create table conjuntoSensores(
idSensor int primary key auto_increment,
codigo varchar (20), 
fk_estufa int,
constraint fk_sensor_estufa foreign key (fk_estufa) references estufa (idEstufa)
)auto_increment = 1000;


insert into conjuntoSensores (idSensor, codigo, fk_estufa)
values (null, 'SE123', 500),
		(null, 'SE763', 501),
        (null, 'SE980', 502);
        
 select * from conjuntoSensores;
 
CREATE TABLE leitura (
idLeitura INT PRIMARY KEY AUTO_INCREMENT,
temperatura DECIMAL(4 , 2 ) NOT NULL,
umidade DECIMAL(4 , 2 ) NOT NULL,
luminosidade DECIMAL(8 , 2 ) NOT NULL,
DataHora_medida TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
fk_sensores int,
CONSTRAINT fk_leitura_sensor FOREIGN KEY (fk_sensores) REFERENCES conjuntoSensores (idSensor)
)AUTO_INCREMENT = 2000;


insert into leitura(temperatura, umidade, luminosidade, fk_sensores)
values (22.2, 75, 100000.00, 1000),
		(23.2, 75, 100000.00, 1001),
        (21.2, 75, 100000.00, 1002);
    
select *
from leitura as lei
inner join conjuntoSensores as sen on lei.fk_sensores = sen.idSensor
inner join estufa as est on sen.fk_estufa = est.idEstufa;
