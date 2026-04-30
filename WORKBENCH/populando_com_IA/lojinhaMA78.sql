-- ============================================================
--  LOJINHA78 — Script Completo (DDL + DML)
--  Melhorias aplicadas:
--   • DECIMAL(10,2) em todos os campos de valor/peso
--   • FK adicionada em item_venda (id_venda, id_produto)
--   • FK adicionada em estoque (id_fornecedor)
--   • Dados realistas e coerentes entre tabelas
-- ============================================================

DROP DATABASE IF EXISTS lojinha78;
CREATE DATABASE lojinha78 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE lojinha78;

-- ============================================================
-- TABELAS
-- ============================================================

CREATE TABLE cliente (
    id_cliente          INT           PRIMARY KEY AUTO_INCREMENT,
    nome_cliente        VARCHAR(100)  NOT NULL,
    sobrenome_cliente   VARCHAR(100)  NOT NULL,
    cpf_cliente         VARCHAR(14)   UNIQUE NOT NULL,   -- formato: 000.000.000-00
    telefone_cliente    VARCHAR(20)   UNIQUE NOT NULL,
    email_cliente       VARCHAR(100)  UNIQUE NOT NULL,
    cidade_cliente      VARCHAR(60)   NOT NULL,
    cep_cliente         VARCHAR(10)   NOT NULL,
    data_cadastro       DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ativo               TINYINT(1)    NOT NULL DEFAULT 1
);

CREATE TABLE fornecedor (
    id_fornecedor       INT           PRIMARY KEY AUTO_INCREMENT,
    nome_fornecedor     VARCHAR(100)  NOT NULL,
    cnpj_fornecedor     VARCHAR(20)   NOT NULL UNIQUE,
    telefone_fornecedor VARCHAR(20)   NOT NULL,
    email_fornecedor    VARCHAR(100)  NOT NULL UNIQUE,
    cidade_fornecedor   VARCHAR(60),
    status_fornecedor   ENUM('ATIVO','INATIVO','BLOQUEADO') NOT NULL DEFAULT 'ATIVO'
);

CREATE TABLE produto (
    id_produto              INT             PRIMARY KEY AUTO_INCREMENT,
    nome_produto            VARCHAR(100)    NOT NULL,
    descricao_produto       TEXT,
    preco_produto           DECIMAL(10,2)   NOT NULL,
    custo_produto           DECIMAL(10,2),                -- preço de compra
    categoria_produto       VARCHAR(40),
    marca_produto           VARCHAR(40),
    codigo_barras           VARCHAR(50)     UNIQUE,
    data_validade_produto   DATE,
    peso_decimal            DECIMAL(10,2)   NOT NULL,
    estoque_minimo          INT             NOT NULL DEFAULT 10,
    status_produto          ENUM('disponivel','indisponivel','NAN') NOT NULL DEFAULT 'disponivel'
);

CREATE TABLE venda (
    id_venda                    INT             PRIMARY KEY AUTO_INCREMENT,
    data_venda                  DATETIME        NOT NULL,
    valor_total                 DECIMAL(10,2)   NOT NULL,
    forma_pagamento             VARCHAR(30)     NOT NULL,
    desconto_venda              DECIMAL(10,2)   DEFAULT 0.00,
    id_cliente_na_tabela_venda  INT,
    status_venda                ENUM('PENDENTE','CONCLUIDA','CANCELADA') NOT NULL DEFAULT 'PENDENTE',
    observacao_venda            TEXT,
    caixa_venda                 INT             NOT NULL,
    FOREIGN KEY (id_cliente_na_tabela_venda) REFERENCES cliente(id_cliente)
);

CREATE TABLE item_venda (
    id_item_venda       INT             PRIMARY KEY AUTO_INCREMENT,
    id_venda            INT             NOT NULL,
    id_produto          INT             NOT NULL,
    quantidade_item     INT             NOT NULL CHECK (quantidade_item > 0),
    preco_item          DECIMAL(10,2)   NOT NULL,
    desconto_item       DECIMAL(10,2)   DEFAULT 0.00,
    imposto_item        DECIMAL(10,2)   DEFAULT 0.00,
    observacao_item     TEXT,
    FOREIGN KEY (id_venda)    REFERENCES venda(id_venda),
    FOREIGN KEY (id_produto)  REFERENCES produto(id_produto)
);

