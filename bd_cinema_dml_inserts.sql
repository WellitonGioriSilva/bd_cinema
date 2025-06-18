USE bd_cinema;

#################### TRIGGERS
-- Assentos
DELIMITER $$
CREATE TRIGGER CriarAssentos AFTER INSERT ON Salas
FOR EACH ROW
BEGIN
	DECLARE contador INT DEFAULT 1;
    
    WHILE contador <= 30 DO
		INSERT INTO Assentos (numero_ass, id_sala_fk) VALUES (contador, NEW.id_sal);
        SET contador = contador + 1;
    END WHILE;
END;
$$ DELIMITER ;

#################### INSERTS
-- Categorias_Filme
INSERT INTO Categorias_Filme (nome_cat_fil) VALUES 
('Ação'), ('Comédia'), ('Drama'), ('Terror'), ('Ficção Científica');

-- Filmes
INSERT INTO Filmes (nome_fil, sinopse_fil, duracao_fil, id_categoria_fk) VALUES
('Explosão Urbana', 'Um policial enfrenta uma gangue em uma metrópole.', '01:45:00', 1),
('Risadas em Família', 'Comédia sobre o cotidiano de uma família excêntrica.', '01:30:00', 2),
('Lágrimas do Tempo', 'Drama sobre amor e perda ao longo dos anos.', '02:00:00', 3),
('Noite Macabra', 'Um grupo de amigos em uma casa mal-assombrada.', '01:40:00', 4),
('Além do Espaço', 'Uma missão intergaláctica cheia de reviravoltas.', '02:20:00', 5);

-- Salas
INSERT INTO Salas (numero_sal) VALUES (1), (2), (3), (4), (5);

-- Sessoes
INSERT INTO Sessoes (valor_ses, meia_ses, data_ses, hora_ses, id_filme_fk, id_sala_fk) VALUES
(25.00, FALSE, CURDATE(), '18:00:00', 1, 1),
(25.00, TRUE, '2025-06-01', '20:00:00', 2, 2),
(30.00, FALSE, '2025-06-02', '19:00:00', 3, 3),
(28.00, TRUE, '2025-06-02', '21:00:00', 4, 4),
(32.00, FALSE, '2025-06-03', '17:00:00', 5, 5);

-- Clientes
INSERT INTO Clientes (nome_cli, cpf_cli, dt_nascimento_cli) VALUES
('Ana Silva', '123.456.789-00', '1990-01-01'),
('Carlos Souza', '234.567.890-11', '1985-05-15'),
('Marina Rocha', '345.678.901-22', '1992-08-25'),
('Pedro Gomes', '456.789.012-33', '1978-11-30'),
('Joana Lima', '567.890.123-44', '2000-03-10');

-- Funcionarios
INSERT INTO Funcionarios (nome_fun, cpf_fun, dt_nascimento_fun, rg_fun, salario_fun) VALUES
('Lucas Andrade', '987.654.321-00', '1982-04-22', '12.345.678-9', 3000.00),
('Fernanda Dias', '876.543.210-11', '1991-07-19', '23.456.789-0', 2800.00),
('Roberto Martins', '765.432.109-22', '1988-12-05', '34.567.890-1', 3100.00),
('Juliana Paes', '654.321.098-33', '1993-09-23', '45.678.901-2', 2900.00),
('Tiago Pereira', '543.210.987-44', '1986-02-17', '56.789.012-3', 3200.00);

-- Formas_Pagamento
INSERT INTO Formas_Pagamento (nome_for_pag) VALUES
('Dinheiro'), ('Cartão de Crédito'), ('Cartão de Débito'), ('PIX'), ('Vale Presente');

-- Caixas
INSERT INTO Caixas (valor_ini_cai, valor_fim_cai, dt_ini_cai, dt_fim_cai, total_ent_cai, total_sai_cai, id_funcionario_fk) VALUES
(500.00, 1000.00, '2025-05-20 14:00:00', '2025-05-20 22:00:00', 1500.00, 1000.00, 1),
(400.00, 800.00, '2025-05-21 14:00:00', '2025-05-21 22:00:00', 1300.00, 900.00, 2),
(300.00, 600.00, '2025-05-22 14:00:00', '2025-05-22 22:00:00', 1200.00, 800.00, 3),
(600.00, 1100.00, '2025-05-23 14:00:00', '2025-05-23 22:00:00', 1600.00, 1000.00, 4),
(500.00, 900.00, '2025-05-24 14:00:00', '2025-05-24 22:00:00', 1400.00, 1000.00, 5);

-- Tipos_Produto
INSERT INTO Tipos_Produto (nome_tip_pro) VALUES
('Bebida'), ('Pipoca'), ('Doce'), ('Salgado'), ('Combo');

-- Produtos
INSERT INTO Produtos (nome_prod, descricao, id_tipo_produto_fk) VALUES
('Refrigerante Lata', '350ml diversos sabores', 1),
('Pipoca Média', 'Pipoca salgada média', 2),
('Chocolate', 'Chocolate barra 100g', 3),
('Salgadinho', 'Salgadinho de queijo 80g', 4),
('Combo Clássico', 'Pipoca grande + 2 refrigerantes', 5);

-- Estoques
INSERT INTO Estoques (validade_est, quantidade_est, lote_est, id_produto_fk) VALUES
('2025-07-01', 100, 'L001', 1),
('2025-07-15', 50, 'L002', 2),
('2025-08-01', 80, 'L003', 3),
('2025-06-30', 60, 'L004', 4),
('2025-07-20', 40, 'L005', 5);

-- Historicos
INSERT INTO Historicos (valor_his, promocao_his, valor_promocao_his, id_produto_fk) VALUES
(6.00, TRUE, 5.00, 1),
(10.00, FALSE, 0.00, 2),
(8.00, TRUE, 6.00, 3),
(7.00, FALSE, 0.00, 4),
(18.00, TRUE, 15.00, 5);

-- Vendas
INSERT INTO Vendas (sub_total_ven, data_ven, desconto_ven, total_ven, id_cliente_fk, id_caixa_fk, id_forma_pagamento_fk) VALUES
(37.00, '2025-05-20', 5.00, 32.00, 1, 1, 1),
(22.50, '2025-05-21', 0.00, 22.50, 2, 2, 2),
(54.00, '2025-05-22', 2.00, 52.00, 3, 3, 3),
(42.00, '2025-05-23', 10.00, 32.00, 4, 4, 4),
(50.00, '2025-05-24', 0.00, 50.00, 5, 5, 5);

-- Produtos_Venda
INSERT INTO Produtos_Venda (quantidade_prod_ven, valor_unitario_prod_ven, id_produto_fk, id_venda_fk) VALUES
(2, 6.00, 1, 1),
(1, 10.00, 2, 2),
(3, 8.00, 3, 3),
(2, 7.00, 4, 4),
(1, 18.00, 5, 5);

-- Ingressos
INSERT INTO Ingressos (meia_ing, id_sessao_fk, id_assento_fk, id_venda_fk) VALUES
(FALSE, 1, 1, 1),
(TRUE, 2, 31, 2),
(FALSE, 3, 61, 3),
(FALSE, 4, 91, 4),
(FALSE, 5, 121, 5);