-- ============================================================
--  CINEMA
-- ============================================================

USE CINEMA;

-- ------------------------------------------------------------
-- CATEGORIA
-- ------------------------------------------------------------
INSERT INTO CATEGORIA (DESCRICAO_CAT) VALUES
('Ação'),
('Comédia'),
('Drama'),
('Terror'),
('Animação'),
('Ficção Científica'),
('Romance'),
('Suspense');

-- ------------------------------------------------------------
-- FILME
-- ------------------------------------------------------------
INSERT INTO FILME (NOME_FILME, FAIXA_ETARIA, DURACAO_FILME, STATUS_FILME, ID_CATEGORIA) VALUES
('Vingadores: Fase Final',    12, 181, 'FORA CARTAZ', 1),
('Deadpool & Wolverine',      16, 127, 'EM CARTAZ',   1),
('Minha Mãe É Uma Peça 4',    10, 108, 'EM CARTAZ',   2),
('Ainda Estou Aqui',          16, 136, 'EM CARTAZ',   3),
('Terrifier 3',               18,  95, 'EM CARTAZ',   4),
('Divertidamente 2',           0, 100, 'FORA CARTAZ', 5),
('Duna: Parte Dois',          12, 166, 'FORA CARTAZ', 6),
('Alien: Romulus',            16, 119, 'EM CARTAZ',   6),
('O Corvo',                   16, 110, 'EM CARTAZ',   3),
('Beetlejuice Beetlejuice',   12, 104, 'EM CARTAZ',   2);

-- ------------------------------------------------------------
-- SALA
-- ------------------------------------------------------------
INSERT INTO SALA (DESCRICAO_SALA, TIPO_SALA, CAPACIDADE_SALA, VIP_SALA) VALUES
('Sala 1 - Standard 2D',   '2D',   120, FALSE),
('Sala 2 - Standard 2D',   '2D',   100, FALSE),
('Sala 3 - 3D Premium',    '3D',    80, FALSE),
('Sala 4 - 3D Premium',    '3D',    80, FALSE),
('Sala 5 - IMAX',          'IMAX',  60, FALSE),
('Sala VIP Gold',          '2D',    30, TRUE),
('Sala VIP IMAX',          'IMAX',  20, TRUE);

-- ------------------------------------------------------------
-- SESSAO
-- ------------------------------------------------------------
INSERT INTO SESSAO (DATA_HORA, ID_SALA, ID_FILME) VALUES
-- Hoje
('2026-04-29 14:00:00', 1, 2),  -- Deadpool & Wolverine - Sala 1
('2026-04-29 14:30:00', 3, 2),  -- Deadpool & Wolverine - Sala 3 (3D)
('2026-04-29 16:00:00', 2, 3),  -- Minha Mãe É Uma Peça 4 - Sala 2
('2026-04-29 17:00:00', 5, 8),  -- Alien: Romulus - IMAX
('2026-04-29 18:00:00', 6, 4),  -- Ainda Estou Aqui - VIP
('2026-04-29 19:30:00', 1, 5),  -- Terrifier 3 - Sala 1
('2026-04-29 20:00:00', 4, 8),  -- Alien: Romulus - 3D
('2026-04-29 21:00:00', 7, 2),  -- Deadpool & Wolverine - VIP IMAX
('2026-04-29 21:30:00', 2, 9),  -- O Corvo - Sala 2
('2026-04-29 22:00:00', 3, 10), -- Beetlejuice - 3D
-- Amanhã
('2026-04-30 10:00:00', 1, 10), -- Beetlejuice - Sala 1
('2026-04-30 13:00:00', 5, 2),  -- Deadpool & Wolverine - IMAX
('2026-04-30 15:30:00', 2, 3),  -- Minha Mãe É Uma Peça 4
('2026-04-30 18:00:00', 6, 4),  -- Ainda Estou Aqui - VIP
('2026-04-30 20:30:00', 3, 5);  -- Terrifier 3 - 3D

-- ------------------------------------------------------------
-- TIPO_INGRESSO
-- ------------------------------------------------------------
INSERT INTO TIPO_INGRESSO (DESCRICAO_INGRESSO, VALOR_INGRESSO) VALUES
('Inteira',            30.00),
('Meia-Entrada',       15.00),
('Estudante',          15.00),
('Idoso (60+)',        15.00),
('Funcionário',        10.00),
('Criança (até 3 anos)', 0.00),
('VIP Premium',        60.00),
('Combo Pipoca',       45.00);

-- ------------------------------------------------------------
-- CLIENTE
-- ------------------------------------------------------------
INSERT INTO CLIENTE (NOME_CLIENTE, CPF_CLIENTE, EMAIL_CLIENTE, STATUS_CLIENTE) VALUES
('Ana Paula Rodrigues',   '111.222.333-01', 'ana.paula@email.com',     'ATIVO'),
('Carlos Eduardo Souza',  '222.333.444-02', 'carlos.souza@email.com',  'ATIVO'),
('Beatriz Lima Ferreira', '333.444.555-03', 'bea.lima@email.com',      'ATIVO'),
('Diego Alves Martins',   '444.555.666-04', 'diego.alves@email.com',   'ATIVO'),
('Fernanda Costa Silva',  '555.666.777-05', 'fernanda.c@email.com',    'ATIVO'),
('Gabriel Nascimento',    '666.777.888-06', 'gabriel.n@email.com',     'INATIVO'),
('Heloísa Mendes Cruz',   '777.888.999-07', 'helo.mendes@email.com',   'ATIVO'),
('Igor Pereira Santos',   '888.999.000-08', 'igor.ps@email.com',       'ATIVO'),
('Juliana Torres Pinto',  '999.000.111-09', 'ju.torres@email.com',     'ATIVO'),
('Lucas Oliveira Braga',  '000.111.222-10', 'lucas.ob@email.com',      'ATIVO'),
('Mariana Gomes Freitas', '123.456.789-11', 'mari.gomes@email.com',    'ATIVO'),
('Nicolas Barbosa Leal',  '987.654.321-12', 'nicolas.bl@email.com',    'INATIVO');

