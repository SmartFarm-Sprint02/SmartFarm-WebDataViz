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

alter table smartfarm.usuario add mensagem varchar(200);

-- -------------------------------------------------------------------------------------------------------- --
-- ------------------------------------ Insert da tabela Usuario ------------------------------------------ --
-- -------------------------------------------------------------------------------------------------------- --

insert into smartfarm.usuario(id, nome, email, senha, mensagem, fk_empresa)
values 
(null, "Guilherme","guilherme@gmail.com","gavassa123", "Meu nome 123" ,100000);


-- Visualiza todos os usuarios.
select * from smartfarm.usuario;

-- Visualiza os usuários e suas empresas.
select 
us.id idUsuario,
us.nome nomeUsuario,
us.email emailUsuario,
us.senha senhaUsuario,
emp.nome_fantasia nome_fantasia,
us.fk_empresa fk_empresa
from smartfarm.empresa as emp
inner join smartfarm.usuario as us on us.fk_empresa = emp.id;

-- -------------------------------------------------------------------------------------------------------- --
-- ----------------------------------- Create da tabela Metricas ------------------------------------------ --
-- -------------------------------------------------------------------------------------------------------- --

create table smartfarm.metricas (
id INT NOT NULL AUTO_INCREMENT,
fk_estufa INT NOT NULL,
TempMinima  DECIMAL(3,1) NOT NULL comment 'Temperatura Mínima do sensor, para gerar alerta crítico.',
TempMaxima  DECIMAL(3,1) NOT NULL comment 'Temperatura Máxima do sensor, para gerar alerta crítico.',
UmidMinima  DECIMAL(3,1) NOT NULL comment 'Umidade Mínima do sensor, para gerar alerta crítico.',
UmidMaxima  DECIMAL (3,1) NOT NULL comment 'Umidade Máxima do sensor, para gerar alerta crítico.',
LuminMinima INT NOT NULL comment 'Luminosidade Mínima do sensor, para gerar alerta crítico.',
LuminMaxima INT NOT NULL comment 'Luminosidade Máxima do sensor, para gerar alerta crítico.',
PRIMARY KEY(id,fk_estufa),
CONSTRAINT fk_metricas_estufa1 FOREIGN KEY (fk_estufa) REFERENCES smartfarm.estufa (id)
) AUTO_INCREMENT = 10;

-- -------------------------------------------------------------------------------------------------------- --
-- ----------------------------------- Insert da tabela Metricas ------------------------------------------ --
-- -------------------------------------------------------------------------------------------------------- --

insert into smartfarm.metricas (id, fk_estufa,TempMinima, TempMaxima, UmidMinima, UmidMaxima, LuminMinima, LuminMaxima)
values
(null, 500,'20.0', '30.0', '60.0', '80.0', '600', '800'),
(null, 500, '25.0', '33.0', '65.0', '85.0', '700', '900');

-- -------------------------------------------------------------------------------------------------------- --
-- ----------------------------------- Create da tabela Estufa -------------------------------------------- --
-- -------------------------------------------------------------------------------------------------------- --

create table smartfarm.estufa (
id INT PRIMARY KEY AUTO_INCREMENT,
tipoPimentao varchar(15),
fk_empresa INT NOT NULL,
CONSTRAINT ck_tipo_pimentao check (tipoPimentao in('verde', 'amarelo', 'vermelho')),
CONSTRAINT fk_empresa_estufa FOREIGN KEY (fk_empresa) REFERENCES empresa (id)
)AUTO_INCREMENT = 500;

-- -------------------------------------------------------------------------------------------------------- --
-- ----------------------------------- Insert da tabela Estufa -------------------------------------------- --
-- -------------------------------------------------------------------------------------------------------- --

insert into smartfarm.estufa(id, tipoPimentao, fk_empresa)
values (null, 'verde', 100000),
	   (null, 'amarelo', 100000),
       (null, 'vermelho', 100001);
       
insert into smartfarm.estufa(id, tipoPimentao, fk_empresa)
values (null, 'verde', 100001),
	   (null, 'amarelo', 100001);
       
-- Visualizando todas as estufas.
select * from smartfarm.estufa
order by fk_empresa;


select
count(es.id)
from smartfarm.estufa es
join smartfarm.empresa em on es.fk_empresa = em.id;

-- Visualizando todas as empresas, e suas determinadas estufas
select * 
from smartfarm.estufa as est
inner join smartfarm.empresa as emp on est.fk_empresa = emp.id;

SELECT * FROM smartfarm.estufa WHERE fk_empresa = 100000;

-- -------------------------------------------------------------------------------------------------------- --
-- -------------------------------- Create da tabela ConjuntoSensores ------------------------------------- --
-- -------------------------------------------------------------------------------------------------------- --
 
create table smartfarm.conjuntoSensores(
id int primary key auto_increment,
fk_estufa int not null,
codigo varchar (20),
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

-- Adicionando uma leitura para cada Conjunto de Sensores.
insert into smartfarm.leitura(id, temperatura, umidade, luminosidade, fk_sensores)
values (null, 22.2, 75, 870.00, 1000),
		(null, 23.2, 75, 880.00, 1001),
        (null, 21.2, 75, 868.00, 1002);
        
-- Adicionando varias leituras para apenas um conjunto de sensores.
INSERT INTO smartfarm.leitura(id, temperatura, umidade, luminosidade, fk_sensores)
VALUES 
(null, 22.5, 72, 850.00, 1000),
(null, 23.1, 80, 900.00, 1000),
(null, 24.7, 85, 950.00, 1000),
(null, 25.0, 90, 870.00, 1000),
(null, 26.5, 75, 800.00, 1000),
(null, 27.3, 70, 810.00, 1000),
(null, 28.0, 82, 940.00, 1000),
(null, 29.8, 88, 970.00, 1000),
(null, 30.2, 93, 990.00, 1000),
(null, 32.1, 95, 1000.00, 1000);
    
select 
lei.id 'idLeitura',
lei.temperatura 'Temperatura',
lei.umidade 'Umidade',
lei.luminosidade 'Luminosidade',
lei.DataHora_medida,
sen.id 'Conjunto Sensores',
est.id 'Estufa'
from smartfarm.leitura as lei
inner join smartfarm.conjuntoSensores as sen on lei.fk_sensores = sen.id
inner join smartfarm.estufa as est on sen.fk_estufa = est.id;


SELECT 
    lei.temperatura AS 'Temperatura',
    lei.umidade AS 'Umidade',
    lei.luminosidade AS 'Luminosidade',
    lei.DataHora_medida,
    sen.id AS 'Conjunto Sensores',
    est.id AS 'Estufa',
    emp.id AS 'Empresa',
    emp.nome_fantasia AS 'Nome Empresa'
FROM 
    smartfarm.leitura AS lei
INNER JOIN 
    smartfarm.conjuntoSensores AS sen ON lei.fk_sensores = sen.id
INNER JOIN 
    smartfarm.estufa AS est ON sen.fk_estufa = est.id
INNER JOIN 
    smartfarm.empresa AS emp ON est.fk_empresa = emp.id
ORDER BY 
    emp.id, est.id, lei.DataHora_medida;

select * from information_schema.tables;
