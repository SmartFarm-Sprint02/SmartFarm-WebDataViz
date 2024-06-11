create database if not exists smartfarm;

-- drop database smartfarm; 
-- -------------------------------------------------------------------------------------------------------- --
-- -------------------------------------------- CREATES --------------------------------------------------- --
-- -------------------------------------------------------------------------------------------------------- --

-- TABELA DE ENDEREÇO

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

-- TABELA DE EMPRESA

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

-- TABELA DE USUARIO

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


-- TABELA DE ESTUFAS

create table smartfarm.estufa (
id INT PRIMARY KEY AUTO_INCREMENT,
tipoPimentao varchar(15),
fk_empresa INT NOT NULL,
CONSTRAINT ck_tipo_pimentao check (tipoPimentao in('verde', 'amarelo', 'vermelho')),
CONSTRAINT fk_empresa_estufa FOREIGN KEY (fk_empresa) REFERENCES empresa (id)
)AUTO_INCREMENT = 500;

-- TABELA DE MÉTRICAS

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

alter table smartfarm.metricas add constraint unique key (fk_estufa);

-- TABELA DE CONJUNTO DE SENSORES

create table smartfarm.conjuntoSensores(
id int primary key auto_increment,
fk_estufa int not null,
codigo varchar (20),
constraint fk_sensor_estufa foreign key (fk_estufa) references estufa (id)
)auto_increment = 1000;

-- TABELA DE LEITURAS

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
-- --------------------------------------------- INSERTS -------------------------------------------------- --
-- -------------------------------------------------------------------------------------------------------- --

-- INSERT TABELA DE ENDEREÇO

insert into smartfarm.endereco (logradouro, numero, complemento, bairro, cidade, CEP, estado)
values ('Rua Presidente Altino', 124, NULL, 'Morumbi', 'São Paulo', '06326-290', 'SP'),
       ('Rua Visconde do Pirajá', '3579', NULL, 'Ipanema', 'Rio de Janeiro', '06879-512', 'RJ'),
       ('Avenida Amazonas', '154', NULL, 'Prado', 'Belo Horizonte', '04278-456', 'MG'),
       ('Rua da Harmonia', 789, NULL , 'Vila Madalena', 'São Paulo', '05435-000', 'SP'),
       ('Avenida Paulista', 1578, NULL, 'Bela Vista', 'São Paulo', '01310-200', 'SP'),
       ('Rua das Laranjeiras', 456, NULL, 'Laranjeiras', 'Rio de Janeiro', '22240-005', 'RJ'),
       ('Rua Sete de Setembro', 891, NULL, 'Centro', 'Porto Alegre', '90010-190', 'RS'),
       ('Rua XV de Novembro', 2525, NULL, 'Centro', 'Curitiba', '80020-310', 'PR'),
       ('Avenida Beira Mar', 1250, NULL, 'Meireles', 'Fortaleza', '60165-121', 'CE'),
       ('Rua dos Navegantes', 433, NULL, 'Boa Viagem', 'Recife', '51020-010', 'PE');

select *  from smartfarm.endereco;

-- INSERT TABELA DE EMPRESA

insert into smartfarm.empresa(id, CNPJ, razao_social, nome_fantasia, telefone, email, qtd_estufas, fk_endereco)
values (NULL, 12345678000190, 'AgroTech Soluções Agricolas Plantio Ltda.', 'AgroTech', '11967314567', 'comunicacoesagrotech@gmail.com', 15, 100),
       (NULL, 98345678000140, 'Gestão Verde Agro SA', 'GV Agro', '11947310967', 'vendasgvagro@gmail.com', 15, 101),
       (NULL, 09871678000140, 'Agri Futura Plantões Ltda.', 'Agri Futura', '11913560989', 'financeiroagriplantacoes@gmail.com', 15, 102),
       (NULL, 56789123000156, 'Agro Terra Soluções Ltda.', 'Agro Terra', '11998765432', 'contato@agroterra.com.br', 15, 103),
       (NULL, 23456789000134, 'Fazenda Viva Alimentos Orgânicos Ltda.', 'Fazenda Viva', '11987654321', 'vendas@fazendaviva.com', 15, 104),
       (NULL, 34567891000121, 'Plantio Verde Sustentável Ltda.', 'Plantio Verde', '11976543210', 'contato@plantioverde.com', 15, 105),
       (NULL, 45678912000118, 'Estufas do Futuro Ltda.', 'Estufas Futuro', '11965432109', 'info@estufasdofuturo.com', 15, 106),
       (NULL, 56789013000105, 'Horta Inteligente Soluções Ltda.', 'Horta Inteligente', '11954321098', 'suporte@hortainteligente.com', 15, 107),
       (NULL, 67890124000192, 'Cultivo Sustentável Agro Ltda.', 'Cultivo Sustentável', '11943210987', 'financeiro@cultivosustentavel.com', 15, 108),
       (NULL, 78901235000179, 'AgroTech Brasil SA', 'AgroTech Brasil', '11932109876', 'comercial@agrotechbrasil.com', 15, 109);