CREATE TABLE estoque (
    id_estoque                  INT             PRIMARY KEY AUTO_INCREMENT,
    id_produto                  INT             NOT NULL,
    id_fornecedor               INT,
    quantidade_estoque          INT             NOT NULL,
    quantidade_minima_estoque   INT             NOT NULL,
    localizacao_estoque         VARCHAR(40)     NOT NULL,
    data_hora_entrada           DATETIME        NOT NULL,
    data_hora_saida             DATETIME,
    lote                        VARCHAR(30)     NOT NULL,
    validade                    DATE            NOT NULL,
    status_estoque              ENUM('OK','BAIXO','VENCIDO','QUARENTENA') NOT NULL DEFAULT 'OK',
    FOREIGN KEY (id_produto)    REFERENCES produto(id_produto),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor)
);

CREATE TABLE pagamento (
    id_pagamento            INT             PRIMARY KEY AUTO_INCREMENT,
    id_venda                INT             NOT NULL,
    tipo_pagamento          VARCHAR(30)     NOT NULL,
    valor_pagamento         DECIMAL(10,2)   NOT NULL,
    data_pagamento          DATETIME        NOT NULL,
    parcelas_pagamento      INT             NOT NULL DEFAULT 1,
    imposto_pagamento       DECIMAL(10,2)   NOT NULL DEFAULT 0.00,
    bandeira_pagamento      VARCHAR(30)     DEFAULT 'SEM CARTÃO',
    observacao_pagamento    TEXT,
    status_pagamento        ENUM('APROVADO','RECUSADO','PENDENTE') NOT NULL DEFAULT 'APROVADO',
    FOREIGN KEY (id_venda) REFERENCES venda(id_venda)
);

-- ============================================================
-- DADOS — ordem respeita todas as FKs
-- ============================================================

-- ------------------------------------------------------------
-- CLIENTE (10 registros)
-- ------------------------------------------------------------
INSERT INTO cliente (nome_cliente, sobrenome_cliente, cpf_cliente, telefone_cliente, email_cliente, cidade_cliente, cep_cliente, data_cadastro) VALUES
('Ana',      'Souza',     '123.456.789-01', '(47) 99111-0001', 'ana.souza@email.com',       'Joinville',      '89201-000', '2025-01-10 08:00:00'),
('Carlos',   'Lima',      '234.567.890-12', '(47) 99111-0002', 'carlos.lima@email.com',     'Florianópolis',  '88010-000', '2025-02-15 09:30:00'),
('Beatriz',  'Martins',   '345.678.901-23', '(47) 99111-0003', 'bia.martins@email.com',     'Blumenau',       '89010-000', '2025-03-05 10:00:00'),
('Diego',    'Ferreira',  '456.789.012-34', '(41) 99111-0004', 'diego.ferreira@email.com',  'Curitiba',       '80010-000', '2025-03-20 11:00:00'),
('Larissa',  'Oliveira',  '567.890.123-45', '(11) 99111-0005', 'larissa.oli@email.com',     'São Paulo',      '01310-000', '2025-04-01 08:30:00'),
('Marcos',   'Pereira',   '678.901.234-56', '(47) 99111-0006', 'marcos.pereira@email.com',  'Joinville',      '89220-100', '2025-05-10 14:00:00'),
('Fernanda', 'Costa',     '789.012.345-67', '(48) 99111-0007', 'fernanda.costa@email.com',  'Florianópolis',  '88015-200', '2025-06-18 15:30:00'),
('Rafael',   'Alves',     '890.123.456-78', '(47) 99111-0008', 'rafael.alves@email.com',    'Joinville',      '89201-500', '2025-07-22 09:00:00'),
('Juliana',  'Rodrigues', '901.234.567-89', '(51) 99111-0009', 'juliana.rod@email.com',     'Porto Alegre',   '90010-000', '2025-08-30 10:45:00'),
('Paulo',    'Nascimento','012.345.678-90', '(61) 99111-0010', 'paulo.nasci@email.com',     'Brasília',       '70040-010', '2025-09-05 13:00:00');