-- ------------------------------------------------------------
-- PEDIDO
-- ------------------------------------------------------------
INSERT INTO PEDIDO (DATA_HORA, ID_CLIENTE, STATUS_PEDIDO) VALUES
('2026-04-29 13:00:00',  1, 'PAGO'),
('2026-04-29 13:15:00',  2, 'PAGO'),
('2026-04-29 13:30:00',  3, 'PAGO'),
('2026-04-29 14:00:00',  4, 'PAGO'),
('2026-04-29 14:10:00',  5, 'PAGO'),
('2026-04-29 15:00:00',  7, 'PAGO'),
('2026-04-29 15:30:00',  8, 'PAGO'),
('2026-04-29 16:00:00',  9, 'PAGO'),
('2026-04-29 16:20:00', 10, 'PAGO'),
('2026-04-29 17:00:00', 11, 'PAGO'),
('2026-04-29 17:30:00',  1, 'ABERTO'),
('2026-04-29 18:00:00',  3, 'CANCELADO'),
('2026-04-29 18:30:00',  5, 'ABERTO'),
('2026-04-29 19:00:00',  8, 'ABERTO'),
('2026-04-29 20:00:00',  2, 'CANCELADO');

-- ------------------------------------------------------------
-- INGRESSO
-- Referência de sessões:
--   1 = Deadpool Sala1 14h   | 2 = Deadpool 3D 14:30h
--   3 = Minha Mãe 16h        | 4 = Alien IMAX 17h
--   5 = Ainda Estou Aqui 18h | 6 = Terrifier 19:30h
--   7 = Alien 3D 20h         | 8 = Deadpool VIP IMAX 21h
--   9 = O Corvo 21:30h       |10 = Beetlejuice 3D 22h
-- ------------------------------------------------------------
INSERT INTO INGRESSO (ID_PEDIDO, ID_SESSAO, ID_TIPO_INGRESSO, VALOR_PAGO, STATUS_INGRESSO) VALUES
-- Pedido 1 - Ana (2 ingressos Deadpool Sala1)
(1,  1, 1, 30.00, 'PAGO'),
(1,  1, 2, 15.00, 'PAGO'),
-- Pedido 2 - Carlos (2 ingressos Alien IMAX)
(2,  4, 1, 30.00, 'PAGO'),
(2,  4, 1, 30.00, 'PAGO'),
-- Pedido 3 - Beatriz (Minha Mãe + Combo)
(3,  3, 8, 45.00, 'PAGO'),
(3,  3, 2, 15.00, 'PAGO'),
-- Pedido 4 - Diego (Deadpool 3D x2)
(4,  2, 1, 30.00, 'PAGO'),
(4,  2, 3, 15.00, 'PAGO'),
-- Pedido 5 - Fernanda (Ainda Estou Aqui - VIP)
(5,  5, 7, 60.00, 'PAGO'),
(5,  5, 7, 60.00, 'PAGO'),
-- Pedido 6 - Heloísa (Terrifier x1)
(6,  6, 1, 30.00, 'PAGO'),
-- Pedido 7 - Igor (Alien 3D)
(7,  7, 1, 30.00, 'PAGO'),
(7,  7, 2, 15.00, 'PAGO'),
-- Pedido 8 - Juliana (Deadpool VIP IMAX)
(8,  8, 7, 60.00, 'PAGO'),
-- Pedido 9 - Lucas (O Corvo)
(9,  9, 1, 30.00, 'PAGO'),
(9,  9, 4, 15.00, 'PAGO'),
-- Pedido 10 - Mariana (Beetlejuice 3D)
(10, 10, 1, 30.00, 'PAGO'),
(10, 10, 1, 30.00, 'PAGO'),
-- Pedido 11 - Ana (em aberto - sessão amanhã)
(11, 12, 1, 30.00, 'RESERVADO'),
-- Pedido 12 - Beatriz (cancelado)
(12,  3, 1, 30.00, 'CANCELADO'),
-- Pedido 13 - Fernanda (em aberto)
(13, 14, 7, 60.00, 'RESERVADO'),
(13, 14, 7, 60.00, 'RESERVADO'),
-- Pedido 14 - Igor (em aberto)
(14, 15, 1, 30.00, 'RESERVADO'),
-- Pedido 15 - Carlos (cancelado)
(15,  4, 1, 30.00, 'CANCELADO');

-- ============================================================
--  Verificação rápida
-- ============================================================
SELECT 'CATEGORIA'    AS tabela, COUNT(*) AS registros FROM CATEGORIA   UNION ALL
SELECT 'FILME',        COUNT(*) FROM FILME        UNION ALL
SELECT 'SALA',         COUNT(*) FROM SALA         UNION ALL
SELECT 'SESSAO',       COUNT(*) FROM SESSAO       UNION ALL
SELECT 'TIPO_INGRESSO',COUNT(*) FROM TIPO_INGRESSO UNION ALL
SELECT 'CLIENTE',      COUNT(*) FROM CLIENTE      UNION ALL
SELECT 'PEDIDO',       COUNT(*) FROM PEDIDO       UNION ALL
SELECT 'INGRESSO',     COUNT(*) FROM INGRESSO;