select * from smartfarm.empresa;

-- INSERT TABELA DE USUÁRIO

insert into smartfarm.usuario(id, nome, email, senha, mensagem, fk_empresa)
values 
(null, "Guilherme","guilherme@gmail.com","gavassa123", "Meu nome 123" ,100000),
(NULL, 'Ana', 'ana@gmail.com', 'ana123', 'Mensagem Ana', 100000),
(NULL, 'Carlos', 'carlos@gmail.com', 'carlos123', 'Mensagem Carlos', 100000),
(NULL, 'Fernanda', 'fernanda@gmail.com', 'fernanda123', 'Mensagem Fernanda', 100000),
(NULL, 'Marcos', 'marcos@gmail.com', 'marcos123', 'Mensagem Marcos', 100000),

(NULL, 'Pedro', 'pedro@gmail.com', 'pedro123',  "Meu nome ", 100001),
(NULL, 'Lucas', 'lucas@gmail.com', 'lucas123', 'Mensagem Lucas', 100001),
(NULL, 'Joana', 'joana@gmail.com', 'joana123', 'Mensagem Joana', 100001),
(NULL, 'Felipe', 'felipe@gmail.com', 'felipe123', 'Mensagem Felipe', 100001),
(NULL, 'Maria', 'maria@gmail.com', 'maria123', 'Mensagem Maria', 100001),

(NULL, 'João', 'joao@gmail.com', 'joao123',  "Meu nome 12", 100002),
(NULL, 'Luana', 'luana@gmail.com', 'luana123', 'Mensagem Luana', 100002),
(NULL, 'Bruno', 'bruno@gmail.com', 'bruno123', 'Mensagem Bruno', 100002),
(NULL, 'Juliana', 'juliana@gmail.com', 'juliana123', 'Mensagem Juliana', 100002),
(NULL, 'André', 'andre@gmail.com', 'andre123', 'Mensagem André', 100002),

(NULL, 'Ricardo', 'ricardo@gmail.com', 'ricardo123', "Meu nome 23", 100003),
(NULL, 'Paula', 'paula@gmail.com', 'paula123', 'Mensagem Paula', 100003),
(NULL, 'Renata', 'renata@gmail.com', 'renata123', 'Mensagem Renata', 100003),
(NULL, 'Thiago', 'thiago@gmail.com', 'thiago123', 'Mensagem Thiago', 100003),
(NULL, 'Lara', 'lara@gmail.com', 'lara123', 'Mensagem Lara', 100003),

(NULL, 'Gustavo', 'gustavo@gmail.com', 'gustavo123', "Meu nome 13", 100004),
(NULL, 'Simone', 'simone@gmail.com', 'simone123', 'Mensagem Simone', 100004),
(NULL, 'Eduardo', 'eduardo@gmail.com', 'eduardo123', 'Mensagem Eduardo', 100004),
(NULL, 'Aline', 'aline@gmail.com', 'aline123', 'Mensagem Aline', 100004),
(NULL, 'Rodrigo', 'rodrigo@gmail.com', 'rodrigo123', 'Mensagem Rodrigo', 100004),

(NULL, 'Patrícia', 'patricia@gmail.com', 'patricia123',  "Meu nome 1", 100005),
(NULL, 'Roberto', 'roberto@gmail.com', 'roberto123', 'Mensagem Roberto', 100005),
(NULL, 'Daniela', 'daniela@gmail.com', 'daniela123', 'Mensagem Daniela', 100005),
(NULL, 'Fernando', 'fernando@gmail.com', 'fernando123', 'Mensagem Fernando', 100005),
(NULL, 'Cláudia', 'claudia@gmail.com', 'claudia123', 'Mensagem Cláudia', 100005),

(NULL, 'Antônio', 'antonio@gmail.com', 'antonio123',  "Meu nome 3", 100006),
(NULL, 'Carla', 'carla@gmail.com', 'carla123', 'Mensagem Carla', 100006),
(NULL, 'Marcelo', 'marcelo@gmail.com', 'marcelo123', 'Mensagem Marcelo', 100006),
(NULL, 'Júlia', 'julia@gmail.com', 'julia123', 'Mensagem Júlia', 100006),
(NULL, 'Fabio', 'fabio@gmail.com', 'fabio123', 'Mensagem Fabio', 100006),

(NULL, 'Sérgio', 'sergio@gmail.com', 'sergio123',  "Meu nome 2", 100007),
(NULL, 'Tatiana', 'tatiana@gmail.com', 'tatiana123', 'Mensagem Tatiana', 100007),
(NULL, 'Maurício', 'mauricio@gmail.com', 'mauricio123', 'Mensagem Maurício', 100007),
(NULL, 'Débora', 'debora@gmail.com', 'debora123', 'Mensagem Débora', 100007),
(NULL, 'Leandro', 'leandro@gmail.com', 'leandro123', 'Mensagem Leandro', 100007),