-- ------------------------------------------------------------
-- FORNECEDOR (10 registros)
-- ------------------------------------------------------------
INSERT INTO fornecedor (nome_fornecedor, cnpj_fornecedor, telefone_fornecedor, email_fornecedor, cidade_fornecedor, status_fornecedor) VALUES
('Distribuidora Norte SC',  '11.222.333/0001-81', '(47) 3300-1001', 'contato@norteesc.com',       'Joinville',     'ATIVO'),
('Alimentos Sul Ltda',      '22.333.444/0001-92', '(48) 3300-1002', 'vendas@alimentossul.com',    'Florianópolis', 'ATIVO'),
('Cleaning Pro Brasil',     '33.444.555/0001-03', '(41) 3300-1003', 'sac@cleaningpro.com',        'Curitiba',      'ATIVO'),
('MegaFoods Brasil',        '44.555.666/0001-14', '(11) 3300-1004', 'mf@megafoods.com.br',        'São Paulo',     'INATIVO'),
('Grupo Abastece',          '55.666.777/0001-25', '(51) 3300-1005', 'info@abastece.com',          'Porto Alegre',  'BLOQUEADO'),
('FastSupply Logística',    '66.777.888/0001-36', '(47) 3300-1006', 'fast@fastsupply.com.br',     'Joinville',     'ATIVO'),
('Higiene Total Ltda',      '77.888.999/0001-47', '(19) 3300-1007', 'ht@higienatotal.com',        'Campinas',      'ATIVO'),
('Verde Campo Alimentos',   '88.999.000/0001-58', '(16) 3300-1008', 'verde@verdecampo.com.br',    'Ribeirão Preto','ATIVO'),
('TechCold Refrigeração',   '99.000.111/0001-69', '(11) 3300-1009', 'tc@techcold.com.br',         'São Paulo',     'ATIVO'),
('Prime Goods Distribuidora','00.111.222/0001-70', '(21) 3300-1010', 'prime@primegoods.com.br',   'Rio de Janeiro','ATIVO');

-- ------------------------------------------------------------
-- PRODUTO (10 registros)
-- ------------------------------------------------------------
INSERT INTO produto (nome_produto, descricao_produto, preco_produto, custo_produto, categoria_produto, marca_produto, codigo_barras, data_validade_produto, peso_decimal, estoque_minimo, status_produto) VALUES
('Arroz Integral 5kg',    'Arroz integral tipo 1, grão longo',           24.90, 14.50, 'Alimentos',  'Tio João',   '7891234560001', '2026-12-01', 5.00,  20,  'disponivel'),
('Feijão Carioca 1kg',    'Feijão carioca tipo 1, grão selecionado',      8.50,  4.80, 'Alimentos',  'Camil',      '7891234560002', '2026-10-01', 1.00,  30,  'disponivel'),
('Óleo de Soja 900ml',    'Óleo de soja refinado, zero trans',            7.99,  4.20, 'Alimentos',  'Liza',       '7891234560003', '2027-03-01', 0.90,  25,  'disponivel'),
('Detergente Neutro 500ml','Detergente líquido, fórmula concentrada',     2.49,  1.10, 'Limpeza',    'Ypê',        '7891234560004', '2028-01-01', 0.50,  50,  'disponivel'),
('Sabão em Pó 1kg',       'Sabão multiação, remove gordura e manchas',   13.90,  7.60, 'Limpeza',    'OMO',        '7891234560005', '2027-06-01', 1.00,  20,  'disponivel'),
('Macarrão Espaguete 500g','Macarrão de sêmola de trigo grano duro',      4.29,  2.10, 'Alimentos',  'Barilla',    '7891234560006', '2027-09-01', 0.50,  40,  'disponivel'),
('Molho de Tomate 340g',  'Molho pronto temperado com ervas finas',       3.79,  1.80, 'Alimentos',  'Pomarola',   '7891234560007', '2026-08-01', 0.34,  30,  'disponivel'),
('Água Sanitária 1L',     'Alvejante e desinfetante, cloro ativo 2,0%',   3.49,  1.50, 'Limpeza',    'Qboa',       '7891234560008', '2027-01-01', 1.00,  40,  'disponivel'),
('Achocolatado 400g',     'Achocolatado em pó, vitaminas A, C e D',      12.90,  7.20, 'Bebidas',    'Nescau',     '7891234560009', '2026-11-01', 0.40,  15,  'disponivel'),
('Café Torrado 500g',     'Café torrado e moído, torra média',           18.90, 10.50, 'Bebidas',    'Pilão',      '7891234560010', '2026-09-01', 0.50,  20,  'disponivel');

