


CREATE DATABASE IF NOT EXISTS LojaDB;
USE LojaDB;

-- =========================
-- TABELA CATEGORIA
-- =========================
CREATE TABLE Categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);

-- =========================
-- TABELA PRODUTO
-- =========================
CREATE TABLE Produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

-- =========================
-- TABELA CLIENTE
-- =========================
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15)
);

-- =========================
-- TABELA VENDA
-- =========================
CREATE TABLE Venda (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    data DATE NOT NULL,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- =========================
-- TABELA ITEMVENDA (ASSOCIATIVA)
-- =========================
CREATE TABLE ItemVenda (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_venda) REFERENCES Venda(id_venda),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);
-- Categorias
INSERT INTO Categoria (nome) VALUES
('Alimentos'),
('Higiene'),
('Bebidas');

-- Produtos
INSERT INTO Produto (nome, preco, id_categoria) VALUES
('Arroz 5kg', 25.00, 1),
('Feijão 1kg', 8.50, 1),
('Sabonete', 3.00, 2),
('Shampoo', 12.00, 2),
('Refrigerante', 6.50, 3);

-- Clientes
INSERT INTO Cliente (nome, telefone) VALUES
('João', '999999999'),
('Maria', '888888888');

-- Vendas
INSERT INTO Venda (data, id_cliente) VALUES
('2025-04-01', 1),
('2025-04-02', 2);

-- Itens da venda
INSERT INTO ItemVenda (id_venda, id_produto, quantidade, subtotal) VALUES
(1, 1, 2, 50.00),
(1, 3, 3, 9.00),
(2, 2, 1, 8.50),
(2, 5, 2, 13.00);
