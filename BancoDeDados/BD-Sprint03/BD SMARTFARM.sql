create database if not exists smartfarm;

-- drop database smartfarm;

-- -------------------------------------------------------------------------------------------------------- --
-- ---------------------------- Criação da tabela Endereço ------------------------------------------------ --
-- -------------------------------------------------------------------------------------------------------- --

create table smartfarm.endereco (
id INT PRIMARY KEY AUTO_INCREMENT,
logradouro VARCHAR(45) NOT NULL,
numero INT NOT NULL,
complemento VARCHAR(20) NULL,
bairro VARCHAR(45) NOT NULL,
CEP CHAR(9) NOT NULL,
cidade VARCHAR(45) NOT NULL,
estado CHAR(2) NOT NULL
) auto_increment = 100;

-- -------------------------------------------------------------------------------------------------------- --
-- ---------------------------- Insert da tabela Endereço ------------------------------------------------- --
-- -------------------------------------------------------------------------------------------------------- --

insert into smartfarm.endereco (logradouro, numero, complemento, bairro, cidade, CEP, estado)
values ('Rua Presidente Altino', 124, NULL, 'Morumbi', 'São Paulo', '06326-290', 'SP'),
        ('Rua Visconde do Pirajá', '3579', NULL, 'Ipanema', 'Rio de Janeiro', '06879-512', 'RJ'),
        ('Avenida Amazonas', '154', NULL, 'Prado', 'Belo Horizonte', '04278-456', 'MG');
        
-- Visualiza todos os endereços.
select * from smartfarm.endereco;

-- -------------------------------------------------------------------------------------------------------- --
-- -------------------------------------- Create da tabela Empresa ---------------------------------------- --
-- -------------------------------------------------------------------------------------------------------- --


create table smartfarm.empresa (
    id INT PRIMARY KEY AUTO_INCREMENT,
    CNPJ CHAR(14) NOT NULL,
    razao_social VARCHAR(50) NOT NULL,
    nome_fantasia VARCHAR(50) NOT NULL,
    telefone varchar (15) NULL,
    email varchar (50),
    qtd_estufas INT NOT NULL,
    fk_endereco INT NOT NULL,
    constraint fk_endereco_empresa foreign key (fk_endereco) references smartfarm.endereco(id)
) auto_increment = 100000;

-- As empresas iniciam com o auto-increment no 100000 
-- para termos as empresas com 6 algarismos para utilizar no token ao cadastrar


-- -------------------------------------------------------------------------------------------------------- --
-- -------------------------------------- Insert da tabela Empresa ---------------------------------------- --
-- -------------------------------------------------------------------------------------------------------- --

insert into smartfarm.empresa(id, CNPJ, razao_social, nome_fantasia, telefone, email, qtd_estufas, fk_endereco)
values (null, 12345678000190, 'AgroTech Soluções Agricolas Plantio Ltda.', 'AgroTech', '11967314567', 'comunicacoesagrotech@gmail.com', 1, 100),
	   (null, 98345678000140, 'Gestão Verde Agro SA', 'GV Agro', '11947310967', 'vendasgvagro@gmail.com', 1, 101),
	   (null, 09871678000140, 'Agri Futura Planções Ltda.','Agri Futura', '11913560989', 'financeiroagriplantacoes@gmail.com', 1, 102);

-- Visualiza todas as empresas
select * from smartfarm.empresa;

select 
em.nome_fantasia as nomeEm
from smartfarm.empresa as em
inner join smartfarm.usuario as usu ON usu.fk_empresa = em.id
where usu.email = "gavassa@gmail.com" and usu.nome = "gavassa";

select *
from smartfarm.empresa as em
inner join smartfarm.endereco as en on em.fk_endereco = en.id;

-- -------------------------------------------------------------------------------------------------------- --
-- ------------------------------------ Create da tabela Usuario ------------------------------------------ --
-- -------------------------------------------------------------------------------------------------------- --

create table smartfarm.usuario (
id int primary key auto_increment,
nome varchar(50)not null,
email varchar(60) not null,
senha varchar(15) not null,
fk_empresa int not null,
constraint fk_usuario_empresa foreign key (fk_empresa) references smartfarm.empresa(id),
constraint uk_email unique key email(email)
) auto_increment = 50;

-- -------------------------------------------------------------------------------------------------------- --
-- ------------------------------------ Insert da tabela Usuario ------------------------------------------ --
-- -------------------------------------------------------------------------------------------------------- --

insert into smartfarm.usuario(id, nome, email, senha, fk_empresa)
values 
(null, "Guilherme","guilherme@gmail.com","gavassa123",100000);

-- Visualiza todos os usuarios.
select * from smartfarm.usuario;

-- Visualiza os usuários e suas empresas.
select *
from smartfarm.empresa as emp
inner join smartfarm.usuario as us on us.fk_empresa = emp.id;


-- -------------------------------------------------------------------------------------------------------- --
-- ----------------------------------- Create da tabela Metricas ------------------------------------------ --
-- -------------------------------------------------------------------------------------------------------- --