(NULL, 'Vivian', 'vivian@gmail.com', 'vivian123',  "Meu nome nu", 100008),
(NULL, 'Rafael', 'rafael@gmail.com', 'rafael123', 'Mensagem Rafael', 100008),
(NULL, 'Monica', 'monica@gmail.com', 'monica123', 'Mensagem Monica', 100008),
(NULL, 'Igor', 'igor@gmail.com', 'igor123', 'Mensagem Igor', 100008),
(NULL, 'Helena', 'helena@gmail.com', 'helena123', 'Mensagem Helena', 100008),

(NULL, 'Alex', 'alex@gmail.com', 'alex123',  "Meu nome 14", 100009),
(NULL, 'Isabela', 'isabela@gmail.com', 'isabela123', 'Mensagem Isabela', 100009),
(NULL, 'Mário', 'mario@gmail.com', 'mario123', 'Mensagem Mário', 100009),
(NULL, 'Gabriela', 'gabriela@gmail.com', 'gabriela123', 'Mensagem Gabriela', 100009),
(NULL, 'Otávio', 'otavio@gmail.com', 'otavio123', 'Mensagem Otávio', 100009);
select * from smartfarm.usuario;


-- INSERT TABELA DE ESTUFAS

insert into smartfarm.estufa(id, tipoPimentao, fk_empresa)
values
(NULL, 'verde', 100000),
(NULL, 'amarelo', 100000),
(NULL, 'vermelho', 100000),
(NULL, 'verde', 100000),
(NULL, 'amarelo', 100000),
(NULL, 'vermelho', 100000),
(NULL, 'verde', 100000),
(NULL, 'amarelo', 100000),
(NULL, 'vermelho', 100000),
(NULL, 'verde', 100000),
(NULL, 'amarelo', 100000),
(NULL, 'vermelho', 100000),
(NULL, 'verde', 100000),
(NULL, 'amarelo', 100000),
(NULL, 'vermelho', 100000),

(NULL, 'verde', 100001),
(NULL, 'amarelo', 100001),
(NULL, 'vermelho', 100001),
(NULL, 'verde', 100001),
(NULL, 'amarelo', 100001),
(NULL, 'vermelho', 100001),
(NULL, 'verde', 100001),
(NULL, 'amarelo', 100001),
(NULL, 'vermelho', 100001),
(NULL, 'verde', 100001),
(NULL, 'amarelo', 100001),
(NULL, 'vermelho', 100001),
(NULL, 'verde', 100001),
(NULL, 'amarelo', 100001),
(NULL, 'vermelho', 100001),


(NULL, 'verde', 100002),
(NULL, 'amarelo', 100002),
(NULL, 'vermelho', 100002),
(NULL, 'verde', 100002),
(NULL, 'amarelo', 100002),
(NULL, 'vermelho', 100002),
(NULL, 'verde', 100002),
(NULL, 'amarelo', 100002),
(NULL, 'vermelho', 100002),
(NULL, 'verde', 100002),
(NULL, 'amarelo', 100002),
(NULL, 'vermelho', 100002),
(NULL, 'verde', 100002),
(NULL, 'amarelo', 100002),
(NULL, 'vermelho', 100002),

(NULL, 'verde', 100003),
(NULL, 'amarelo', 100003),
(NULL, 'vermelho', 100003),
(NULL, 'verde', 100003),
(NULL, 'amarelo', 100003),
(NULL, 'vermelho', 100003),
(NULL, 'verde', 100003),
(NULL, 'amarelo', 100003),
(NULL, 'vermelho', 100003),
(NULL, 'verde', 100003),
(NULL, 'amarelo', 100003),
(NULL, 'vermelho', 100003),
(NULL, 'verde', 100003),
(NULL, 'amarelo', 100003),
(NULL, 'vermelho', 100003),

(NULL, 'verde', 100004),
(NULL, 'amarelo', 100004),
(NULL, 'vermelho', 100004),
(NULL, 'verde', 100004),
(NULL, 'amarelo', 100004),
(NULL, 'vermelho', 100004),
(NULL, 'verde', 100004),
(NULL, 'amarelo', 100004),
(NULL, 'vermelho', 100004),
(NULL, 'verde', 100004),
(NULL, 'amarelo', 100004),
(NULL, 'vermelho', 100004),
(NULL, 'verde', 100004),
(NULL, 'amarelo', 100004),
(NULL, 'vermelho', 100004),

(NULL, 'verde', 100005),
(NULL, 'amarelo', 100005),
(NULL, 'vermelho', 100005),
(NULL, 'verde', 100005),
(NULL, 'amarelo', 100005),
(NULL, 'vermelho', 100005),
(NULL, 'verde', 100005),
(NULL, 'amarelo', 100005),
(NULL, 'vermelho', 100005),
(NULL, 'verde', 100005),
(NULL, 'amarelo', 100005),
(NULL, 'vermelho', 100005),
(NULL, 'verde', 100005),
(NULL, 'amarelo', 100005),
(NULL, 'vermelho', 100005),

