
#comentarios 
#criar um banco de exemplo 
#criação banco de dados
 
create database lojinha78;

use lojinha78; -- comando para usar um bd especifico 

show databases;-- mostrar bancos atuais 

-- criando uma tabela padrao
CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome_cliente VARCHAR(100) not null,
    sobrenome_cliente VARCHAR(100) not null,
    cpf_cliente VARCHAR(11) UNIQUE not null,
    telefone_cliente VARCHAR(20) UNIQUE not null,
    email_cliente VARCHAR(80) UNIQUE not null,
    cidade_cliente VARCHAR(50) not null,
    cep_cliente VARCHAR(10) not null
);
#incluindo um BD
-- drop database lojinha78 
CREATE TABLE produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    descricao_produto TEXT,
    preco_produto DECIMAL(5 , 2 ),
    categoria_produto VARCHAR(20),
    marca_produto VARCHAR(20),
    codigo_barras VARCHAR(50),
    data_validade_produto DATE DEFAULT '2026-01-01',
    peso_decimal DECIMAL(5 , 2 ) NOT NULL,
    status_produto ENUM('disponivel', 'indisponivel', 'NAN')
);

CREATE TABLE fornecedor (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome_fornecedor VARCHAR(100) NOT NULL,
    cnpj_fornecedor VARCHAR(20) NOT NULL UNIQUE,
    telefone_fornecedor VARCHAR(20) NOT NULL,
    email_fornecedor VARCHAR(100) NOT NULL UNIQUE,
    status_fornecedor ENUM('ATIVO', 'INATIVO', 'BLOQUEADO')
);

CREATE TABLE venda (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    data_venda DATETIME NOT NULL,
    valor_total DECIMAL(5 , 2 ) NOT NULL,
    forma_pagamento VARCHAR(30) NOT NULL,
    desconto_venda DECIMAL(5 , 2 ),
    id_cliente_na_tabela_venda INT,
    status_venda VARCHAR(20) NOT NULL,
    observacao_venda TEXT,
    caixa_venda INT NOT NULL,
    FOREIGN KEY (id_cliente_na_tabela_venda)
        REFERENCES cliente (id_cliente)
);

CREATE TABLE item_venda (
    id_item_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_venda INT,
    id_produto INT,
    quantidade_item INT NOT NULL,
    preco_item DECIMAL(5 , 2 ) NOT NULL,
    imposto_item DECIMAL(5 , 2 ),
    observacao_item TEXT
);

CREATE TABLE estoque (
    id_estoque INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT,
    quantidade_estoque INT NOT NULL,
    quantidade_minima_estoque INT NOT NULL,
    localizacao_estoque VARCHAR(30) NOT NULL,
    data_hora_entrada DATETIME NOT NULL,
    data_hora_saida DATETIME NOT NULL,
    lote VARCHAR(20) NOT NULL,
    validade DATE NOT NULL,
    status_estoque VARCHAR(20),
    FOREIGN KEY (id_produto)
        REFERENCES produto (id_produto)
);

CREATE TABLE pagamento (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_venda INT,
    tipo_pagamneto VARCHAR(20) NOT NULL,
    valor_pagamento DECIMAL(5 , 2 ) NOT NULL,
    data_pagamento DATETIME NOT NULL,
    parcelas_pagamento INT NOT NULL,
    imposto_pagamento DECIMAL(5 , 2 ) NOT NULL,
    bandeira_pagamento VARCHAR(20) DEFAULT 'PAGAMENTO SEM CARTAO',
    obsevacao_pagamento TEXT,
    FOREIGN KEY (id_venda)
        REFERENCES venda (id_venda)
);

-- drop database lojinha78








