select 'Aula 19';

select * from sys.sys_config;

use mysql;
show tables;

select * from user;

-- 1) Criando usuários
-- Criação de usuário local
create user 'usuariolocal'@'localhost' identified by 'minhaSenha!123';

-- Criação de usuário global
create user 'usuarioglobal'@'%' identified by 'minhaSenhaMaisForte@123';

-- 2) Alterando senhas
alter user 'usuariolocal'@'localhost' identified by 'novaSenha$123';

-- 3) Renomear o usuario
rename user 'usuariolocal'@'localhost' to 'usuariolocal_novonome'@'localhost';
select * from user;

-- 4) Eliminar usuário
drop user 'usuariolocal_novonome'@'localhost';

select * from user where Select_priv = 'Y';
select * from user where User like 'usuariolocal%';

-- 5) mostrar grants
show grants for 'gustavo_pantiga';
show grants for 'usuariolocal'@'localhost';

-- 6) direcionar grants
grant all on *.* to 'usuarioglobal'@'%';
grant all on *.* to 'usuariolocal'@'localhost';

-- 7) grant para tabela
grant all on sakila.actor to 'usuarioglobal'@'%';
grant select, update, delete on sakila.actor to 'usuarioglobal'@'%';

-- 8) grant em colunas
grant update (language, replacement_cost) on sakila.film
to 'usuarioglobal'@'%';

-- 9) Revogar acessos
revoke all on *.* from 'usuariolocal'@'localhost';

-- Crie um usuário chamado coderhouse, com uma senha de mesmo nome.
use `Database Coderhouse`;
create user 'coderhouse'@'localhost' identified by '123umaSenhaForte!@#';

-- Estabeleça permissões apenas para leitura de dados sobre a tabela GAME.
grant select on `Database Coderhouse`.GAME to 'coderhouse'@'localhost';

-- Estabeleça permissões de leitura e inserção sobre a tabela CLASS.
grant select, insert, delete on `Database Coderhouse`.CLASS to 'coderhouse'@'localhost';

-- Modifique um registro qualquer da tabela GAME e aplique as modificações.
update GAME
set name = 'NovoNomeDeJogo'
where id_game = 4;

select * from GAME where id_game = 4;

-- Adicione um registro na tabela CLASS.
insert into CLASS values (1, 998877, 'Dados de CLASS');
select * from CLASS where id_level = 1 and id_class = 998877;

-- Elimine esse último registro adicionado
delete from CLASS
where id_level = 1 and id_class = 998877;
select * from CLASS where id_level = 1 and id_class = 998877;

-- Exemplo de uso:

-- Queremos criar um role (papel) de gerente de vendas, liberar acesso as tabelas de inventário, 
-- customer e payment
-- e depois, designar esse role para um usuário


use sakila;

-- Criação de role
create role gerente_de_vendas_role;
-- Grant de acessos corretos
grant select, insert, update, delete ON sakila.customer TO gerente_de_vendas_role;
grant select, insert, update, delete ON sakila.inventory TO gerente_de_vendas_role;
grant select, insert, update, delete ON sakila.payment TO gerente_de_vendas_role;

-- Usar o role para permissionamento massivo do usuário
grant gerente_de_vendas_role TO 'coderhouse'@'localhost';

show grants for 'coderhouse'@'localhost';