-- Active: 1780941987624@@mysql-13746642-egonschneider08-c85e.h.aivencloud.com@10714@automacao

USE automacao;

SELECT tag_id, valor_analogico FROM historico_automacao
WHERE valor_analogico = (SELECT MAX(valor_analogico) FROM historico_automacao);

SELECT * FROM historico_automacao
WHERE valor_analogico < (SELECT AVG(valor_analogico) FROM historico_automacao);

SELECT * FROM alarmes_config
WHERE limite_disparo = (SELECT MAX(limite_disparo) FROM alarmes_config);

SELECT DISTINCT tag_id FROM historico_automacao
WHERE qualidade_sinal = (SELECT MAX(qualidade_sinal) FROM historico_automacao);

SELECT * FROM historico_automacao
WHERE valor_analogico < (SELECT AVG(valor_analogico) FROM historico_automacao WHERE tag_id = 2);

SELECT * FROM alarmes_config
WHERE limite_disparo > (SELECT AVG(limite_disparo) FROM alarmes_config);

SELECT * FROM historico_automacao
WHERE valor_analogico = (SELECT MIN(valor_analogico) FROM historico_automacao);

SELECT * FROM historico_automacao
WHERE valor_analogico > (SELECT AVG(valor_analogico) FROM historico_automacao WHERE tag_id = 4);

SELECT * FROM alarmes_config
WHERE limite_disparo <> (SELECT MAX(limite_disparo) FROM alarmes_config);

SELECT * FROM historico_automacao
WHERE qualidade_sinal = (SELECT MIN(qualidade_sinal) FROM historico_automacao);


-- --------------------------------------------------------------------
-- Bloco 2 — Subquery com IN / NOT IN
-- --------------------------------------------------------------------

SELECT tag_nome FROM tags
WHERE id IN (SELECT DISTINCT tag_id FROM historico_automacao);

SELECT tag_nome FROM tags
WHERE id IN (SELECT DISTINCT tag_id FROM alarmes_config);

SELECT * FROM historico_automacao
WHERE tag_id IN (SELECT id FROM tags WHERE tag_nome = 'CLP_01_TANQUE_NIVEL');

SELECT tag_nome FROM tags
WHERE id IN (SELECT tag_id FROM alarmes_config WHERE limite_disparo > 50.0);

SELECT tag_nome FROM tags
WHERE id IN (SELECT tag_id FROM alarmes_config WHERE prioridade = 'Critico');

SELECT tag_nome FROM tags
WHERE id IN (SELECT tag_id FROM historico_automacao GROUP BY tag_id HAVING COUNT(*) > 3);

SELECT tag_nome FROM tags
WHERE id NOT IN (SELECT DISTINCT tag_id FROM alarmes_config);

SELECT tag_nome FROM tags
WHERE id IN (SELECT tag_id FROM historico_automacao WHERE qualidade_sinal < 192);

SELECT tag_nome FROM tags
WHERE id IN (SELECT tag_id FROM alarmes_config WHERE id IN (SELECT alarme_id FROM log_alarmes WHERE operador IS NOT NULL));

SELECT * FROM historico_automacao
WHERE tag_id IN (SELECT tag_id FROM alarmes_config WHERE limite_disparo = (SELECT MAX(limite_disparo) FROM alarmes_config));


-- --------------------------------------------------------------------
-- Bloco 3 — Subquery com Operadores de Comparação
-- --------------------------------------------------------------------

SELECT * FROM historico_automacao
WHERE valor_analogico > (SELECT AVG(valor_analogico) FROM historico_automacao WHERE tag_id = 2);

SELECT id, tag_nome FROM tags
WHERE (SELECT AVG(qualidade_sinal) FROM historico_automacao WHERE tag_id = tags.id) > (SELECT AVG(qualidade_sinal) FROM historico_automacao);

SELECT * FROM alarmes_config
WHERE limite_disparo > (SELECT AVG(limite_disparo) FROM alarmes_config);

SELECT * FROM alarmes_config
WHERE limite_disparo = (SELECT MAX(limite_disparo) FROM alarmes_config);

SELECT * FROM alarmes_config
WHERE limite_disparo < (SELECT AVG(limite_disparo) FROM alarmes_config WHERE prioridade = 'Critico');

SELECT ac.tag_id FROM alarmes_config ac
GROUP BY ac.tag_id
HAVING COUNT(ac.id) > (SELECT COUNT(*) / COUNT(DISTINCT alarme_id) FROM log_alarmes);

SELECT * FROM historico_automacao
WHERE valor_analogico > ALL (SELECT valor_analogico FROM historico_automacao WHERE tag_id = 3 AND valor_analogico IS NOT NULL);

SELECT tag_id FROM historico_automacao
GROUP BY tag_id
HAVING MIN(qualidade_sinal) > (SELECT AVG(sub.menor) FROM (SELECT MIN(qualidade_sinal) as menor FROM historico_automacao GROUP BY tag_id) sub);

SELECT * FROM historico_automacao
WHERE valor_analogico = (SELECT AVG(valor_analogico) FROM historico_automacao);

SELECT * FROM alarmes_config
WHERE limite_disparo < (SELECT MAX(limite_disparo) FROM alarmes_config);


-- --------------------------------------------------------------------
-- Bloco 4 — Subquery como Nova Coluna (SELECT Expression)
-- --------------------------------------------------------------------

