create database smartfarm;

use smartfarm;



create table empresa(
	idEmpresa int auto_increment primary key,
    Cnpj char(14),
    razao_social varchar (50),
    nome_fantasia varchar(50),
    telefone varchar(11),
    email varchar(50),
    qtd_estufas varchar(50)
    );

insert into empresa(cnpj, razao_social, nome_fantasia, telefone, email, qtd_estufas)
value (12345678000190, 'AgroTech Soluções Agricolas Plantio Ltda.', 'AgroTech', '11967314567', 'comunicacoesagrotech@gmail.com', 1);

select * from empresa;

create table estufa(
	idEstufa int auto_increment primary key,
    tipo_de_pimentao varchar(15),
    qtd_pimentao int,
    fkEmpresa int 
);
    alter table estufa add foreign key (fkEmpresa) references empresa (idEmpresa);

insert into estufa(tipo_de_pimentao, qtd_pimentao,fkEmpresa)
values ('verde', 1000, 1);

select * from estufa;

create table endereco (
	idEndereco int auto_increment primary key,
	logradouro varchar(60),
    tipo varchar (10),
    numero int,
    complemento varchar(25),
    bairro varchar(30),
    cidade varchar(30),
    uf char(2),
    fkempresa int
);    

alter table estufa add foreign key (fkEmpresa) references empresa (idEmpresa);

insert into endereco (logradouro, tipo, numero, complemento, bairro, cidade, UF, fk_empresa)
values ('Altos Caminhos', 'estrada', 132, null, 'Lapa', 'Rio de Janeiro', 'RJ', 2);

select * from estufa;

create table usuario(
	idUsuario int auto_increment primary key,
    nome varchar(50),
    senha varchar(15),
    email varchar(60),
    cpf int,
	permissao char (1) check (permissao in('0', '1')),
    fkEmpresa int
);

alter table usuario add foreign key (fkEmpresa) references empresa (idEmpresa);

insert into usuario(nome, CPF, senha, email, telefone, permissao, fk_empresa)
values ('Samuel Penteado', '123.585.789-00','#teste1867', 'samu420mal@gmail.com', '1155551234', '0', '1');

select * from usuario;

create table sensores(
	idSensor int auto_increment primary key,
    codigo varchar(10),
    tipo varchar(20)
);

insert into sensores (codigo, tipo)
values ('1000', 'Temperatura'),
	   ('2000','Umidade'),
       ('3000','Luminosidade');

select * from sensores;

create table leitura(
	idLeitura int auto_increment primary key,
    temperatura decimal (4,2),
    umidade	decimal (4,2),
    luminosidade decimal(6,2),
    datahora_medida timestamp(10),
    fkSensores int,
    fkEstufas int
);

alter table leitura add foreign key (fkSensores) references sensores(idSensores);
alter table leitura add foreign key (fkEstufas) references estufa(idEstufa);    
    
insert into leitura(temperatura, umidade, luminosidade, fkEstufa, fkSensor)
values (22.2, 75, 100000.00, 1, 1000),
		(23.2, 75, 100000.00, 2, 2000),
        (21.2, 75, 100000.00, 3, 3000);
       
select * from leitura;

    