-- ------------------------------------------------------------
-- VENDA (10 registros)
-- ------------------------------------------------------------
INSERT INTO venda (data_venda, valor_total, forma_pagamento, desconto_venda, id_cliente_na_tabela_venda, status_venda, observacao_venda, caixa_venda) VALUES
('2026-03-01 09:15:00', 47.39,  'Cartão Crédito', 2.00,  1,  'CONCLUIDA', 'Cliente fidelizado, 3x sem juros',     1),
('2026-03-05 11:30:00', 25.47,  'PIX',            0.00,  2,  'CONCLUIDA', NULL,                                    1),
('2026-03-10 14:00:00', 102.47, 'Dinheiro',       5.00,  3,  'CONCLUIDA', 'Troco realizado no caixa',             2),
('2026-03-15 16:45:00', 13.98,  'Cartão Débito',  0.00,  4,  'CONCLUIDA', NULL,                                    2),
('2026-03-20 10:00:00', 55.79,  'PIX',            3.00,  5,  'CONCLUIDA', 'Desconto fidelidade aplicado',         1),
('2026-03-25 13:30:00', 38.28,  'Cartão Crédito', 0.00,  6,  'CONCLUIDA', '2x no crédito',                        1),
('2026-04-01 09:00:00', 29.17,  'PIX',            0.00,  7,  'CONCLUIDA', NULL,                                    2),
('2026-04-07 15:20:00', 74.50,  'Cartão Crédito', 5.00,  8,  'CONCLUIDA', 'Parcelado em 4x',                      1),
('2026-04-15 11:00:00', 22.68,  'Dinheiro',       0.00,  9,  'CONCLUIDA', NULL,                                    2),
('2026-04-20 10:00:00', 63.57,  'PIX',            3.00, 10,  'PENDENTE',  'Aguardando confirmação do pagamento',  1);

-- ------------------------------------------------------------
-- ITEM_VENDA (10 registros — cada venda com pelo menos 1 item)
-- ------------------------------------------------------------
INSERT INTO item_venda (id_venda, id_produto, quantidade_item, preco_item, desconto_item, imposto_item, observacao_item) VALUES
(1,  1,  1, 24.90, 0.00, 1.50, NULL),
(1,  2,  1,  8.50, 0.00, 0.50, NULL),           -- venda 1 tem 2 itens
(2,  3,  2,  7.99, 0.00, 0.60, '2 unidades'),
(3,  5,  3, 13.90, 0.00, 0.80, 'Promoção limpeza'),
(3,  8,  2,  3.49, 0.00, 0.20, NULL),            -- venda 3 tem 2 itens
(4,  4,  3,  2.49, 0.00, 0.15, NULL),
(5,  9,  2, 12.90, 0.00, 0.70, 'Presente embrulhado'),
(6,  6,  4,  4.29, 0.00, 0.25, NULL),
(7,  7,  3,  3.79, 0.00, 0.20, NULL),
(8, 10,  2, 18.90, 0.00, 1.00, 'Café premium'),
(9,  4,  2,  2.49, 0.00, 0.15, NULL),
(9,  8,  2,  3.49, 0.00, 0.20, NULL),            -- venda 9 tem 2 itens
(10, 1,  1, 24.90, 0.00, 1.50, NULL),
(10, 9,  1, 12.90, 0.00, 0.70, NULL);             -- venda 10 tem 2 itens

