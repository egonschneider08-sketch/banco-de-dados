-- Active: 1780941987624@@mysql-13746642-egonschneider08-c85e.h.aivencloud.com@10714@industrial_db
--DROP DATABASE IF EXISTS industria_db;
--CREATE DATABASE industria_db;
--USE industria_db;

-- 1. SETORES (Não depende de ninguém)
CREATE TABLE setores (
    id_setores INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    localizacao VARCHAR(100) NOT NULL
);

-- 2. FUNCIONARIOS (Depende apenas de setores)
CREATE TABLE funcionarios (
    id_funcionarios INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    data_contratacao DATE NOT NULL,
    id_setores INT NOT NULL,
    FOREIGN KEY (id_setores) REFERENCES setores(id_setores)
);

-- 3. CATEGORIA_PRODUTOS (Corrigido: sem a coluna id_produtos para evitar o loop)
CREATE TABLE categoria_produtos (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(100) NOT NULL -- Mudado de CHAR para VARCHAR
);

-- 4. PRODUTOS_INDUSTRIAIS (Depende de categoria_produtos)
CREATE TABLE produtos_industriais (
    id_produtos INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco_fabricacao DECIMAL(10,2) NOT NULL,
    quantidade_estoque INT NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria_produtos(id_categoria)
);

-- 5. FORNECEDORES (Depende de categoria_produtos)
CREATE TABLE fornecedores (
    id_fornecedores INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(14) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria_produtos(id_categoria)
);

-- 6. ORDENS_PRODUCAO (Depende de funcionarios e produtos_industriais)
CREATE TABLE ordens_producao (
    id_ordens_producao INT AUTO_INCREMENT PRIMARY KEY,
    data_criacao DATE NOT NULL,
    quantidade_produzida INT NOT NULL,
    status_producao VARCHAR(50) NOT NULL,
    tempo_estimado INT NOT NULL,
    tempo_real INT NOT NULL,
    id_funcionarios INT NOT NULL,
    id_produtos INT NOT NULL,
    FOREIGN KEY (id_funcionarios) REFERENCES funcionarios(id_funcionarios),
    FOREIGN KEY (id_produtos) REFERENCES produtos_industriais(id_produtos)
);

-- 7. CONTROLE_QUALIDADE (Depende de ordens_producao)
CREATE TABLE controle_qualidade (
    id_controle_qualidade INT AUTO_INCREMENT PRIMARY KEY,
    data_inspecao DATE NOT NULL,
    resultado VARCHAR(50) NOT NULL,
    observacoes TEXT,
    id_ordens_producao INT NOT NULL,
    FOREIGN KEY (id_ordens_producao) REFERENCES ordens_producao(id_ordens_producao)
);