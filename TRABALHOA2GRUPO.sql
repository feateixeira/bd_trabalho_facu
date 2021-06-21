drop database `Banco_Projecao`;
create schema if not exists `Banco_Projecao` default character set utf8;
use `Banco_Projecao`;

-- CRIAÇÃO DA TABELA DE CLIENTE

create table if not exists `Banco_Projecao` . `cliente` (
	`id_cliente` int not null auto_increment,
    `nome_cliente` varchar(50),
    `cpf_cliente` char (15),
    `dn_cliente` date,
    `rg_cliente` char(7), 
    `email_cliente` char(50),
    primary key (`id_cliente`)
) engine = InnoDB;


-- CRIAÇÃO DA TABELA DE ENDEREÇO RELACIONADA A CLIENTE

create table if not exists `Banco_Projecao` . `endereco` (
	`id_endereco` int not null auto_increment,
    `rua` varchar(30),
    `cidade` varchar(50),
    `estado` varchar(50),
    `cep` char(9),
    `pais` varchar(50),
    `id_cliente` int,
    primary key (`id_endereco`),
    index fk_endereco_cliente1_idx (`id_cliente` ASC),
    constraint `fk_endereco_cliente1`
		foreign key (`id_cliente`)
        references `Banco_Projecao`.`cliente` (`id_cliente`)
        on delete no action
        on update no action
) engine = InnoDB;

-- CRIAÇÃO DA TABELA DE TELEFONE RELACIONANDO A CLIENTE

create table if not exists `Banco_Projecao` . `telefone` (
	`id_telefone` int not null auto_increment,
    `codigo_pais` char(3),
    `ddd` int(2),
    `numero` int(9),
    `id_cliente` int,
    primary key (`id_telefone`),
    index fk_telefone_cliente1_idx (`id_cliente` ASC),
    constraint `fk_telefone_cliente1`
		foreign key (`id_cliente`)
        references `Banco_Projecao`.`cliente` (`id_cliente`)
        on delete no action
        on update no action
) engine = InnoDB;

-- CRIAÇÃO DA TABELA DE SENHA RELACIONANDO A CLIENTE

create table if not exists `Banco_Projecao` . `senha` (
	`id_senha` int not null auto_increment,
	`senha_conta` char(8),
	`senha_cartao` char(4),
	`id_cliente` int,
    primary key (`id_senha`),
	index fk_senha_cliente1_idx (`id_senha` ASC),
	constraint `fk_senha_cliente1`
		foreign key (`id_cliente`)
		references `Banco_Projecao`.`cliente` (`id_cliente`)
        on delete no action
        on update no action
) engine = InnoDB;

-- -- CRIAÇÃO DA TABELA DE CONTA CORRENTE RELACIONANDO A CLIENTE

create table if not exists `Banco_Projecao` . `conta_corrente` (
	`id_cc` int not null auto_increment,
    `id_agencia` char(5),
    `num_cc` char(7),
    `id_cliente` int,
    primary key (`id_cc`),
    index fk_cc_cliente1_idx (`id_cliente` ASC),
    constraint `fk_cc_cliente1`
		foreign key (`id_cliente`)
        references `Banco_Projecao`.`cliente` (`id_cliente`)
        on delete no action
        on update no action
) engine = InnoDB;


-- INSERÇÃO DE VALORES

insert into cliente values 
	(null, 'Fellipe', '252.252.252-45', '1993-02-24', '265.635', 'fellipe@gmail.com');
    
insert into endereco values 
	(null, '10', 'brasilia', 'DF', '72000-000', 'Brasil', 1);
    
insert into telefone values 
	(null, 55, '61', '96693663', 1);
	
insert into senha values 
	(null, '432125', '1234', 1);
    
insert into conta_corrente values 
	(null, '000-1', '41155-2', 1);

-- JOIN PARA SELEÇÃO DE DADOS

select tc.id_cliente, tc.nome_cliente, tc.cpf_cliente, tc.dn_cliente, tc.rg_cliente, tc.email_cliente, te.id_endereco, te.rua, te.cidade, te.estado, te.cep, te.pais, tt.id_telefone, tt.codigo_pais, tt.ddd, tt.numero, ts.id_senha, ts.senha_conta, ts.senha_cartao, tcc.id_cc, tcc.id_agencia, tcc.num_cc 
from cliente tc
join endereco te
on tc.id_cliente = te.id_cliente
join telefone tt
on tc.id_cliente = tt.id_cliente
join senha ts
on tc.id_cliente = ts.id_cliente
join conta_corrente tcc
on tc.id_cliente = tcc.id_cliente;