-- ------------------------------------------------------------
-- ESTOQUE (10 registros)
-- ------------------------------------------------------------
INSERT INTO estoque (id_produto, id_fornecedor, quantidade_estoque, quantidade_minima_estoque, localizacao_estoque, data_hora_entrada, data_hora_saida, lote, validade, status_estoque) VALUES
(1,  1, 120, 20, 'Corredor A - Prateleira 1', '2026-01-10 08:00:00', '2026-12-01 00:00:00', 'LOTE-2026-001', '2026-12-01', 'OK'),
(2,  2, 200, 30, 'Corredor A - Prateleira 2', '2026-01-12 08:00:00', '2026-10-01 00:00:00', 'LOTE-2026-002', '2026-10-01', 'OK'),
(3,  2,  80, 15, 'Corredor B - Prateleira 1', '2026-01-15 08:00:00', '2027-03-01 00:00:00', 'LOTE-2026-003', '2027-03-01', 'OK'),
(4,  3, 500, 50, 'Corredor C - Prateleira 1', '2026-01-18 08:00:00', '2028-01-01 00:00:00', 'LOTE-2026-004', '2028-01-01', 'OK'),
(5,  3,  60, 10, 'Corredor C - Prateleira 2', '2026-01-20 08:00:00', '2027-06-01 00:00:00', 'LOTE-2026-005', '2027-06-01', 'OK'),
(6,  8, 150, 40, 'Corredor A - Prateleira 3', '2026-01-22 08:00:00', '2027-09-01 00:00:00', 'LOTE-2026-006', '2027-09-01', 'OK'),
(7,  8, 180, 30, 'Corredor A - Prateleira 4', '2026-01-25 08:00:00', '2026-08-01 00:00:00', 'LOTE-2026-007', '2026-08-01', 'OK'),
(8,  7, 300, 40, 'Corredor C - Prateleira 3', '2026-01-28 08:00:00', '2027-01-01 00:00:00', 'LOTE-2026-008', '2027-01-01', 'OK'),
(9,  6,  45, 15, 'Corredor B - Prateleira 2', '2026-02-01 08:00:00', '2026-11-01 00:00:00', 'LOTE-2026-009', '2026-11-01', 'BAIXO'),
(10, 1,  90, 20, 'Corredor B - Prateleira 3', '2026-02-05 08:00:00', '2026-09-01 00:00:00', 'LOTE-2026-010', '2026-09-01', 'OK');

-- ------------------------------------------------------------
-- PAGAMENTO (10 registros)
-- ------------------------------------------------------------
INSERT INTO pagamento (id_venda, tipo_pagamento, valor_pagamento, data_pagamento, parcelas_pagamento, imposto_pagamento, bandeira_pagamento, observacao_pagamento, status_pagamento) VALUES
(1,  'Crédito', 47.39, '2026-03-01 09:16:00', 3,  1.42, 'Visa',        'Parcelado 3x sem juros',              'APROVADO'),
(2,  'PIX',     25.47, '2026-03-05 11:31:00', 1,  0.00, 'SEM CARTÃO',  NULL,                                   'APROVADO'),
(3,  'Dinheiro',102.47,'2026-03-10 14:01:00', 1,  0.00, 'SEM CARTÃO',  'Desconto R$ 5,00 aplicado no caixa',  'APROVADO'),
(4,  'Débito',  13.98, '2026-03-15 16:46:00', 1,  0.42, 'Mastercard',  NULL,                                   'APROVADO'),
(5,  'PIX',     55.79, '2026-03-20 10:01:00', 1,  0.00, 'SEM CARTÃO',  'Desconto fidelidade R$ 3,00',         'APROVADO'),
(6,  'Crédito', 38.28, '2026-03-25 13:31:00', 2,  1.15, 'Elo',         'Parcelado 2x',                        'APROVADO'),
(7,  'PIX',     29.17, '2026-04-01 09:01:00', 1,  0.00, 'SEM CARTÃO',  NULL,                                   'APROVADO'),
(8,  'Crédito', 74.50, '2026-04-07 15:21:00', 4,  2.24, 'Visa',        'Parcelado 4x',                        'APROVADO'),
(9,  'Dinheiro',22.68, '2026-04-15 11:01:00', 1,  0.00, 'SEM CARTÃO',  NULL,                                   'APROVADO'),
(10, 'PIX',     63.57, '2026-04-20 10:01:00', 1,  0.00, 'SEM CARTÃO',  'Aguardando confirmação do cliente',   'PENDENTE');

-- ============================================================
-- VERIFICAÇÃO RÁPIDA
-- ============================================================
SELECT 'cliente'    AS tabela, COUNT(*) AS registros FROM cliente    UNION ALL
SELECT 'fornecedor'           , COUNT(*)              FROM fornecedor UNION ALL
SELECT 'produto'              , COUNT(*)              FROM produto    UNION ALL
SELECT 'venda'                , COUNT(*)              FROM venda      UNION ALL
SELECT 'item_venda'           , COUNT(*)              FROM item_venda UNION ALL
SELECT 'estoque'              , COUNT(*)              FROM estoque    UNION ALL
SELECT 'pagamento'            , COUNT(*)              FROM pagamento;