(NULL, 'verde', 100006),
(NULL, 'amarelo', 100006),
(NULL, 'vermelho', 100006),
(NULL, 'verde', 100006),
(NULL, 'amarelo', 100006),
(NULL, 'vermelho', 100006),
(NULL, 'verde', 100006),
(NULL, 'amarelo', 100006),
(NULL, 'vermelho', 100006),
(NULL, 'verde', 100006),
(NULL, 'amarelo', 100006),
(NULL, 'vermelho', 100006),
(NULL, 'verde', 100006),
(NULL, 'amarelo', 100006),
(NULL, 'vermelho', 100006),

(NULL, 'verde', 100007),
(NULL, 'amarelo', 100007),
(NULL, 'vermelho', 100007),
(NULL, 'verde', 100007),
(NULL, 'amarelo', 100007),
(NULL, 'vermelho', 100007),
(NULL, 'verde', 100007),
(NULL, 'amarelo', 100007),
(NULL, 'vermelho', 100007),
(NULL, 'verde', 100007),
(NULL, 'amarelo', 100007),
(NULL, 'vermelho', 100007),
(NULL, 'verde', 100007),
(NULL, 'amarelo', 100007),
(NULL, 'vermelho', 100007),

(NULL, 'verde', 100008),
(NULL, 'amarelo', 100008),
(NULL, 'vermelho', 100008),
(NULL, 'verde', 100008),
(NULL, 'amarelo', 100008),
(NULL, 'vermelho', 100008),
(NULL, 'verde', 100008),
(NULL, 'amarelo', 100008),
(NULL, 'vermelho', 100008),
(NULL, 'verde', 100008),
(NULL, 'amarelo', 100008),
(NULL, 'vermelho', 100008),
(NULL, 'verde', 100008),
(NULL, 'amarelo', 100008),
(NULL, 'vermelho', 100008),

(NULL, 'verde', 100009),
(NULL, 'amarelo', 100009),
(NULL, 'vermelho', 100009),
(NULL, 'verde', 100009),
(NULL, 'amarelo', 100009),
(NULL, 'vermelho', 100009),
(NULL, 'verde', 100009),
(NULL, 'amarelo', 100009),
(NULL, 'vermelho', 100009),
(NULL, 'verde', 100009),
(NULL, 'amarelo', 100009),
(NULL, 'vermelho', 100009),
(NULL, 'verde', 100009),
(NULL, 'amarelo', 100009),
(NULL, 'vermelho', 100009);


select * from smartfarm.estufa;

-- INSERT (E UPDATE) TABELA DE MÉTRICAS

