CREATE DATABASE smartfarm;

use smartfarm;

CREATE TABLE empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    CNPJ CHAR(14) NOT NULL,
    razao_social VARCHAR(50) NOT NULL,
    nome_fantasia VARCHAR(50) NOT NULL,
    telefone varchar (15) null,
    email varchar (50),
    qtd_estufas INT NOT NULL
);

insert into empresa(CNPJ, razao_social, nome_fantasia, telefone, email, qtd_estufas)
values (12345678000190, 'AgroTech Soluções Agricolas Plantio Ltda.', 'AgroTech', '11967314567', 'comunicacoesagrotech@gmail.com', 1),
		(98345678000140, 'Gestão Verde Agro SA', 'GV Agro', '11947310967', 'vendasgvagro@gmail.com', 1),
        (09871678000140, 'Agri Futura Planções Ltda.','Agri Futura', '11913560989', 'financeiroagriplantacoes@gmail.com', 1);
        
select * from empresa;


CREATE TABLE endereco (
    idEndereco INT PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(60) NOT NULL,
    tipo VARCHAR(10) CHECK (tipo IN ('rua' , 'avenida', 'alemeda', 'travessa', 'estrada', 'fazenda')),
    numero INT NOT NULL,
    complemento VARCHAR(25),
    bairro VARCHAR(20) NOT NULL,
    cidade VARCHAR(30) NOT NULL,
    UF CHAR(2) NOT null,
    fk_empresa int
); 

alter table endereco add foreign key (fk_empresa) references empresa (idEmpresa);

insert into endereco(logradouro, tipo, numero, complemento, bairro, cidade, UF, fk_empresa)
values ('Ragueb Choffi', 'avenida', 256, null, 'Parque das Flores', 'São Paulo', 'SP', 1);
insert into endereco(logradouro, tipo, numero, complemento, bairro, cidade, UF, fk_empresa)
values  ('Altos Caminhos', 'estrada', 132, null, 'Lapa', 'Rio de Janeiro', 'RJ', 2),
		('Manoel Garcia', 'rua', 1832, null, 'Campo Limpo', 'Ribeirão Preto', 'SP', 3);

select * from endereco;


CREATE TABLE usuario (
    idUser INT PRIMARY KEY auto_increment, 
    nome VARCHAR(50)not null,
	CPF char (14) not null,
    senha VARCHAR(15) not null,
    email VARCHAR(60) not null,
    permissao char (1) CHECK (permissao IN ('0' , '1')) not null,
    fk_empresa int not null,
    CONSTRAINT fk_usuario_empresa FOREIGN KEY (fk_empresa)
        REFERENCES empresa (idEmpresa)
) auto_increment = 100;

insert into usuario(nome, CPF, senha, email, telefone, permissao, fk_empresa) 
values ('Samuel Sales de Souza', '123.456.789-00','#teste1867', 'samu674@gmail.com', '1155551234', '0', '1'),
		('Rose Miranda Freitas', '987.654.321-01','Rose123.', 'rose735@gmail.com',  '2198765432','0', '2'),
        ('Paulo Marques Santos', '456.789.012-02','Paulo827#', 'paulot6te64@gmail.com', '312345-6789', '0', '3');
	
select * from usuario;

CREATE TABLE estufa (
    idEstufa INT PRIMARY KEY AUTO_INCREMENT,
    tipoPimentao varchar(15) check (tipoPimentao in('verde', 'amarelo', 'vermelho')),
    qtd_pimentoes INT NOT NULL,
	fk_empresa INT NOT NULL,
    CONSTRAINT fk_empresa_estufa FOREIGN KEY (fk_empresa)
        REFERENCES empresa (idEmpresa)
)AUTO_INCREMENT=500; 

insert into estufa(tipoPimentao, qtd_pimentoes, fk_empresa)
values ('verde', 1000, 1),
	('amarelo', 2000, 2),
    ('vermelho', 3000, 3);
select * from estufa;
 
 create table sensor(
id int primary key auto_increment,
codigo varchar (20), 
fk_estufa int,
constraint fk_sensor_estufa foreign key (fk_estufa) references estufa (idEstufa)
)auto_increment = 2000;

insert into sensor(codigo, fk_estufa)
values ('SE123', 500),
		('SE763', 501),
        ('SE980', 502);
        
 select * from sensor;
 
CREATE TABLE leitura (
    idLeitura INT PRIMARY KEY AUTO_INCREMENT,
    temp DECIMAL(4 , 2 ) NOT NULL,
    umid DECIMAL(4 , 2 ) NOT NULL,
    lumin DECIMAL(8 , 2 ) NOT NULL,
    fk_estufa INT NOT NULL,
    DataHora_medida TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fk_sensor int,
   CONSTRAINT fk_leituta_estufa FOREIGN KEY (fk_estufa) REFERENCES estufa (idEstufa)
	
)AUTO_INCREMENT=1000;


insert into leitura(temp, umid, lumin, fk_estufa, fk_sensor)
values (22.2, 75, 100000.00, 500, 2000),
		(23.2, 75, 100000.00, 501, 2001),
        (21.2, 75, 100000.00, 502, 2002);
    
select * from leitura; 



