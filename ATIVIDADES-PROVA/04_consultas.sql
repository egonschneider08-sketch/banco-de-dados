-- Active: 1780941987624@@mysql-13746642-egonschneider08-c85e.h.aivencloud.com@10714@automacao

USE automacao;

SELECT tag_id, valor_analogico FROM historico_automacao
WHERE valor_analogico = (SELECT MAX(valor_analogico) FROM historico_automacao);

-- Q2: Exiba os registros de histórico que possuem valor analógico menor que a média geral.
SELECT * FROM historico_automacao
WHERE valor_analogico < (SELECT AVG(valor_analogico) FROM historico_automacao);

-- Q3: Mostre as configurações de alarme que possuem o maior limite de disparo.
SELECT * FROM alarmes_config
WHERE limite_disparo = (SELECT MAX(limite_disparo) FROM alarmes_config);

-- Q4: Liste as tags que possuem qualidade de sinal igual à maior qualidade registrada.
SELECT DISTINCT tag_id FROM historico_automacao
WHERE qualidade_sinal = (SELECT MAX(qualidade_sinal) FROM historico_automacao);

-- Q5: Exiba as leituras analógicas que possuem valor menor que a média das leituras da tag ID 2.
SELECT * FROM historico_automacao
WHERE valor_analogico < (SELECT AVG(valor_analogico) FROM historico_automacao WHERE tag_id = 2);

-- Q6: Mostre os alarmes cujo limite de disparo seja maior que a média de todos os limites.
SELECT * FROM alarmes_config
WHERE limite_disparo > (SELECT AVG(limite_disparo) FROM alarmes_config);

-- Q7: Liste as leituras que possuem exatamente o menor valor analógico cadastrado.
SELECT * FROM historico_automacao
WHERE valor_analogico = (SELECT MIN(valor_analogico) FROM historico_automacao);

-- Q8: Exiba os históricos analógicos cujo valor seja maior que a média das leituras da tag ID 4.
SELECT * FROM historico_automacao
WHERE valor_analogico > (SELECT AVG(valor_analogico) FROM historico_automacao WHERE tag_id = 4);

-- Q9: Mostre os alarmes que possuem limite de disparo diferente do maior limite cadastrado.
SELECT * FROM alarmes_config
WHERE limite_disparo <> (SELECT MAX(limite_disparo) FROM alarmes_config);

-- Q10: Liste as leituras que possuem sinal igual à menor qualidade de sinal registrada.
SELECT * FROM historico_automacao
WHERE qualidade_sinal = (SELECT MIN(qualidade_sinal) FROM historico_automacao);


-- --------------------------------------------------------------------
-- Bloco 2 — Subquery com IN / NOT IN
-- --------------------------------------------------------------------

-- Q11: Liste os nomes das tags que possuem algum histórico gravado.
SELECT tag_nome FROM tags
WHERE id IN (SELECT DISTINCT tag_id FROM historico_automacao);

-- Q12: Exiba as tags que possuem alarmes configurados.
SELECT tag_nome FROM tags
WHERE id IN (SELECT DISTINCT tag_id FROM alarmes_config);

-- Q13: Mostre o histórico das leituras que pertencem à tag 'CLP_01_TANQUE_NIVEL'.
SELECT * FROM historico_automacao
WHERE tag_id IN (SELECT id FROM tags WHERE tag_nome = 'CLP_01_TANQUE_NIVEL');

-- Q14: Liste as tags analógicas que possuem limites de disparo maiores que 50.
SELECT tag_nome FROM tags
WHERE id IN (SELECT tag_id FROM alarmes_config WHERE limite_disparo > 50.0);

-- Q15: Exiba as tags que geraram alarmes com prioridade 'Critico'.
SELECT tag_nome FROM tags
WHERE id IN (SELECT tag_id FROM alarmes_config WHERE prioridade = 'Critico');

-- Q16: Mostre as tags que possuem mais de 3 registros no histórico.
SELECT tag_nome FROM tags
WHERE id IN (SELECT tag_id FROM historico_automacao GROUP BY tag_id HAVING COUNT(*) > 3);

