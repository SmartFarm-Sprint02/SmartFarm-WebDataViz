create database bd_amanda;
use bd_amanda;

create table empresa (
id int auto_increment not null primary key,
nome varchar (45),
email varchar(45),
telefone varchar(11)
);

select * from empresa;

insert into empresa (nome, email, telefone)
values ('Agro Pimentão', 'agropimentao@email.com', '11911111111'),
       ('Fazenda tecnológica', 'fazendatecnologica@email.com', '11922222222'),
       ('Estufa Tech', 'estufatech@email.com', '11933333333');

create table estufa (
idEstufa int auto_increment not null primary key,
localizacao varchar (45),
telefone varchar(45),
fk_empresa int,
foreign key (fk_empresa) references empresa (id)
);

insert into estufa (localizacao, telefone, fk_empresa)
values ('Ipiranga', '11972987365', 1),
       ('São Bernardo do Campo', '11984920974', 2),
       ('Guarulhos', '119038726489', 3),
       ('Tatuapé', '11928957390', 1),
       ('São Mateus', '11937290873', 2);
       
select * from estufa;

create table sensor (
idSensor int auto_increment not null primary key,
tipo_sensor varchar (45),
fk_estufa int,
foreign key (fk_estufa) references estufa (idEstufa)
);

insert into sensor (tipo_sensor, fk_estufa)
values ('Temperatura', 1),
       ('Umidade', 1),
       ('Luminosidade', 1),
       ('Temperatura', 2),
       ('Umidade', 2),
       ('Luminosidade', 2),
       ('Temperatura', 3),
       ('Umidade', 3),
       ('Luminosidade', 3);
       
select * from sensor;

create table funcionarios (
idFuncionarios int auto_increment not null primary key,
nome varchar (45),
email varchar (45),
senha varchar (45),
fk_empresa int,
foreign key (fk_empresa) references empresa (id)
);

insert into funcionarios (nome, email, senha, fk_empresa)
values ('Amanda', 'amanda@email.com', '05072005', 1),
       ('Pedro', 'pedro123@email.com', '05614077', 1),
       ('Igor', 'igord1910@email.com', 'abacaxi2348', 2),
       ('Roberto', 'roberto.otrebor@email.com', 'senha', 3),
       ('Betinha', 'betbet@email.com', 'aniteb', 3),
       ('Alékis', 'alekis@email.com', '123456789', 2);
       
select * from funcionarios;