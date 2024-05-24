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
) auto_increment = 50;

insert into endereco (logradouro, numero, complemento, bairro, cidade, CEP, estado)
values ('Rua Presidente Altino', 124, NULL, 'Morumbi', '06326-290', 'São Paulo', 'SP'),
        ('Rua Visconde do Pirajá', '3579', NULL, 'Ipanema', '06879-512', 'Rio de Janeiro', 'RJ'),
        ('Avenida Amazonas', '154', NULL, 'Prado', '04278-456', 'Belo Horizonte', 'MG');

CREATE TABLE empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    CNPJ CHAR(14) NOT NULL,
    razao_social VARCHAR(50) NOT NULL,
    nome_fantasia VARCHAR(50) NOT NULL,
    telefone varchar (15) NULL,
    email varchar (50),
    qtd_estufas INT NOT NULL,
    tokenEmpresa char (6) NOT NULL,
    fk_endereco INT NOT NULL,
    constraint fk_endereco_empresa foreign key (fk_endereco) references endereco (idEndereco)
);

insert into empresa(CNPJ, razao_social, nome_fantasia, telefone, email, qtd_estufas, tokenEmpresa, fk_endereco)
values (12345678000190, 'AgroTech Soluções Agricolas Plantio Ltda.', 'AgroTech', '11967314567', 'comunicacoesagrotech@gmail.com', 1, 'FGY7637', 51),
		(98345678000140, 'Gestão Verde Agro SA', 'GV Agro', '11947310967', 'vendasgvagro@gmail.com', 1, '9FGF65', 50),
        (09871678000140, 'Agri Futura Planções Ltda.','Agri Futura', '11913560989', 'financeiroagriplantacoes@gmail.com', 1, 'GR73482', 52);
        
select * from empresa;


CREATE TABLE usuario (
idUser INT PRIMARY KEY auto_increment, 
nome VARCHAR(50)not null,
CPF char (14) not null,
senha VARCHAR(15) not null,
email VARCHAR(60) not null,
permissao char (3) CHECK (permissao IN ('não' , 'sim')) not null,
fk_empresa int not null,
CONSTRAINT fk_usuario_empresa FOREIGN KEY (fk_empresa) REFERENCES empresa (idEmpresa)
) auto_increment = 100;

insert into usuario (idUser, nome, CPF, senha, email, permissao, fk_empresa) 
values (null, 'Samuel Sales de Souza', '123.456.789-00','#samuca1867', 'samu674@gmail.com','não', '1'),
		(null, 'Rose Miranda Freitas', '987.654.321-01','Rose123.', 'rose735@gmail.com','sim', '2'),
        (null, 'Paulo Marques Santos', '456.789.012-02','Paulo827#', 'paulot6te64@gmail.com', 'sim', '3');
	
select *
from empresa as emp
inner join usuario as us on us.fk_empresa = emp.idEmpresa;

CREATE TABLE estufa (
idEstufa INT PRIMARY KEY AUTO_INCREMENT,
tipoPimentao varchar(15),
qtd_pimentoes INT NOT NULL,
fk_empresa INT NOT NULL,
CONSTRAINT ck_tipo_pimentao check (tipoPimentao in('verde', 'amarelo', 'vermelho')),
CONSTRAINT fk_empresa_estufa FOREIGN KEY (fk_empresa) REFERENCES empresa (idEmpresa)
)AUTO_INCREMENT=500; 

insert into estufa(tipoPimentao, qtd_pimentoes, fk_empresa)
values ('verde', 1000, 1),
	('amarelo', 2000, 2),
    ('vermelho', 3000, 3);

select * 
from estufa as est
inner join empresa as emp on est.fk_empresa = emp.idEmpresa;
 
 create table sensor(
id int primary key auto_increment,
nome_sensor varchar (10),
codigo varchar (20), 
fk_estufa int,
constraint fk_sensor_estufa foreign key (fk_estufa) references estufa (idEstufa)
)auto_increment = 1000;

insert into sensor
values (null, 'DHT11', 'SE123', 500),
		(null, 'DHT11', 'SE763', 501),
        (null, 'DHT11', 'SE980', 502);
        
 select * from sensor;
 
CREATE TABLE leitura (
idLeitura INT PRIMARY KEY AUTO_INCREMENT,
temperatura DECIMAL(4 , 2 ) NOT NULL,
umidade DECIMAL(4 , 2 ) NOT NULL,
luminosidade DECIMAL(8 , 2 ) NOT NULL,
DataHora_medida TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
fk_estufa INT NOT NULL,
fk_sensor int,
CONSTRAINT fk_leituta_estufa FOREIGN KEY (fk_estufa) REFERENCES estufa (idEstufa),
CONSTRAINT fk_leitura_sensor FOREIGN KEY (fk_sensor) REFERENCES sensor (id)
)AUTO_INCREMENT = 2000;


insert into leitura(temperatura, umidade, luminosidade, fk_estufa, fk_sensor)
values (22.2, 75, 100000.00, 500, 2000),
		(23.2, 75, 100000.00, 501, 2001),
        (21.2, 75, 100000.00, 502, 2002);
    
select * 
from leitura as lei
inner join estufa as est on lei.fk_estufa = est.idEstufa
inner join sensor as sen on lei.fk_sensor = sen.id;