create table smartfarm.metricas (
id	INT AUTO_INCREMENT,
TempMinima  DECIMAL(3,1) NOT NULL comment 'Temperatura Mínima do sensor, para gerar alerta crítico.',
TempMaxima  DECIMAL(3,1) NOT NULL comment 'Temperatura Máxima do sensor, para gerar alerta crítico.',
UmidMinima  DECIMAL(3,1) NOT NULL comment 'Umidade Mínima do sensor, para gerar alerta crítico.',
UmidMaxima  DECIMAL (3,1) NOT NULL comment 'Umidade Máxima do sensor, para gerar alerta crítico.',
LuminMinima INT NOT NULL comment 'Luminosidade Mínima do sensor, para gerar alerta crítico.',
LuminMaxima INT NOT NULL comment 'Luminosidade Máxima do sensor, para gerar alerta crítico.',
PRIMARY KEY(id)
) AUTO_INCREMENT = 10;

-- -------------------------------------------------------------------------------------------------------- --
-- ----------------------------------- Insert da tabela Metricas ------------------------------------------ --
-- -------------------------------------------------------------------------------------------------------- --

insert into smartfarm.metricas (id, TempMinima, TempMaxima, UmidMinima, UmidMaxima, LuminMinima, LuminMaxima)
values
(null, '20.0', '30.0', '60.0', '80.0', '600', '800'),
(null, '25.0', '33.0', '65.0', '85.0', '700', '900');

-- -------------------------------------------------------------------------------------------------------- --
-- ----------------------------------- Create da tabela Estufa -------------------------------------------- --
-- -------------------------------------------------------------------------------------------------------- --

create table smartfarm.estufa (
id INT PRIMARY KEY AUTO_INCREMENT,
tipoPimentao varchar(15),
fk_empresa INT NOT NULL,
fk_metricas INT NOT NULL,
CONSTRAINT ck_tipo_pimentao check (tipoPimentao in('verde', 'amarelo', 'vermelho')),
CONSTRAINT fk_empresa_estufa FOREIGN KEY (fk_empresa) REFERENCES empresa (id),
CONSTRAINT fk_metricas_estufa FOREIGN KEY (fk_metricas) REFERENCES metricas (id)
)AUTO_INCREMENT = 500; 

-- -------------------------------------------------------------------------------------------------------- --
-- ----------------------------------- Insert da tabela Estufa -------------------------------------------- --
-- -------------------------------------------------------------------------------------------------------- --

insert into smartfarm.estufa(id, tipoPimentao, fk_empresa, fk_metricas)
values (null, 'verde', 100000, 10),
	   (null, 'amarelo', 100000, 11),
       (null, 'vermelho', 100001, 11);
       
-- Visualizando todas as estufas.
select * from smartfarm.estufa;

select
count(es.id)
from smartfarm.estufa es
join smartfarm.empresa em on es.fk_empresa = em.id;

-- Visualizando todas as empresas, e suas determinadas estufas
select * 
from smartfarm.estufa as est
inner join smartfarm.empresa as emp on est.fk_empresa = emp.id;

-- -------------------------------------------------------------------------------------------------------- --
-- -------------------------------- Create da tabela ConjuntoSensores ------------------------------------- --
-- -------------------------------------------------------------------------------------------------------- --
 
create table smartfarm.conjuntoSensores(
id int primary key auto_increment,
codigo varchar (20), 
fk_estufa int not null,
constraint fk_sensor_estufa foreign key (fk_estufa) references estufa (id)
)auto_increment = 1000;

-- -------------------------------------------------------------------------------------------------------- --
-- --------------------------------- Insert da tabela ConjuntoSensores ------------------------------------ --
-- -------------------------------------------------------------------------------------------------------- --

insert into smartfarm.conjuntoSensores (id, codigo, fk_estufa)
values (null, 'SE123', 500),
		(null, 'SE763', 501),
        (null, 'SE980', 502);
        
-- Visualizando todos os conjuntos de sensores.
 select * from smartfarm.conjuntoSensores;
 
-- Visualizando todas as estufas e os seus conjuntos de sensores
 select * 
 from smartfarm.conjuntoSensores as con
 inner join smartfarm.estufa as es
 on con.fk_estufa = es.id;
 
-- -------------------------------------------------------------------------------------------------------- --
-- ----------------------------------- Create da tabela Leitura ------------------------------------------- --
-- -------------------------------------------------------------------------------------------------------- --
 
create table smartfarm.leitura (
id INT PRIMARY KEY AUTO_INCREMENT,
temperatura DECIMAL(4, 2 ) NOT NULL,
umidade DECIMAL(4, 2 ) NOT NULL,
luminosidade DECIMAL(8, 2 ) NOT NULL,
DataHora_medida TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
fk_sensores int not null,
CONSTRAINT fk_leitura_sensor FOREIGN KEY (fk_sensores) REFERENCES smartfarm.conjuntoSensores(id)
)AUTO_INCREMENT = 2000;

-- -------------------------------------------------------------------------------------------------------- --
-- ----------------------------------- Insert da tabela Leitura ------------------------------------------- --
-- -------------------------------------------------------------------------------------------------------- --


insert into smartfarm.leitura(id, temperatura, umidade, luminosidade, fk_sensores)
values (null, 22.2, 75, 870.00, 1000),
		(null, 23.2, 75, 880.00, 1001),
        (null, 21.2, 75, 868.00, 1002);
        
        
    
select 
lei.temperatura 'Temperatura',
lei.umidade 'Umidade',
lei.luminosidade 'Luminosidade',
lei.DataHora_medida,
sen.id 'Conjunto Sensores',
est.id 'Estufa'
from smartfarm.leitura as lei
inner join smartfarm.conjuntoSensores as sen on lei.fk_sensores = sen.id
inner join smartfarm.estufa as est on sen.fk_estufa = est.id;

select * from information_schema.tables;
