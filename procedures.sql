-- Iniciaremos com uma QUEST / MISSÃO
-- O cliente Walter Paulo Costenaro quer 1 pizza de Atum e 2 napolitanas.
-- cliente_id 98
-- pizza_id 5, preco 32.29
-- pizza_id 28, preco 33.41
SELECT preco FROM pizza WHERE id = 5;
SELECT preco FROM pizza WHERE id = 28;
SELECT id FROM cliente WHERE nome LIKE "Thamires de C%";
INSERT INTO pedido VALUES (default, 98, NOW(), null);

SELECT * FROM pedido ORDER BY id DESC LIMIT 1;
SELECT LAST_INSERT_ID();
-- pedido_id 27

INSERT INTO itens_pedido VALUES
(default,27,5,1,(SELECT preco FROM pizza WHERE id = 5)),
(default,27,28,2,(SELECT preco FROM pizza WHERE id = 28));

SELECT * FROM itens_pedido WHERE pedido_id = 27;

-- Calcular o preco do pedido e atualizar
SELECT sum(valor_cobrado * quantidade) FROM itens_pedido WHERE pedido_id = 27;

UPDATE pedido
    SET valor_total = (SELECT sum(valor_cobrado * quantidade) FROM itens_pedido WHERE pedido_id = 27)
    WHERE id = 27;

SELECT * FROM pedido WHERE id = 27;

-- Vamos criar uma PROCEDURE que calcule o preco total do pedido
DELIMITER $
CREATE PROCEDURE atulizaprecoPedido(_id int)
    BEGIN
        UPDATE pedido
        SET valor_total = (SELECT sum(valor_cobrado * quantidade) FROM itens_pedido WHERE pedido_id = _id)
        WHERE id = _id;
    END $
DELIMITER ;
SHOW PROCEDURE STATUS;
-- Excluir e criar denovo a mesma PROCEDURE sem alterar os delimitadores
DROP PROCEDURE IF EXISTS atulizaprecoPedido;
CREATE PROCEDURE atulizaprecoPedido(_id int)
UPDATE pedido
    SET valor_total = (SELECT sum(valor_cobrado * quantidade) FROM itens_pedido WHERE pedido_id = _id)
    WHERE id = _id;
SHOW PROCEDURE STATUS;
-- Para testar
SELECT * FROM pedidos WHERE pedido_id = 27;
-- Alterar o valor_total para NULO
UPDATE pedido SET valor_total = null WHERE id = 27;
SELECT * FROM pedido WHERE id = 27;
-- Utilizar o Procedimento para alterar
CALL atulizaprecoPedido(27);
SELECT * FROM pedido WHERE id = 27;
-- Para ver quais procedimentos um Banco de dados possui armazenado.
SHOW PROCEDURE STATUS;
-- Missão 2: A Cliente Sara Luzia de Melo quer 2 pizzas Napolitanas
-- Registre este pedido:
SELECT * FROM cliente WHERE nome = "Sara Luzia de Melo";
SELECT * FROM pizza WHERE nome = "Napolitana";
INSERT INTO pedido VALUES (default, 91, NOW(), null);
INSERT INTO itens_pedido VALUES (default,last_insert_id(), 28, 2,(SELECT preco FROM pizza WHERE id = 28));
SELECT * FROM pedido ORDER BY id DESC LIMIT 1;
CALL atulizaprecoPedido(28);
SELECT * FROM pedido ORDER BY id DESC LIMIT 1;

-- Procedimento armazenado pedido de um item
DROP PROCEDURE IF EXISTS pedidoDeUmItem;
DELIMITER //
CREATE PROCEDURE pedidoDeUmItem(_cliente_id INT, _pizza_id INT, _qtd INT)
BEGIN
    DECLARE _pedido_id INT;
    INSERT INTO pedido (cliente_id, data)
    VALUES (_cliente_id, NOW());
    SET _pedido_id = LAST_INSERT_ID();
    INSERT INTO itens_pedido (pedido_id, pizza_id, quantidade, valor_cobrado)
    VALUES (_pedido_id, _pizza_id, _qtd, (SELECT preco FROM pizza WHERE id = _pizza_id));
    UPDATE pedido
    SET valor_total = (SELECT SUM(valor_cobrado * quantidade) FROM itens_pedido WHERE pedido_id = _pedido_id)
    WHERE id = _pedido_id;
END //
DELIMITER ;
SHOW PROCEDURE STATUS;

-- Inserindo pedidos de um item testando a procedure
CALL pedidoDeUmItem(96,41,1);
SELECT * FROM pedido ORDER BY id DESC LIMIT 1;
SELECT * FROM itens_pedido ORDER BY id DESC LIMIT 1;
