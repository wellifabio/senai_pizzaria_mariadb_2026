-- Gatilho que atualiza o valor do pedido após a inserção de um item.
DROP TRIGGER IF EXISTS trg_atualiza_valor_pedido;
DELIMITER //
CREATE TRIGGER trg_atualiza_valor_pedido
AFTER INSERT ON itens_pedido
FOR EACH ROW
BEGIN
    UPDATE pedido
    SET valor_total = (
        SELECT COALESCE(SUM(valor_cobrado * quantidade), 0)
        FROM itens_pedido
        WHERE pedido_id = NEW.pedido_id
    )
    WHERE id = NEW.pedido_id;
END //
DELIMITER ;
SHOW TRIGGERS;

-- Inserindo mais um ítem no ultimo pedido para testar
INSERT INTO itens_pedido VALUES (default,30, 2, 2, 32.93);
SELECT * FROM pedido ORDER BY id DESC LIMIT 1;
SELECT * FROM itens_pedido WHERE pedido_id = 30;