-- Q17: Liste as tags que NÃO possuem nenhum alarme configurado.
SELECT tag_nome FROM tags
WHERE id NOT IN (SELECT DISTINCT tag_id FROM alarmes_config);

-- Q18: Exiba as tags que possuem falha de sinal (qualidade menor que 192) em algum momento.
SELECT tag_nome FROM tags
WHERE id IN (SELECT tag_id FROM historico_automacao WHERE qualidade_sinal < 192);

-- Q19: Mostre as tags associadas a alarmes que já foram reconhecidos por algum operador.
SELECT tag_nome FROM tags
WHERE id IN (SELECT tag_id FROM alarmes_config WHERE id IN (SELECT alarme_id FROM log_alarmes WHERE operador IS NOT NULL));

-- Q20: Liste os registros de telemetria pertencentes à tag com o maior limite de disparo configurado.
SELECT * FROM historico_automacao
WHERE tag_id IN (SELECT tag_id FROM alarmes_config WHERE limite_disparo = (SELECT MAX(limite_disparo) FROM alarmes_config));


-- --------------------------------------------------------------------
-- Bloco 3 — Subquery com Operadores de Comparação
-- --------------------------------------------------------------------

-- Q21: Exiba as leituras cujo valor analógico seja maior que a média de valor analógico da Tag ID 2.
SELECT * FROM historico_automacao
WHERE valor_analogico > (SELECT AVG(valor_analogico) FROM historico_automacao WHERE tag_id = 2);

-- Q22: Liste as tags cuja média de qualidade de sinal seja maior que a média geral de qualidade.
SELECT id, tag_nome FROM tags
WHERE (SELECT AVG(qualidade_sinal) FROM historico_automacao WHERE tag_id = tags.id) > (SELECT AVG(qualidade_sinal) FROM historico_automacao);

-- Q23: Mostre os alarmes cujo limite de disparo seja maior que a média total de todos os limites.
SELECT * FROM alarmes_config
WHERE limite_disparo > (SELECT AVG(limite_disparo) FROM alarmes_config);

-- Q24: Exiba os alarmes cujo limite seja igual ao maior limite do sistema.
SELECT * FROM alarmes_config
WHERE limite_disparo = (SELECT MAX(limite_disparo) FROM alarmes_config);

-- Q25: Liste os alarmes que possuem limite menor que a média geral de limites de alarmes 'Críticos'.
SELECT * FROM alarmes_config
WHERE limite_disparo < (SELECT AVG(limite_disparo) FROM alarmes_config WHERE prioridade = 'Critico');

-- Q26: Mostre as tags cuja quantidade de alarmes disparados no log seja maior que a média de disparos por alarme.
SELECT ac.tag_id FROM alarmes_config ac
GROUP BY ac.tag_id
HAVING COUNT(ac.id) > (SELECT COUNT(*) / COUNT(DISTINCT alarme_id) FROM log_alarmes);

-- Q27: Exiba as leituras analógicas que possuem valor maior que todas as leituras da tag ID 3.
SELECT * FROM historico_automacao
WHERE valor_analogico > ALL (SELECT valor_analogico FROM historico_automacao WHERE tag_id = 3 AND valor_analogico IS NOT NULL);

-- Q28: Liste as tags cujo menor sinal registrado seja maior que a média das piores qualidades de sinal.
SELECT tag_id FROM historico_automacao
GROUP BY tag_id
HAVING MIN(qualidade_sinal) > (SELECT AVG(sub.menor) FROM (SELECT MIN(qualidade_sinal) as menor FROM historico_automacao GROUP BY tag_id) sub);

-- Q29: Mostre os registros de telemetria cujo valor analógico seja exatamente igual à média aritmética de todos os valores analógicos.
SELECT * FROM historico_automacao
WHERE valor_analogico = (SELECT AVG(valor_analogico) FROM historico_automacao);

