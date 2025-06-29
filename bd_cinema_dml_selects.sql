USE bd_cinema;

# 1.Seleção de Filme, Categoria, Sala e Valor da sessão mesmo que não tenha sessão registrada
SELECT f.nome_fil, c.nome_cat_fil, s.numero_sal, ses.valor_ses FROM Sessoes AS ses
RIGHT JOIN Filmes AS f ON f.id_fil = ses.id_filme_fk
INNER JOIN Categorias_Filme AS c ON c.id_cat_fil = f.id_categoria_fk
LEFT JOIN Salas AS s ON s.id_sal = ses.id_sala_fk;

# 2.Ingressos vendidos por sessão
SELECT COUNT(i.id_ing)
FROM Ingressos AS i
INNER JOIN Sessoes AS s 
	ON s.id_ses = i.id_sessao_fk
WHERE s.id_ses = 1;
    
# 3.Assentos livres por sessão
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

# 6.Selecionando todos os clientes que possuem ao menos uma compra no sistema
SELECT c.* FROM Clientes AS c WHERE (SELECT COUNT(*) FROM Vendas WHERE id_cliente_fk = c.id_cli) >= 1;

# 7.Filmes com a duração superior a média geral
#Obs: primeiro converto de hh:mm:ss para segundos para tirar a média, depois para hh:mm:ss para poder saber quem é maior do que a média
SELECT f.* FROM Filmes AS f WHERE f.duracao_fil > (SELECT SEC_TO_TIME(AVG(TIME_TO_SEC(Filmes.duracao_fil))) FROM Filmes);

# 8.Nomes dos produtos vendidos mais de UMA vez
SELECT p.nome_prod, SUM(pv.quantidade_prod_ven) FROM Produtos_Venda AS pv
INNER JOIN Produtos AS p ON pv.id_produto_fk = p.id_prod
GROUP BY p.nome_prod HAVING(COUNT(*)) > 1;

######################### Gráficos

# Gráfico de Linha - Faturamento Mensal
SELECT 
    YEAR(dt_fim_cai) AS ano,
    MONTH(dt_fim_cai) AS mes,
    SUM(total_ent_cai) AS total_entrada_mensal,
    SUM(total_sai_cai) AS total_saida_mensal,
    SUM((valor_ini_cai + total_ent_cai) - total_sai_cai) AS total_lucro_mensal
FROM Caixas
GROUP BY ano, mes
ORDER BY ano, mes;

SELECT * FROM Caixas;

# Gráfico de Barras - Filmes mais populares
SELECT f.nome_fil, COUNT(*) AS quantidade_vendida FROM Ingressos AS i
INNER JOIN Sessoes AS s 
	ON s.id_ses = i.id_sessao_fk
INNER JOIN Filmes AS f 
	ON f.id_fil = s.id_filme_fk
GROUP BY f.id_fil
ORDER BY quantidade_vendida DESC;

# Gráfico de Barras - Produto mais vendido
SELECT p.nome_prod, SUM(pv.quantidade_prod_ven) AS quantidade_vendida FROM Produtos_Venda AS pv
INNER JOIN Produtos AS p ON p.id_prod = pv.id_produto_fk
GROUP BY p.id_prod
ORDER BY quantidade_vendida DESC;

# Gráfico de Pizza - Funcionário com mais venda (valor)
SELECT f.nome_fun, SUM(v.total_ven) AS valor FROM Vendas AS v
INNER JOIN Caixas AS c ON c.id_cai = v.id_caixa_fk
INNER JOIN Funcionarios AS f ON f.id_fun = c.id_funcionario_fk
GROUP BY f.id_fun
ORDER BY valor DESC;