SELECT t.tag_nome, 
       (SELECT COUNT(*) FROM historico_automacao h WHERE h.tag_id = t.id) AS Total_Leituras
FROM tags t;

SELECT ac.*, 
       (SELECT AVG(valor_analogico) FROM historico_automacao h WHERE h.tag_id = ac.tag_id) AS Media_Analogica
FROM alarmes_config ac;

SELECT t.tag_nome,
       (SELECT COUNT(*) FROM log_alarmes l JOIN alarmes_config ac ON l.alarme_id = ac.id WHERE ac.tag_id = t.id AND l.data_normalizacao IS NULL) AS Alarmes_Ativos
FROM tags t;

SELECT t.tag_nome,
       (SELECT COUNT(*) FROM alarmes_config ac WHERE ac.tag_id = t.id) AS Qtd_Alarmes_Configurados
FROM tags t;

SELECT t.tag_nome,
       (SELECT MAX(valor_analogico) FROM historico_automacao h WHERE h.tag_id = t.id) AS Maior_Valor
FROM tags t;

SELECT DISTINCT ac.prioridade,
       (SELECT COUNT(*) FROM log_alarmes l JOIN alarmes_config ac2 ON l.alarme_id = ac2.id WHERE ac2.prioridade = ac.prioridade) AS Total_Ocorrencias
FROM alarmes_config ac;

SELECT t.tag_nome,
       (SELECT AVG(qualidade_sinal) FROM historico_automacao h WHERE h.tag_id = t.id) AS Media_Sinal_Tag
FROM tags t;

SELECT ac.id, ac.tipo_alarme,
       (SELECT COUNT(*) FROM log_alarmes l WHERE l.alarme_id = ac.id) AS Total_Disparos
FROM alarmes_config ac;

SELECT t.tag_nome,
       (SELECT COUNT(DISTINCT l.operador) FROM log_alarmes l JOIN alarmes_config ac ON l.alarme_id = ac.id WHERE ac.tag_id = t.id AND l.operador IS NOT NULL) AS Operadores_Distintos
FROM tags t;

SELECT ac.id, ac.tipo_alarme,
       (SELECT COUNT(*) FROM log_alarmes l WHERE l.alarme_id = ac.id AND l.data_normalizacao IS NOT NULL) AS Ocorrencias_Normalizadas
FROM alarmes_config ac;


-- --------------------------------------------------------------------
-- Bloco 5 — Desafios (GROUP BY + HAVING + SUBQUERY)
-- --------------------------------------------------------------------

SELECT tag_id, AVG(valor_analogico) AS Media_Tag 
FROM historico_automacao
WHERE valor_analogico IS NOT NULL
GROUP BY tag_id
HAVING AVG(valor_analogico) > (SELECT AVG(valor_analogico) FROM historico_automacao);

SELECT prioridade, AVG(limite_disparo) 
FROM alarmes_config
GROUP BY prioridade
HAVING AVG(limite_disparo) > (SELECT AVG(limite_disparo) FROM alarmes_config);

SELECT ac.tag_id, COUNT(l.id) 
FROM log_alarmes l
JOIN alarmes_config ac ON l.alarme_id = ac.id
GROUP BY ac.tag_id
HAVING COUNT(l.id) > (SELECT COUNT(*) / COUNT(DISTINCT tag_id) FROM log_alarmes l2 JOIN alarmes_config ac2 ON l2.alarme_id = ac2.id);

SELECT tipo_alarme, COUNT(*) 
FROM alarmes_config
GROUP BY tipo_alarme
HAVING COUNT(*) > (SELECT COUNT(*) / COUNT(DISTINCT tipo_alarme) FROM alarmes_config);

SELECT operador, COUNT(*) 
FROM log_alarmes
WHERE operador IS NOT NULL
GROUP BY operador
HAVING COUNT(*) > (SELECT COUNT(*) / COUNT(DISTINCT operador) FROM log_alarmes WHERE operador IS NOT NULL);

SELECT tag_id, AVG(qualidade_sinal) 
FROM historico_automacao
GROUP BY tag_id
HAVING AVG(qualidade_sinal) > (SELECT AVG(qualidade_sinal) FROM historico_automacao h JOIN tags t ON h.tag_id = t.id WHERE t.tipo_dado = 'Digital');

SELECT tag_id, COUNT(*) 
FROM alarmes_config
GROUP BY tag_id
HAVING COUNT(*) > (SELECT COUNT(*) / COUNT(DISTINCT tag_id) FROM alarmes_config);

SELECT ac.id, ac.tipo_alarme 
FROM alarmes_config ac
GROUP BY ac.id
HAVING (SELECT MAX(valor_analogico) FROM historico_automacao WHERE tag_id = ac.tag_id) < (SELECT MAX(limite_disparo) FROM alarmes_config);

SELECT tag_id, AVG(qualidade_sinal) 
FROM historico_automacao
GROUP BY tag_id
HAVING AVG(qualidade_sinal) < (SELECT AVG(qualidade_sinal) FROM historico_automacao);

SELECT alarme_id, COUNT(*) 
FROM log_alarmes
WHERE data_normalizacao IS NOT NULL
GROUP BY alarme_id
HAVING COUNT(*) > (SELECT COUNT(*) / COUNT(DISTINCT alarme_id) FROM log_alarmes WHERE data_normalizacao IS NOT NULL);