-- Q30: Exiba as configurações de alarme cujo limite seja menor que o maior limite cadastrado.
SELECT * FROM alarmes_config
WHERE limite_disparo < (SELECT MAX(limite_disparo) FROM alarmes_config);


-- --------------------------------------------------------------------
-- Bloco 4 — Subquery como Nova Coluna (SELECT Expression)
-- --------------------------------------------------------------------

-- Q31: Liste as tags e exiba ao lado a quantidade total de registros no histórico de cada uma.
SELECT t.tag_nome, 
       (SELECT COUNT(*) FROM historico_automacao h WHERE h.tag_id = t.id) AS Total_Leituras
FROM tags t;

-- Q32: Exiba os alarmes e mostre ao lado o valor médio analógico coletado para aquela tag.
SELECT ac.*, 
       (SELECT AVG(valor_analogico) FROM historico_automacao h WHERE h.tag_id = ac.tag_id) AS Media_Analogica
FROM alarmes_config ac;

-- Q33: Liste as tags e mostre a quantidade de alarmes ativos/não normalizados (data_normalizacao IS NULL).
SELECT t.tag_nome,
       (SELECT COUNT(*) FROM log_alarmes l JOIN alarmes_config ac ON l.alarme_id = ac.id WHERE ac.tag_id = t.id AND l.data_normalizacao IS NULL) AS Alarmes_Ativos
FROM tags t;

-- Q34: Exiba as tags e mostre quantos alarmes diferentes estão configurados para cada uma.
SELECT t.tag_nome,
       (SELECT COUNT(*) FROM alarmes_config ac WHERE ac.tag_id = t.id) AS Qtd_Alarmes_Configurados
FROM tags t;

-- Q35: Liste as tags e apresente seu maior valor analógico registrado.
SELECT t.tag_nome,
       (SELECT MAX(valor_analogico) FROM historico_automacao h WHERE h.tag_id = t.id) AS Maior_Valor
FROM tags t;

-- Q36: Exiba as prioridades de alarme e mostre a quantidade de logs gerados para cada uma.
SELECT DISTINCT ac.prioridade,
       (SELECT COUNT(*) FROM log_alarmes l JOIN alarmes_config ac2 ON l.alarme_id = ac2.id WHERE ac2.prioridade = ac.prioridade) AS Total_Ocorrencias
FROM alarmes_config ac;

-- Q37: Liste as tags e mostre a média de qualidade de sinal em uma coluna chamada Media_Sinal_Tag.
SELECT t.tag_nome,
       (SELECT AVG(qualidade_sinal) FROM historico_automacao h WHERE h.tag_id = t.id) AS Media_Sinal_Tag
FROM tags t;

-- Q38: Exiba os alarmes e apresente o total de vezes que cada um disparou.
SELECT ac.id, ac.tipo_alarme,
       (SELECT COUNT(*) FROM log_alarmes l WHERE l.alarme_id = ac.id) AS Total_Disparos
FROM alarmes_config ac;

-- Q39: Liste as tags e mostre a quantidade de operadores diferentes que reconheceram seus alarmes.
SELECT t.tag_nome,
       (SELECT COUNT(DISTINCT l.operador) FROM log_alarmes l JOIN alarmes_config ac ON l.alarme_id = ac.id WHERE ac.tag_id = t.id AND l.operador IS NOT NULL) AS Operadores_Distintos
FROM tags t;

-- Q40: Exiba os alarmes e mostre a quantidade de ocorrências que já foram totalmente normalizadas (data_normalizacao IS NOT NULL).
SELECT ac.id, ac.tipo_alarme,
       (SELECT COUNT(*) FROM log_alarmes l WHERE l.alarme_id = ac.id AND l.data_normalizacao IS NOT NULL) AS Ocorrencias_Normalizadas
FROM alarmes_config ac;


-- --------------------------------------------------------------------
-- Bloco 5 — Desafios (GROUP BY + HAVING + SUBQUERY)
-- --------------------------------------------------------------------

