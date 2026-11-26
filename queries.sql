-- A. Quantas tabelas o banco de dados possui?
USE pizzaria;
SHOW tables;
-- B. Quantos clientes cadastrados?
SELECT * FROM cliente;
-- ou
SELECT COUNT(*) FROM cliente;
-- ou melhor
SELECT COUNT(*) as `total de cliente` FROM cliente;
-- C. Quantas pizzas Cadastradas?
SELECT * FROM pizza;
-- ou
SELECT COUNT(*) FROM pizza;
-- ou melhor
SELECT COUNT(*) as `total de pizza` FROM pizza;
-- D. Quantas pizzas o pedido nº 3 possui?
SELECT * FROM pizza;
SELECT * FROM pedido;
SELECT * FROM itens_pedido;
SELECT * FROM itens_pedido WHERE pedido_id = 3;
SELECT count(quantidade) FROM itens_pedido WHERE pedido_id = 3;
SELECT count(quantidade) as `total de sabores` FROM itens_pedido WHERE pedido_id = 3;
SELECT sum(quantidade) FROM itens_pedido WHERE pedido_id = 3;
SELECT sum(quantidade) as `total de pizza` FROM itens_pedido WHERE pedido_id = 3;
-- E. Qual nome do cliente que fez o pedido nº 3?
DESCRIBE pedido;
DESCRIBE cliente;
SELECT * FROM pedido WHERE id = 3;
SELECT * FROM cliente WHERE id = 2;
-- JOIN juntando as tabelas e mostrando o nome do cliente
SELECT c.nome as cliente, p.id FROM pedido p INNER JOIN cliente c
ON c.id = p.cliente_id
WHERE p.id = 3;
-- F. Quais os nomes das pizza do pedido nº 3?
SELECT * FROM itens_pedido WHERE pedido_id = 3;
SELECT pizza_id FROM itens_pedido WHERE pedido_id = 3;
SELECT * FROM pizza WHERE id IN (7,5,8,9,3,10,16);
-- Com SubConsulta
SELECT * FROM pizza WHERE id
    IN (SELECT pizza_id FROM itens_pedido WHERE pedido_id = 3);
SELECT nome FROM pizza WHERE id
    IN (SELECT pizza_id FROM itens_pedido WHERE pedido_id = 3);
-- Com INNER JOIN
SELECT p.nome FROM itens_pedido i INNER JOIN pizza p
ON i.pizza_id = p.id
WHERE i.pedido_id = 3;
-- Com INNER JOIN e mostrando todos o ítens do pedido
SELECT i.*, p.nome FROM itens_pedido i INNER JOIN pizza p
ON i.pizza_id = p.id
WHERE i.pedido_id = 3;