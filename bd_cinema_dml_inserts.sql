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

-- Categorias_Filme
INSERT INTO Categorias_Filme (nome_cat_fil) VALUES 
('Ação'), ('Comédia'), ('Drama'), ('Terror'), ('Ficção Científica'),
('Romance'), ('Documentário'), ('Animação'), ('Aventura'), ('Suspense');

-- Filmes
INSERT INTO Filmes (nome_fil, sinopse_fil, duracao_fil, id_categoria_fk) VALUES
('Explosão Urbana', 'Um policial enfrenta uma gangue em uma metrópole.', '01:45:00', 1),
('Risadas em Família', 'Comédia sobre o cotidiano de uma família excêntrica.', '01:30:00', 2),
('Lágrimas do Tempo', 'Drama sobre amor e perda ao longo dos anos.', '02:00:00', 3),
('Noite Macabra', 'Um grupo de amigos em uma casa mal-assombrada.', '01:40:00', 4),
('Além do Espaço', 'Uma missão intergaláctica cheia de reviravoltas.', '02:20:00', 5),
('Amor em Paris', 'Um romance inesperado nas ruas da França.', '01:50:00', 6),
('Planeta Azul', 'Documentário sobre os oceanos do planeta.', '01:20:00', 7),
('Mundo Encantado', 'Uma animação sobre um reino mágico.', '01:35:00', 8),
('Viagem Extrema', 'Grupo de exploradores em busca de um tesouro perdido.', '02:10:00', 9),
('Silêncio Mortal', 'Uma sequência de crimes abala a cidade.', '01:55:00', 10);

-- Salas
INSERT INTO Salas (numero_sal) VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Sessoes
INSERT INTO Sessoes (valor_ses, meia_ses, data_ses, hora_ses, id_filme_fk, id_sala_fk) VALUES
(25.00, FALSE, CURDATE(), '18:00:00', 1, 1),
(25.00, TRUE, '2025-06-01', '20:00:00', 2, 2),
(30.00, FALSE, '2025-06-02', '19:00:00', 3, 3),
(28.00, TRUE, '2025-06-02', '21:00:00', 4, 4),
(32.00, FALSE, '2025-06-03', '17:00:00', 5, 5),
(26.00, TRUE, '2025-06-04', '19:30:00', 6, 6),
(20.00, FALSE, '2025-06-04', '18:00:00', 7, 7),
(22.00, TRUE, '2025-06-05', '16:30:00', 8, 8),
(35.00, FALSE, '2025-06-05', '21:00:00', 9, 9),
(27.00, TRUE, '2025-06-06', '20:00:00', 9, 10);

-- Clientes
INSERT INTO Clientes (nome_cli, cpf_cli, dt_nascimento_cli) VALUES
('Ana Silva', '123.456.789-00', '1990-01-01'),
('Carlos Souza', '234.567.890-11', '1985-05-15'),
('Marina Rocha', '345.678.901-22', '1992-08-25'),
('Pedro Gomes', '456.789.012-33', '1978-11-30'),
('Joana Lima', '567.890.123-44', '2000-03-10'),
('Rafael Costa', '678.901.234-55', '1995-12-12'),
('Larissa Mendes', '789.012.345-66', '1999-07-07'),
('Bruno Ferreira', '890.123.456-77', '1987-10-21'),
('Luciana Moreira', '901.234.567-88', '1983-04-18'),
('Diego Nunes', '012.345.678-99', '1991-06-03');

-- Funcionarios
INSERT INTO Funcionarios (nome_fun, cpf_fun, dt_nascimento_fun, rg_fun, salario_fun) VALUES
('Lucas Andrade', '987.654.321-00', '1982-04-22', '12.345.678-9', 3000.00),
('Fernanda Dias', '876.543.210-11', '1991-07-19', '23.456.789-0', 2800.00),
('Roberto Martins', '765.432.109-22', '1988-12-05', '34.567.890-1', 3100.00),
('Juliana Paes', '654.321.098-33', '1993-09-23', '45.678.901-2', 2900.00),
('Tiago Pereira', '543.210.987-44', '1986-02-17', '56.789.012-3', 3200.00),
('Amanda Farias', '432.109.876-55', '1990-03-14', '67.890.123-4', 3000.00),
('Eduardo Lima', '321.098.765-66', '1984-11-11', '78.901.234-5', 3100.00),
('Camila Torres', '210.987.654-77', '1996-08-22', '89.012.345-6', 2800.00),
('Marcelo Pinto', '109.876.543-88', '1992-06-06', '90.123.456-7', 2900.00),
('Patrícia Ramos', '098.765.432-99', '1989-09-09', '01.234.567-8', 3050.00);

-- Formas_Pagamento
INSERT INTO Formas_Pagamento (nome_for_pag) VALUES
('Dinheiro'), ('Cartão de Crédito'), ('Cartão de Débito'), ('PIX'), ('Vale Presente'),
('Boleto'), ('Transferência'), ('Carteira Digital'), ('PayPal'), ('Crédito Loja');

