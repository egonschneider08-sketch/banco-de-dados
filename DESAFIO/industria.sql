CREATE DATABASE INDUSTRIA;
USE INDUSTRIA;

CREATE TABLE FUNCIONARIO (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(80),
    setor VARCHAR(50),
    data_admissao DATE,
    salario DECIMAL(10, 2),
    email VARCHAR(100),
    telefone VARCHAR(20),
    cidade VARCHAR(50),
    estado CHAR(2),
    status_funcionario VARCHAR(20)
);