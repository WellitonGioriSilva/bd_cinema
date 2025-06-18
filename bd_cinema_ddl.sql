CREATE DATABASE bd_cinema;
USE bd_cinema;

CREATE TABLE Categorias_Filme(
    id_cat_fil INT PRIMARY KEY AUTO_INCREMENT,
    nome_cat_fil VARCHAR(50) NOT NULL
);

CREATE TABLE Filmes(
    id_fil INT PRIMARY KEY AUTO_INCREMENT,
    nome_fil VARCHAR(100),
    sinopse_fil TEXT,
    duracao_fil TIME,
    id_categoria_fk INT NOT NULL,
    FOREIGN KEY(id_categoria_fk) REFERENCES Categorias_Filme(id_cat_fil)
);

CREATE TABLE Salas(
    id_sal INT PRIMARY KEY AUTO_INCREMENT,
    numero_sal INT
);

CREATE TABLE Sessoes(
    id_ses INT PRIMARY KEY AUTO_INCREMENT,
    valor_ses FLOAT,
    meia_ses BOOLEAN,
    data_ses DATE,
    hora_ses TIME,
    id_filme_fk INT NOT NULL,
    FOREIGN KEY(id_filme_fk) REFERENCES Filmes(id_fil),
    id_sala_fk INT NOT NULL,
    FOREIGN KEY(id_sala_fk) REFERENCES Salas(id_sal)
);

CREATE TABLE Assentos(
    id_ass INT PRIMARY KEY AUTO_INCREMENT,
    numero_ass INT NOT NULL,
    id_sala_fk INT NOT NULL,
    FOREIGN KEY(id_sala_fk) REFERENCES Salas(id_sal)
);

CREATE TABLE Clientes(
    id_cli INT PRIMARY KEY AUTO_INCREMENT,
    nome_cli VARCHAR(100),
    cpf_cli VARCHAR(14) UNIQUE NOT NULL,
    dt_nascimento_cli DATE
);

CREATE TABLE Funcionarios(
    id_fun INT PRIMARY KEY AUTO_INCREMENT,
    nome_fun VARCHAR(100),
    cpf_fun VARCHAR(14) UNIQUE NOT NULL,
    dt_nascimento_fun DATE,
    rg_fun VARCHAR(12) UNIQUE NOT NULL,
    salario_fun FLOAT
);

CREATE TABLE Formas_Pagamento(
    id_for_pag INT PRIMARY KEY AUTO_INCREMENT,
    nome_for_pag VARCHAR(50)
);
 
CREATE TABLE Caixas(
    id_cai INT PRIMARY KEY AUTO_INCREMENT,
    valor_ini_cai FLOAT,
    valor_fim_cai FLOAT,
    dt_ini_cai DATETIME,
    dt_fim_cai DATETIME,
    total_ent_cai FLOAT,
    total_sai_cai FLOAT,
    id_funcionario_fk INT NOT NULL,
    FOREIGN KEY(id_funcionario_fk) REFERENCES Funcionarios(id_fun)
);

CREATE TABLE Tipos_Produto(
    id_tip_pro INT PRIMARY KEY AUTO_INCREMENT,
    nome_tip_pro VARCHAR(50)
);

CREATE TABLE Produtos(
    id_prod INT PRIMARY KEY AUTO_INCREMENT,
    nome_prod VARCHAR(100),
    descricao TEXT,
    id_tipo_produto_fk INT NOT NULL,
    FOREIGN KEY(id_tipo_produto_fk) REFERENCES Tipos_Produto(id_tip_pro)
);

CREATE TABLE Estoques(
    id_est INT PRIMARY KEY AUTO_INCREMENT,
    validade_est DATE,
    quantidade_est FLOAT,
    lote_est VARCHAR(30),
    id_produto_fk INT NOT NULL,
    FOREIGN KEY(id_produto_fk) REFERENCES Produtos(id_prod)
);

CREATE TABLE Historicos(
    id_his INT PRIMARY KEY AUTO_INCREMENT,
    valor_his FLOAT,
    promocao_his BOOLEAN,
    valor_promocao_his FLOAT,
    id_produto_fk INT NOT NULL,
    FOREIGN KEY(id_produto_fk) REFERENCES Produtos(id_prod)
);

CREATE TABLE Vendas(
    id_ven INT PRIMARY KEY AUTO_INCREMENT,
    sub_total_ven FLOAT,
    data_ven DATE,
    desconto_ven FLOAT,
    total_ven FLOAT,
    id_cliente_fk INT,
    FOREIGN KEY(id_cliente_fk) REFERENCES Clientes(id_cli),
    id_caixa_fk INT NOT NULL,
    FOREIGN KEY(id_caixa_fk) REFERENCES Caixas(id_cai),
    id_forma_pagamento_fk INT NOT NULL,
    FOREIGN KEY(id_forma_pagamento_fk) REFERENCES Formas_Pagamento(id_for_pag)
);

CREATE TABLE Produtos_Venda(
    id_prod_ven INT PRIMARY KEY AUTO_INCREMENT,
    quantidade_prod_ven INT,
    valor_unitario_prod_ven FLOAT,
    id_produto_fk INT NOT NULL,
    FOREIGN KEY(id_produto_fk) REFERENCES Produtos(id_prod),
    id_venda_fk INT NOT NULL,
    FOREIGN KEY(id_venda_fk) REFERENCES Vendas(id_ven)
);

CREATE TABLE Ingressos(
    id_ing INT PRIMARY KEY AUTO_INCREMENT,
    meia_ing BOOLEAN,
    id_sessao_fk INT NOT NULL,
    FOREIGN KEY(id_sessao_fk) REFERENCES Sessoes(id_ses),
    id_assento_fk INT NOT NULL,
    FOREIGN KEY(id_assento_fk) REFERENCES Assentos(id_ass),
    id_venda_fk INT NOT NULL,
    FOREIGN KEY(id_venda_fk) REFERENCES Vendas(id_ven)
);
