USE bd_cinema;

# 1.Filmes em exibição com horários e salas
SELECT f.nome_fil, s.hora_ses, sl.numero_sal
FROM Sessoes AS s
INNER JOIN Filmes AS f
	ON f.id_fil = s.id_filme_fk
INNER JOIN Salas AS sl
	ON sl.id_sal = s.id_sala_fk
WHERE s.data_ses = CURDATE();


# 2.Sessões futuras de um determinado filme
SELECT f.nome_fil, s.data_ses, s.hora_ses, s.valor_ses, sl.numero_sal, s.meia_ses
FROM Sessoes AS s
INNER JOIN Filmes AS f
	ON f.id_fil = s.id_filme_fk
INNER JOIN Salas AS sl
	ON sl.id_sal = s.id_sala_fk
WHERE
	(s.data_ses = CURDATE() AND s.hora_ses > CURTIME()) OR s.data_ses > CURDATE() AND f.id_fil = 1;
    
# 3.Assentos ocupados por sessão
SELECT a.numero_ass 
FROM Assentos AS a
INNER JOIN Sessoes AS s 
	ON s.id_sala_fk = a.id_sala_fk
LEFT JOIN Ingressos AS i 
	ON i.id_assento_fk = a.id_ass AND i.id_sessao_fk = s.id_ses
WHERE i.id_ing IS NULL AND s.id_ses = 1;

# 4.Vendas por dia, mês ou período, e como foi pago
SELECT SUM(v.total_ven), f.nome_for_pag
FROM Vendas AS v
INNER JOIN Formas_Pagamento AS f
	ON v.id_forma_pagamento_fk = f.id_for_pag
WHERE v.data_ven BETWEEN '2025-05-01' AND '2025-05-31'
GROUP BY f.nome_for_pag;

# 5.Produtos mais vendidos
SELECT p.id_prod, p.nome_prod, SUM(pv.quantidade_prod_ven) AS quantidade_vendida, tp.nome_tip_pro AS tipo_produto
FROM Produtos_Venda AS pv
INNER JOIN Produtos AS p 
	ON p.id_prod = pv.id_produto_fk
INNER JOIN Tipos_Produto AS tp ON tp.id_tip_pro = p.id_tipo_produto_fk
GROUP BY p.id_prod
ORDER BY SUM(pv.quantidade_prod_ven) DESC;

# 6.Ingressos vendidos por sessão
SELECT COUNT(i.id_ing)
FROM Ingressos AS i
INNER JOIN Sessoes AS s 
	ON s.id_ses = i.id_sessao_fk
WHERE s.id_ses = 1;

# 7.Resumo financeiro do caixa
SELECT f.nome_fun AS caixa, SUM(c.total_ent_cai) AS entrada, SUM(c.total_sai_cai) AS saida, SUM(c.total_ent_cai) - SUM(c.total_sai_cai) AS total
FROM Caixas AS c
INNER JOIN Funcionarios AS f ON f.id_fun = c.id_funcionario_fk
WHERE c.dt_ini_cai BETWEEN '2025-05-01' AND '2025-05-31'
GROUP BY f.nome_fun
ORDER BY f.nome_fun;
