USE automacao;

-- Inserindo mais Tags (Sensores e Atuadores)
INSERT INTO tags (tag_nome, descricao, endereco_clp, tipo_dado) VALUES 
('CLP_01_VALV_ALIM', 'Abertura da Válvula de Alimentação', 'HR 40003', 'Analógico'),
('CLP_01_TEMP_PROCESSO', 'Temperatura da Massa de Processo', 'HR 40004', 'Analógico'),
('CLP_02_ESTEIRA_ST', 'Status de Movimento da Esteira 02', 'Coil 00002', 'Digital'),
('CLP_02_CONT_PECA', 'Contador de Peças Produzidas', 'HR 40005', 'Analógico'),
('CLP_02_PRESSAO_LINHA', 'Pressão da Rede de Ar Comprimido', 'HR 40006', 'Analógico');

-- Inserindo mais Histórico (Telemetria)
INSERT INTO historico_automacao (tag_id, data_hora, valor_digital, valor_analogico, qualidade_sinal) VALUES
(3, '2026-06-08 15:15:00', NULL, 100.0, 192),  -- Válvula 100% aberta
(4, '2026-06-08 15:15:00', NULL, 45.2, 192),   -- Temp 45.2°C
(5, '2026-06-08 15:15:10', FALSE, NULL, 192),  -- Esteira parada
(6, '2026-06-08 15:16:00', NULL, 12.0, 192),   -- 12 Peças
(7, '2026-06-08 15:16:30', NULL, 6.2, 192),    -- Pressão 6.2 bar
(4, '2026-06-08 15:20:00', NULL, 98.5, 192),   -- Temp subiu para 98.5°C
(7, '2026-06-08 15:21:00', NULL, 3.1, 0),      -- Pressão caiu para 3.1 bar (Sinal Ruim)
(3, '2026-06-08 15:22:00', NULL, 0.0, 192),    -- Válvula fechada (0%)
(6, '2026-06-08 15:25:00', NULL, 150.0, 192);  -- 150 Peças

-- Configurando mais Alarmes
INSERT INTO alarmes_config (tag_id, tipo_alarme, limite_disparo, prioridade) VALUES
(4, 'Alto (H)', 90.0, 'Médio'),               -- Temperatura > 90°C
(7, 'Baixo (L)', 4.0, 'Alto'),                -- Pressão < 4.0 bar
(3, 'Desvio', 80.0, 'Baixo');                 -- Válvula aberta > 80%

-- Gerando mais Logs de Alarme
INSERT INTO log_alarmes (alarme_id, data_ativacao, data_normalizacao, data_reconhecimento, operador) VALUES
(2, '2026-06-08 15:20:00', '2026-06-08 15:30:00', '2026-06-08 15:22:00', 'Operador_Luiz'),
(3, '2026-06-08 15:21:00', NULL, NULL, NULL);