insert into smartfarm.metricas (id, fk_estufa,TempMinima, TempMaxima, UmidMinima, UmidMaxima, LuminMinima, LuminMaxima)
values
(NULL, 503, '22.0', '32.0', '63.0', '83.0', '620', '820'),
(NULL, 504, '23.0', '31.0', '64.0', '84.0', '630', '830'),
(NULL, 505, '21.0', '29.0', '61.0', '81.0', '610', '810'),
(NULL, 506, '24.0', '34.0', '66.0', '86.0', '640', '840'),
(NULL, 507, '20.5', '30.5', '60.5', '80.5', '605', '805'),
(NULL, 508, '25.5', '33.5', '65.5', '85.5', '705', '905'),
(NULL, 509, '22.5', '32.5', '63.5', '83.5', '625', '825'),
(NULL, 510, '23.5', '31.5', '64.5', '84.5', '635', '835'),
(NULL, 511, '20.1', '30.1', '60.1', '80.1', '601', '801'),
(NULL, 512, '25.1', '33.1', '65.1', '85.1', '701', '901'),
(NULL, 513, '22.1', '32.1', '63.1', '83.1', '621', '821'),
(NULL, 514, '23.1', '31.1', '64.1', '84.1', '631', '831'),
(NULL, 515, '21.1', '29.1', '61.1', '81.1', '611', '811'),
(NULL, 516, '24.1', '34.1', '66.1', '86.1', '641', '841'),
(NULL, 517, '20.2', '30.2', '60.2', '80.2', '602', '802'),
(NULL, 518, '25.2', '33.2', '65.2', '85.2', '702', '902'),
(NULL, 519, '22.2', '32.2', '63.2', '83.2', '622', '822'),
(NULL, 520, '23.2', '31.2', '64.2', '84.2', '632', '832'),
(NULL, 521, '21.2', '29.2', '61.2', '81.2', '612', '812'),
(NULL, 522, '24.2', '34.2', '66.2', '86.2', '642', '842'),
(NULL, 523, '20.3', '30.3', '60.3', '80.3', '603', '803'),
(NULL, 524, '25.3', '33.3', '65.3', '85.3', '703', '903'),
(NULL, 525, '22.3', '32.3', '63.3', '83.3', '623', '823'),
(NULL, 526, '23.3', '31.3', '64.3', '84.3', '633', '833'),
(NULL, 527, '21.3', '29.3', '61.3', '81.3', '613', '813'),
(NULL, 528, '24.3', '34.3', '66.3', '86.3', '643', '843'),
(NULL, 529, '20.4', '30.4', '60.4', '80.4', '604', '804'),
(NULL, 530, '25.4', '33.4', '65.4', '85.4', '704', '904'),
(NULL, 531, '22.4', '32.4', '63.4', '83.4', '624', '824'),
(NULL, 532, '23.4', '31.4', '64.4', '84.4', '634', '834'),
(NULL, 533, '21.4', '29.4', '61.4', '81.4', '614', '814'),
(NULL, 534, '24.4', '34.4', '66.4', '86.4', '644', '844'),
(NULL, 535, '20.6', '30.6', '60.6', '80.6', '606', '806'),
(NULL, 536, '25.6', '33.6', '65.6', '85.6', '706', '906'),
(NULL, 537, '22.6', '32.6', '63.6', '83.6', '626', '826'),
(NULL, 538, '23.6', '31.6', '64.6', '84.6', '636', '836'),
(NULL, 539, '21.6', '29.6', '61.6', '81.6', '616', '816'),
(NULL, 540, '24.6', '34.6', '66.6', '86.6', '646', '846'),
(NULL, 541, '20.7', '30.7', '60.7', '80.7', '607', '807'),
(NULL, 542, '25.7', '33.7', '65.7', '85.7', '707', '907'),
(NULL, 543, '22.7', '32.7', '63.7', '83.7', '627', '827'),
(NULL, 544, '23.7', '31.7', '64.7', '84.7', '637', '837'),
(NULL, 545, '21.7', '29.7', '61.7', '81.7', '617', '817'),
(NULL, 546, '24.7', '34.7', '66.7', '86.7', '647', '847'),
(NULL, 547, '20.8', '30.8', '60.8', '80.8', '608', '808'),
(NULL, 548, '25.8', '33.8', '65.8', '85.8', '708', '908'),
(NULL, 549, '22.8', '32.8', '63.8', '83.8', '628', '828'),
(NULL, 550, '23.8', '31.8', '64.8', '84.8', '638', '838'),
(NULL, 551, '21.8', '29.8', '61.8', '81.8', '618', '818'),
(NULL, 552, '24.8', '34.8', '66.8', '86.8', '648', '848'),
(NULL, 553, '20.9', '30.9', '60.9', '80.9', '609', '809'),
(NULL, 554, '25.9', '33.9', '65.9', '85.9', '709', '909'),
(NULL, 555, '22.9', '32.9', '63.9', '83.9', '629', '829'),
(NULL, 556, '23.9', '31.9', '64.9', '84.9', '639', '839'),
(NULL, 557, '21.9', '29.9', '61.9', '81.9', '619', '819'),
(NULL, 558, '24.9', '34.9', '66.9', '86.9', '649', '849'),
(NULL, 559, '21.0', '31.0', '62.0', '82.0', '620', '820'),
(NULL, 560, '26.0', '36.0', '67.0', '87.0', '720', '920'),
(NULL, 561, '23.0', '32.0', '63.0', '83.0', '630', '830'),
(NULL, 562, '22.0', '31.0', '62.0', '82.0', '620', '820'),
(NULL, 563, '25.0', '33.0', '65.0', '85.0', '650', '850'),
(NULL, 564, '20.5', '30.5', '60.5', '80.5', '605', '805'),
(NULL, 565, '25.5', '35.5', '65.5', '85.5', '705', '905'),
(NULL, 566, '22.5', '32.5', '63.5', '83.5', '625', '825'),
(NULL, 567, '23.5', '33.5', '64.5', '84.5', '635', '835'),
(NULL, 568, '21.5', '31.5', '61.5', '81.5', '615', '815'),
(NULL, 569, '24.5', '34.5', '66.5', '86.5', '645', '845'),
(NULL, 570, '20.1', '30.1', '60.1', '80.1', '601', '801'),
(NULL, 571, '25.1', '35.1', '65.1', '85.1', '701', '901'),
(NULL, 572, '22.1', '32.1', '63.1', '83.1', '621', '821'),
(NULL, 573, '23.1', '33.1', '64.1', '84.1', '631', '831'),
(NULL, 574, '21.1', '31.1', '61.1', '81.1', '611', '811'),
(NULL, 575, '24.1', '34.1', '66.1', '86.1', '641', '841'),
(NULL, 576, '20.2', '30.2', '60.2', '80.2', '602', '802'),
(NULL, 577, '25.2', '35.2', '65.2', '85.2', '702', '902'),
(NULL, 578, '22.2', '32.2', '63.2', '83.2', '622', '822'),
(NULL, 579, '23.2', '33.2', '64.2', '84.2', '632', '832'),
(NULL, 580, '21.2', '31.2', '61.2', '81.2', '612', '812'),
(NULL, 581, '24.2', '34.2', '66.2', '86.2', '642', '842'),
(NULL, 582, '20.3', '30.3', '60.3', '80.3', '603', '803'),
(NULL, 583, '25.3', '35.3', '65.3', '85.3', '703', '903'),
(NULL, 584, '22.3', '32.3', '63.3', '83.3', '623', '823'),
(NULL, 585, '23.3', '33.3', '64.3', '84.3', '633', '833'),
(NULL, 586, '21.3', '31.3', '61.3', '81.3', '613', '813'),
(NULL, 587, '24.3', '34.3', '66.3', '86.3', '643', '843'),
(NULL, 588, '20.4', '30.4', '60.4', '80.4', '604', '804'),
(NULL, 589, '25.4', '35.4', '65.4', '85.4', '704', '904'),
(NULL, 590, '22.4', '32.4', '63.4', '83.4', '624', '824'),
(NULL, 591, '23.4', '33.4', '64.4', '84.4', '634', '834'),
(NULL, 592, '21.4', '31.4', '61.4', '81.4', '614', '814'),
(NULL, 593, '24.4', '34.4', '66.4', '86.4', '644', '844'),
(NULL, 594, '20.6', '30.6', '60.6', '80.6', '606', '806'),
(NULL, 595, '25.6', '35.6', '65.6', '85.6', '706', '906'),
(NULL, 596, '22.6', '32.6', '63.6', '83.6', '626', '826'),
(NULL, 597, '23.6', '33.6', '64.6', '84.6', '636', '836'),
(NULL, 598, '21.6', '31.6', '61.6', '81.6', '616', '816'),
(NULL, 599, '24.6', '34.6', '66.6', '86.6', '646', '846'),
(NULL, 600, '20.7', '30.7', '60.7', '80.7', '607', '807'),
(NULL, 601, '25.7', '35.7', '65.7', '85.7', '707', '907'),
(NULL, 602, '22.7', '32.7', '63.7', '83.7', '627', '827'),
(NULL, 603, '23.7', '33.7', '64.7', '84.7', '637', '837'),
(NULL, 604, '21.7', '31.7', '61.7', '81.7', '617', '817'),
(NULL, 605, '24.7', '34.7', '66.7', '86.7', '647', '847'),
(NULL, 606, '20.8', '30.8', '60.8', '80.8', '608', '808'),
(NULL, 607, '25.8', '35.8', '65.8', '85.8', '708', '908'),
(NULL, 608, '22.8', '32.8', '63.8', '83.8', '628', '828'),
(NULL, 609, '23.8', '33.8', '64.8', '84.8', '638', '838'),
(NULL, 610, '21.8', '31.8', '61.8', '81.8', '618', '818'),
(NULL, 611, '24.8', '34.8', '66.8', '86.8', '648', '848'),
(NULL, 612, '20.9', '30.9', '60.9', '80.9', '609', '809'),
(NULL, 613, '25.9', '35.9', '65.9', '85.9', '709', '909'),
(NULL, 614, '22.9', '32.9', '63.9', '83.9', '629', '829'),
(NULL, 615, '23.9', '33.9', '64.9', '84.9', '639', '839'),
(NULL, 616, '21.9', '31.9', '61.9', '81.9', '619', '819'),
(NULL, 617, '24.9', '34.9', '66.9', '86.9', '649', '849'),
(NULL, 618, '21.0', '31.0', '62.0', '82.0', '620', '820'),
(NULL, 619, '26.0', '36.0', '67.0', '87.0', '720', '920'),
(NULL, 620, '23.0', '32.0', '63.0', '83.0', '630', '830'),
(NULL, 621, '22.0', '31.0', '62.0', '82.0', '620', '820'),
(NULL, 622, '25.0', '33.0', '65.0', '85.0', '650', '850'),
(NULL, 623, '20.5', '30.5', '60.5', '80.5', '605', '805'),
(NULL, 624, '25.5', '35.5', '65.5', '85.5', '705', '905'),
(NULL, 625, '22.5', '32.5', '63.5', '83.5', '625', '825'),
(NULL, 626, '23.5', '33.5', '64.5', '84.5', '635', '835'),
(NULL, 627, '21.5', '31.5', '61.5', '81.5', '615', '815'),
(NULL, 628, '24.5', '34.5', '66.5', '86.5', '645', '845'),
(NULL, 629, '20.1', '30.1', '60.1', '80.1', '601', '801'),
(NULL, 630, '25.1', '35.1', '65.1', '85.1', '701', '901'),
(NULL, 631, '22.1', '32.1', '63.1', '83.1', '621', '821'),
(NULL, 632, '23.1', '33.1', '64.1', '84.1', '631', '831'),
(NULL, 633, '21.1', '31.1', '61.1', '81.1', '611', '811'),
(NULL, 634, '24.1', '34.1', '66.1', '86.1', '641', '841'),
(NULL, 635, '20.2', '30.2', '60.2', '80.2', '602', '802'),
(NULL, 636, '25.2', '35.2', '65.2', '85.2', '702', '902'),
(NULL, 637, '22.2', '32.2', '63.2', '83.2', '622', '822'),
(NULL, 638, '23.2', '33.2', '64.2', '84.2', '632', '832'),
(NULL, 639, '21.2', '31.2', '61.2', '81.2', '612', '812'),
(NULL, 640, '24.2', '34.2', '66.2', '86.2', '642', '842'),
(NULL, 641, '20.3', '30.3', '60.3', '80.3', '603', '803'),
(NULL, 642, '25.3', '35.3', '65.3', '85.3', '703', '903'),
(NULL, 643, '22.3', '32.3', '63.3', '83.3', '623', '823'),
(NULL, 644, '23.3', '33.3', '64.3', '84.3', '633', '833'),
(NULL, 645, '21.3', '31.3', '61.3', '81.3', '613', '813'),
(NULL, 646, '24.3', '34.3', '66.3', '86.3', '643', '843'),
(NULL, 647, '20.4', '30.4', '60.4', '80.4', '604', '804'),
(NULL, 648, '25.4', '35.4', '65.4', '85.4', '704', '904'),
(NULL, 649, '22.4', '32.4', '63.4', '83.4', '624', '824');



