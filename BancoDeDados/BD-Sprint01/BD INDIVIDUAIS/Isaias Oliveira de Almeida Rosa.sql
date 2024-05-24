create database SmartFarm;
use SmartFarm;

create table Empresa(
id int primary key auto_increment,
CNPJ char(14) not null,
Razão_Social varchar(50),
Nome_fantasia varchar(50),
Endereço varchar(75),
Telefone varchar(12) null,
Email varchar(45),
qtdEstufas int not null,
Cód_Validação int
);
insert into Empresa(CNPJ, Razão_Social, Nome_Fantasia, Endereço, Telefone, Email, qtdEstufas, Cód_Validação)
values  (12345678000190, 'AgroTech Soluções Agricolas Plantio Ltda.', 'AgroTech','Rua Solidônio Leite, 1771', '11967314567', 'comunicacoesagrotech@gmail.com', 1,'12345'),
		(98345678000140, 'Gestão Verde Agro SA', 'GV Agro','Rua Gamelinha Branca,920', '11947310967', 'vendasgvagro@gmail.com', 1,'24315'),
        (09871678000140, 'Agri Futura Planções Ltda.','Agri Futura', 'Rua dos Nacionalistas,1987','11913560989', 'financeiroagriplantacoes@gmail.com', 1,'79045');
        
select * from Empresa;

create table Usuário(
id int primary key auto_increment,
Nome varchar(50) not null,
CPF char(14) not null,
Email varchar(50) not null,
Senha varchar(15) not null,
Telefone char(15) not null,
Permissão char (1) check (Permissão in('0', '1')) not null,
 fkEmpresa int,
 CONSTRAINT fk_Usuário_Empresa FOREIGN KEY (fkEmpresa) REFERENCES Empresa (id)
) auto_increment = 100;

insert into Usuário(Nome, CPF, Email, Senha, Telefone, Permissão, fkEmpresa)
values('Carlos Miranda Oliveira', '123.456.789-00','carlosm674@gmail.com','#teste1867','1155551234', '0', '4'),
		('Rose Miranda Freitas', '987.654.321-01','rose735@gmail.com','Rose123.','2198765432','0', '5'),
        ('Paulo Marques Santos', '456.789.012-02','paulot6te64@gmail.com','Paulo837#','312345-6789', '0', '6');
        
select * from Usuário;

create table Estufa(
id int primary key auto_increment,
Tipo_pimentão varchar(15) check (Tipo_pimentão in('verde', 'amarelo', 'vermelho')),
qtd_Pimentão int not null,
fkEmpresa int,
CONSTRAINT fk_Empresa_Estufa FOREIGN KEY (fkEmpresa) REFERENCES Empresa (id)
) AUTO_INCREMENT=1000; 

insert into Estufa(Tipo_pimentão, qtd_Pimentão, fkEmpresa)
values('verde','7245', '4'),
('vermelho', '5780', '5'),
('amarelo', '3450', '6');

select * from Estufa;

create table Sensor(
id int primary key auto_increment,
Código varchar(20),
fkEstufa int,
constraint fk_Sensor_Estufa foreign key (fkEstufa) references Estufa (id)
) auto_increment = 2000;

insert into Sensor(Código, fkEstufa)
values('se946', '1003'),
('se721','1004'),
('se930','1005');

select * from Sensor;

create table Leitura(
id int primary key auto_increment,
Temperatura decimal(4,2) not null,
Umidade decimal(4,2) not null,
Luminosidade decimal(8,2) not null,
fkEstufa INT,
fkSensor int,
DataHora_medida TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT fk_Leitura_Estufa foreign key (fkEstufa) references Estufa (id)
 ) auto_increment = 3000;

insert into Leitura(Temperatura, Umidade, Luminosidade, fkEstufa, fkSensor)
values (22.2, 75, '7300', '1003','3000'),
		(23.2, 75, '7400','1004', '3001'),
        (21.2, 75, '7500','1005','3002');
    
select * from leitura;