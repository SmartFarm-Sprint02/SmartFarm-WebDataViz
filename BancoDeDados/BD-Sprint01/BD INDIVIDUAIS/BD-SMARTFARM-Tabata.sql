create database SmartFarm;
use SmartFarm;

create table empresa (
	idEmpresa int primary key auto_increment
    , nomeFantasia varchar(50) 
    , nomeEmpresarial varchar(50) not null
    , email varchar(50) not null
    , cnpj varchar(14) not null
    , telefone varchar(14) not null
    , endereco varchar(300)
); 

create table usuario (
	idUsuario int primary key auto_increment
    , nome varchar(50) not null
    , email varchar(80) not null
    , senha varchar(40) not null
    , cpf varchar(14) not null
    , telefone varchar(14) not null
	, tipoAcesso char(1) check(tipoAcesso in('0', '1')) not null
    , fkEmpresa int 
);

alter table usuario add foreign key (fkEmpresa) references empresa(idEmpresa);

create table estufa (
	idEstufa int primary key auto_increment
    , tipoPimentao varchar(30)
    , qtdPimentao int
    , fkEmpresa int 
);

alter table estufa add foreign key (fkEmpresa) references empresa(idEmpresa);

create table sensor (
	idSensor int primary key auto_increment
	, numeroSerie varchar(15) not null
	, fkEstufa int 
    , constraint fkEstufa foreign key (fkEstufa) references estufa(idEstufa)
);

create table leitura (
	idLeitura int primary key auto_increment
    , tipoLeitura varchar(15) CHECK(tipoLeitura in ('Temperatura', 'Umidade', 'Luminosidade'))
    , valorLido decimal(8,2)
    , dataMedicao datetime
    , fkSensor int 
    , constraint fkSensor foreign key (fkSensor) references sensor(idSensor)
);