update smartfarm.metricas set TempMinima = '10', TempMaxima = '20' where fk_estufa = 500;
update smartfarm.metricas set UmidMinima = '10', UmidMaxima = '20' where fk_estufa = 500;
update smartfarm.metricas set LuminMinima = '10', LuminMaxima = '20' where fk_estufa = 500;

-- INSERT TABELA DE CONJUNTO DE SENSORES

insert into smartfarm.conjuntoSensores (id, codigo, fk_estufa)
values 
(null, 'SE123', 500),
(null, 'SE763', 501),
(null, 'SE980', 502),
(NULL, 'SE124', 503),
(NULL, 'SE764', 504),
(NULL, 'SE981', 505),
(NULL, 'SE125', 506),
(NULL, 'SE765', 507),
(NULL, 'SE982', 508),
(NULL, 'SE126', 509),
(NULL, 'SE766', 510),
(NULL, 'SE983', 511),
(NULL, 'SE127', 512),
(NULL, 'SE767', 513),
(NULL, 'SE984', 514),
(NULL, 'SE128', 515);
 select * from smartfarm.conjuntoSensores;
 
-- INSERT TABELA DE LEITURAS


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

(null, 23.5, 78, 860.00, 1001),
(null, 24.3, 82, 920.00, 1001),
(null, 25.8, 86, 960.00, 1001),
(null, 26.7, 73, 790.00, 1001),
(null, 27.9, 68, 820.00, 1001),
(null, 29.2, 85, 930.00, 1001),
(null, 30.5, 90, 980.00, 1001),
(null, 32.1, 95, 1000.00, 1001),

