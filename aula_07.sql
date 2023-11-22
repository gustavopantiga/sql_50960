create database store;

use store;

create table products (
	product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    product_value FLOAT
    status varchar(20)
);

select * from products where product_name = 'Produto sem nome'

insert into products (product_id, product_name, product_value)
values
(1, 'refrigerante', '4.5'),
(2, 'água', '2'),
(3, 'vinho', '15'),
(4, 'suco', '5'),
(5, 'cerveja', '9');

select * from products;

create table clients(
	client_id INT PRIMARY KEY,
    client_name VARCHAR(50),
    product_id INT,
    -- Criando relacionamento de chave estrangeira
    FOREIGN KEY(product_id) REFERENCES products(product_id)
);

insert into clients (client_id, client_name, product_id)
values 
(476, 'Roberta', 3),
(477, 'Stael', 4),
(478, 'Arnaldo', 5),
(479, 'Isabela', 2);

-- DML - Data Manipulation Language - Linguagem de Manipulação de Dados.
DELIMITER $$
CREATE TRIGGER tr_class_default_description_2
BEFORE INSERT
ON CLASS FOR EACH ROW -- na tabela CLASS, para cada linha
BEGIN -- INICIO DO PROCEDIMENTO DO TRIGGER
	-- Se houver uma descrição nula
	IF NEW.description is null THEN
		-- Adicione como 'default description'
		SET NEW.description = 'default description';
	END IF;
END;
;

select * from CLASS limit 10;

insert into CLASS (id_level, id_class, description) values (16, 1000, null);

select * from CLASS where id_class = 1000;

-- Suponha que temos duas tabelas: "Orders" (Pedidos) e "OrderLogs" (Registros de Pedidos). 
-- Quando um novo pedido é inserido na tabela "Orders", 
-- queremos que um registro correspondente seja adicionado à tabela "OrderLogs" 
-- para fins de auditoria.

CREATE TRIGGER tr_after_insert_order
AFTER INSERT
ON Orders
FOR EACH ROW
BEGIN
    -- Inserir um novo registro na tabela OrderLogs
    INSERT INTO OrderLogs (order_id, action, timestamp)
    VALUES (NEW.order_id, 'Pedido inserido', NOW());
END;