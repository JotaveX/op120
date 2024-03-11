create database opt120;
use opt120;
create table usuario(
    id int AUTO_INCREMENT not null primary key,
    nome varchar(100),
	email varchar(100),
    senha varchar(100)
);

create table atividade(
	id int auto_increment not null primary key,
	titulo varchar(100),
    descricao varchar(100),
    dataEntrega date
);

create table usuario_atividade(
	id int auto_increment not null primary key,
	usuario_id int,
    atividade_id int,
    entrega date,
    nota float,
    foreign key (usuario_id) references usuario(id),
    foreign key (atividade_id) references atividade(id)
)    