-- Q41: Liste as tags cuja média de valor analógico seja maior que a média geral de todas as leituras analógicas do sistema.
SELECT tag_id, AVG(valor_analogico) AS Media_Tag 
FROM historico_automacao
WHERE valor_analogico IS NOT NULL
GROUP BY tag_id
HAVING AVG(valor_analogico) > (SELECT AVG(valor_analogico) FROM historico_automacao);

-- Q42: Exiba as prioridades de alarme cuja média de limite de disparo seja maior que a média geral de todos os limites.
SELECT prioridade, AVG(limite_disparo) 
FROM alarmes_config
GROUP BY prioridade
HAVING AVG(limite_disparo) > (SELECT AVG(limite_disparo) FROM alarmes_config);

-- Q43: Mostre as tags cuja quantidade de logs de alarme seja maior que a média de ocorrências por tag.
SELECT ac.tag_id, COUNT(l.id) 
FROM log_alarmes l
JOIN alarmes_config ac ON l.alarme_id = ac.id
GROUP BY ac.tag_id
HAVING COUNT(l.id) > (SELECT COUNT(*) / COUNT(DISTINCT tag_id) FROM log_alarmes l2 JOIN alarmes_config ac2 ON l2.alarme_id = ac2.id);

-- Q44: Liste os tipos de alarmes que possuem quantidade de configurações acima da média de configurações por tipo.
SELECT tipo_alarme, COUNT(*) 
FROM alarmes_config
GROUP BY tipo_alarme
HAVING COUNT(*) > (SELECT COUNT(*) / COUNT(DISTINCT tipo_alarme) FROM alarmes_config);

-- Q45: Exiba os operadores cuja quantidade de reconhecimentos de alarmes efetuados seja maior que a média de reconhecimentos dos operadores do sistema.
SELECT operador, COUNT(*) 
FROM log_alarmes
WHERE operador IS NOT NULL
GROUP BY operador
HAVING COUNT(*) > (SELECT COUNT(*) / COUNT(DISTINCT operador) FROM log_alarmes WHERE operador IS NOT NULL);

-- Q46: Mostre as tags cuja média de qualidade de sinal seja superior à média de qualidade apenas das tags digitais.
SELECT tag_id, AVG(qualidade_sinal) 
FROM historico_automacao
GROUP BY tag_id
HAVING AVG(qualidade_sinal) > (SELECT AVG(qualidade_sinal) FROM historico_automacao h JOIN tags t ON h.tag_id = t.id WHERE t.tipo_dado = 'Digital');

-- Q47: Liste as tags que possuem mais alarmes configurados que a média de alarmes por tag.
SELECT tag_id, COUNT(*) 
FROM alarmes_config
GROUP BY tag_id
HAVING COUNT(*) > (SELECT COUNT(*) / COUNT(DISTINCT tag_id) FROM alarmes_config);

-- Q48: Exiba as configurações de alarme cuja maior leitura analógica registrada seja inferior ao maior limite geral do sistema.
SELECT ac.id, ac.tipo_alarme 
FROM alarmes_config ac
GROUP BY ac.id
HAVING (SELECT MAX(valor_analogico) FROM historico_automacao WHERE tag_id = ac.tag_id) < (SELECT MAX(limite_disparo) FROM alarmes_config);

-- Q49: Mostre as tags cuja média de qualidade de sinal seja menor que a média geral de qualidade.
SELECT tag_id, AVG(qualidade_sinal) 
FROM historico_automacao
GROUP BY tag_id
HAVING AVG(qualidade_sinal) < (SELECT AVG(qualidade_sinal) FROM historico_automacao);

-- Q50: Liste os alarmes cuja quantidade de ocorrências normalizadas seja maior que a média de normalizações de todos os alarmes.
SELECT alarme_id, COUNT(*) 
FROM log_alarmes
WHERE data_normalizacao IS NOT NULL
GROUP BY alarme_id
HAVING COUNT(*) > (SELECT COUNT(*) / COUNT(DISTINCT alarme_id) FROM log_alarmes WHERE data_normalizacao IS NOT NULL);