-- Caixas
INSERT INTO Caixas (valor_ini_cai, valor_fim_cai, dt_ini_cai, dt_fim_cai, total_ent_cai, total_sai_cai, id_funcionario_fk) VALUES
(500.00, 1000.00, '2025-05-20 14:00:00', '2025-05-20 22:00:00', 1500.00, 1000.00, 1),
(400.00, 800.00, '2025-05-21 14:00:00', '2025-05-21 22:00:00', 1300.00, 900.00, 2),
(300.00, 600.00, '2025-05-22 14:00:00', '2025-05-22 22:00:00', 1200.00, 800.00, 3),
(600.00, 1100.00, '2025-05-23 14:00:00', '2025-05-23 22:00:00', 1600.00, 1000.00, 4),
(500.00, 900.00, '2025-05-24 14:00:00', '2025-05-24 22:00:00', 1400.00, 1000.00, 5),
(450.00, 950.00, '2025-05-25 14:00:00', '2025-05-25 22:00:00', 1450.00, 1000.00, 6),
(470.00, 970.00, '2025-05-26 14:00:00', '2025-05-26 22:00:00', 1470.00, 1000.00, 7),
(480.00, 980.00, '2025-05-27 14:00:00', '2025-05-27 22:00:00', 1480.00, 1000.00, 8),
(490.00, 990.00, '2025-05-28 14:00:00', '2025-05-28 22:00:00', 1490.00, 1000.00, 9),
(495.00, 995.00, '2025-05-29 14:00:00', '2025-05-29 22:00:00', 1495.00, 1000.00, 10);

-- Tipos_Produto
INSERT INTO Tipos_Produto (nome_tip_pro) VALUES
('Bebida'), ('Pipoca'), ('Doce'), ('Salgado'), ('Combo'),
('Brinde'), ('Sanduíche'), ('Sorvete'), ('Café'), ('Kit Infantil');

-- Produtos
INSERT INTO Produtos (nome_prod, descricao_prod, valor_prod, id_tipo_produto_fk) VALUES
('Refrigerante Lata', '350ml diversos sabores', 6.00, 1),
('Pipoca Média', 'Pipoca salgada média', 10.00, 2),
('Chocolate', 'Chocolate barra 100g', 8.00, 3),
('Salgadinho', 'Salgadinho de queijo 80g', 7.00, 4),
('Combo Clássico', 'Pipoca grande + 2 refrigerantes', 20.00, 5),
('Chaveiro Cinema', 'Brinde exclusivo do mês', 5.00, 6),
('Mini Sanduíche', 'Sanduíche natural pequeno', 12.00, 7),
('Sorvete Copo', 'Sorvete 150ml diversos sabores', 9.00, 8),
('Café Expresso', 'Café expresso quente', 4.00, 9),
('Kit Pipoca Kids', 'Pipoca pequena + suco', 15.00, 10);

-- Estoques
INSERT INTO Estoques (validade_est, quantidade_est, lote_est, id_produto_fk) VALUES
('2025-07-01', 100, 'L001', 1),
('2025-07-15', 50, 'L002', 2),
('2025-08-01', 80, 'L003', 3),
('2025-06-30', 60, 'L004', 4),
('2025-07-20', 40, 'L005', 5),
('2025-09-01', 30, 'L006', 6),
('2025-08-10', 70, 'L007', 7),
('2025-08-25', 90, 'L008', 8),
('2025-07-30', 120, 'L009', 9),
('2025-09-15', 50, 'L010', 10);

-- Historicos
INSERT INTO Historicos (valor_his, promocao_his, valor_promocao_his, id_produto_fk) VALUES
(6.00, TRUE, 5.00, 1),
(10.00, FALSE, 0.00, 2),
(8.00, TRUE, 6.00, 3),
(7.00, FALSE, 0.00, 4),
(20.00, TRUE, 18.00, 5),
(5.00, TRUE, 4.00, 6),
(12.00, FALSE, 0.00, 7),
(9.00, TRUE, 7.50, 8),
(4.00, FALSE, 0.00, 9),
(15.00, TRUE, 12.00, 10);

-- Vendas
INSERT INTO Vendas (sub_total_ven, data_ven, desconto_ven, total_ven, id_cliente_fk, id_caixa_fk, id_forma_pagamento_fk) VALUES
(25.00, '2025-05-20', 0.00, 25.00, 1, 1, 1),
(25.00, '2025-05-21', 0.00, 25.00, 2, 2, 2),
(30.00, '2025-05-22', 0.00, 30.00, 3, 3, 3),
(28.00, '2025-05-23', 0.00, 28.00, 4, 4, 4),
(32.00, '2025-05-24', 0.00, 32.00, 5, 5, 5),
(12.00, '2025-05-25', 0.00, 12.00, 6, 6, 6),
(10.00, '2025-05-26', 0.00, 10.00, 7, 7, 7),
(24.00, '2025-05-27', 0.00, 24.00, 8, 8, 8),
(14.00, '2025-05-28', 0.00, 14.00, 9, 9, 9),
(18.00, '2025-05-29', 0.00, 18.00, 1, 10, 10);

-- Ingressos
INSERT INTO Ingressos (meia_ing, id_sessao_fk, id_assento_fk, id_venda_fk) VALUES
(FALSE, 1, 1, 1),
(TRUE, 2, 31, 2),
(FALSE, 3, 61, 3),
(FALSE, 4, 91, 4),
(FALSE, 5, 121, 5),
(TRUE, 6, 151, 6),
(TRUE, 7, 181, 7),
(FALSE, 8, 211, 8),
(TRUE, 9, 241, 9),
(FALSE, 10, 271, 10);

-- Produtos_Venda
INSERT INTO Produtos_Venda (quantidade_prod_ven, valor_unitario_prod_ven, id_produto_fk, id_venda_fk) VALUES
(2, 6.00, 1, 6),
(1, 10.00, 2, 7),
(3, 8.00, 3, 8),
(2, 7.00, 4, 9),
(1, 18.00, 5, 10),
(1, 5.00, 6, 1),
(2, 12.00, 7, 2),
(1, 9.00, 8, 3),
(1, 4.00, 9, 4),
(2, 15.00, 10, 5),
(1, 15.00, 10, 5);