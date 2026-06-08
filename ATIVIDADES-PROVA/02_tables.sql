-- Active: 1780941987624@@mysql-13746642-egonschneider08-c85e.h.aivencloud.com@10714@automacao
-- 1. CADASTRO DE TAGS (Pontos de I/O e Registradores dos CLPs)


USE automacao;

-- 1. CADASTRO DE TAGS
CREATE TABLE tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tag_nome VARCHAR(100) UNIQUE NOT NULL,
    descricao VARCHAR(255),
    endereco_clp VARCHAR(50),
    tipo_dado VARCHAR(20) NOT NULL
);

-- 2. HISTÓRICO DE TELEMETRIA
CREATE TABLE historico_automacao (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    tag_id INT NOT NULL,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_analogico DECIMAL(10,3),
    valor_digital BOOLEAN,
    qualidade_sinal INT,
    
    CONSTRAINT fk_hist_tag
        FOREIGN KEY (tag_id)
        REFERENCES tags(id)
);

-- 3. CONFIGURAÇÃO DE LIMITES DE ALARME
CREATE TABLE alarmes_config (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tag_id INT NOT NULL,
    tipo_alarme VARCHAR(20),
    limite_disparo DECIMAL(10,3),
    prioridade VARCHAR(10),

    CONSTRAINT fk_alarme_tag
        FOREIGN KEY (tag_id)
        REFERENCES tags(id)
);

-- 4. LOG DE EVENTOS E ALARMES
CREATE TABLE log_alarmes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    alarme_id INT NOT NULL,
    data_ativacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_normalizacao TIMESTAMP NULL,
    data_reconhecimento TIMESTAMP NULL,
    operador VARCHAR(50),

    CONSTRAINT fk_log_alarme
        FOREIGN KEY (alarme_id)
        REFERENCES alarmes_config(id)
);