(null, 22.2, 74, 840.00, 1002), 
(null, 23.7, 76, 870.00, 1002),
(null, 24.8, 80, 910.00, 1002),
(null, 25.5, 84, 930.00, 1002),
(null, 26.3, 71, 800.00, 1002),
(null, 27.5, 65, 810.00, 1002),
(null, 29.0, 83, 920.00, 1002),
(null, 30.8, 88, 970.00, 1002),

(null, 22.4, 76, 820.00, 1003), 
(null, 23.9, 79, 850.00, 1003),
(null, 24.5, 83, 900.00, 1003),
(null, 25.3, 87, 940.00, 1003),
(null, 26.8, 72, 790.00, 1003),
(null, 27.1, 66, 800.00, 1003),
(null, 29.5, 85, 930.00, 1003),
(null, 30.1, 89, 980.00, 1003),

(null, 22.7, 75, 810.00, 1004),
(null, 23.1, 77, 860.00, 1004),
(null, 24.1, 81, 910.00, 1004),
(null, 25.7, 85, 940.00, 1004),
(null, 26.6, 70, 780.00, 1004),
(null, 27.8, 64, 800.00, 1004),
(null, 29.3, 82, 910.00, 1004),
(null, 30.3, 87, 960.00, 1004);


-- -------------------------------------------------------------------------------------------------------- --
-- --------------------------------------------- SELECTS -------------------------------------------------- --
-- -------------------------------------------------------------------------------------------------------- --
 
select 
em.nome_fantasia as 'Empresa',
usu.nome as 'Usuário'
from smartfarm.empresa as em
inner join smartfarm.usuario as usu ON usu.fk_empresa = em.id;

select em.nome_fantasia 'Empresa',
       en.logradouro,
       en.estado,
       en.bairro,
       en.cidade
from smartfarm.empresa as em
inner join smartfarm.endereco as en on em.fk_endereco = en.id;


select
count(es.id)
from smartfarm.estufa es
join smartfarm.empresa em on es.fk_empresa = em.id;

-- Visualizando todas as empresas, e suas determinadas estufas
select * 
from smartfarm.estufa as est
inner join smartfarm.empresa as emp on est.fk_empresa = emp.id;

 select * 
 from smartfarm.conjuntoSensores as con
 inner join smartfarm.estufa as es
 on con.fk_estufa = es.id;


    
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
inner join smartfarm.estufa as est on sen.fk_estufa = est.id
where lei.fk_sensores = 1001;


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


-- -------------------------------------------------------------------------------------------------------- --
-- ------------------------- Select para puxar leituras acima ou abaixo da métrica ------------------------ --
-- -------------------------------------------------------------------------------------------------------- --

SELECT
	periodo,
    COUNT(*) AS quantidade
FROM (
    SELECT
        lei.id,
        CASE
            WHEN HOUR(lei.DataHora_medida) BETWEEN 0 AND 5 THEN 'Madrugada'
            WHEN HOUR(lei.DataHora_medida) BETWEEN 6 AND 11 THEN 'Manhã'
            WHEN HOUR(lei.DataHora_medida) BETWEEN 12 AND 17 THEN 'Tarde'
            WHEN HOUR(lei.DataHora_medida) BETWEEN 18 AND 23 THEN 'Noite'
        END AS periodo
    FROM leitura lei
    JOIN conjuntoSensores cs ON lei.fk_sensores = cs.id
    JOIN estufa est ON cs.fk_estufa = est.id
    JOIN metricas met ON est.id = met.fk_estufa
    WHERE (lei.temperatura < met.TempMinima OR lei.temperatura > met.TempMaxima
        OR lei.umidade < met.UmidMinima OR lei.umidade > met.UmidMaxima
        OR lei.luminosidade < met.LuminMinima OR lei.luminosidade > met.LuminMaxima)
        AND est.id = 501
) AS subquery
GROUP BY periodo
ORDER BY periodo DESC LIMIT 1;

-- -------------------------------------------------------------------------------------------------------- --
-- ------------------------- Select para puxar todos os alertas que teve na estufa ------------------------ --
-- -------------------------------------------------------------------------------------------------------- --

SELECT
    COUNT(*) AS quantidade
    FROM (
    SELECT
        lei.id
    FROM leitura lei
    JOIN conjuntoSensores cs ON lei.fk_sensores = cs.id
    JOIN estufa est ON cs.fk_estufa = est.id
    JOIN metricas met ON est.id = met.fk_estufa
    WHERE (lei.temperatura < met.TempMinima OR lei.temperatura > met.TempMaxima
        OR lei.umidade < met.UmidMinima OR lei.umidade > met.UmidMaxima
        OR lei.luminosidade < met.LuminMinima OR lei.luminosidade > met.LuminMaxima)
        AND est.id = 501
) AS subquery;

-- -------------------------------------------------------------------------------------------------------- --
-- ------------------------- Select para puxar todos os alertas que teve no mês --------------------------- --
-- -------------------------------------------------------------------------------------------------------- --
select * from leitura;

SELECT
    MONTH(lei.DataHora_medida) AS mes,
    COUNT(*) AS quantidade
FROM leitura lei
JOIN conjuntoSensores cs ON lei.fk_sensores = cs.id
JOIN estufa est ON cs.fk_estufa = est.id
JOIN metricas met ON est.id = met.fk_estufa
WHERE (lei.temperatura < met.TempMinima OR lei.temperatura > met.TempMaxima
    OR lei.umidade < met.UmidMinima OR lei.umidade > met.UmidMaxima
    OR lei.luminosidade < met.LuminMinima OR lei.luminosidade > met.LuminMaxima)
    AND est.id = 501
GROUP BY mes
ORDER BY quantidade DESC
LIMIT 1;

-- -------------------------------------------------------------------------------------------------------- --
-- ------------------------- Select para puxar todos os alertas da estufa (gráfico) ----------------------- --
-- -------------------------------------------------------------------------------------------------------- --

SELECT
    HOUR(lei.DataHora_medida) AS hora,
    COUNT(*) AS quantidade
FROM leitura lei
JOIN conjuntoSensores cs ON lei.fk_sensores = cs.id
JOIN estufa est ON cs.fk_estufa = est.id
JOIN metricas met ON est.id = met.fk_estufa
WHERE (lei.temperatura < met.TempMinima OR lei.temperatura > met.TempMaxima
    OR lei.umidade < met.UmidMinima OR lei.umidade > met.UmidMaxima
    OR lei.luminosidade < met.LuminMinima OR lei.luminosidade > met.LuminMaxima)
    AND est.id = 501
GROUP BY hora
ORDER BY hora;

-- -------------------------------------------------------------------------------------------------------- --
-- ---------------------- Select para puxar todos os alertas da estufa (home/grafico) --------------------- --
-- -------------------------------------------------------------------------------------------------------- --

SELECT
    MONTH(lei.DataHora_medida) AS hora,
    COUNT(*) AS quantidade
FROM leitura lei
JOIN conjuntoSensores cs ON lei.fk_sensores = cs.id
JOIN estufa est ON cs.fk_estufa = est.id
JOIN metricas met ON est.id = met.fk_estufa
WHERE (lei.temperatura < met.TempMinima OR lei.temperatura > met.TempMaxima
    OR lei.umidade < met.UmidMinima OR lei.umidade > met.UmidMaxima
    OR lei.luminosidade < met.LuminMinima OR lei.luminosidade > met.LuminMaxima)
GROUP BY hora
ORDER BY hora;

select * from leitura;

use smartfarm;
