-- Active: 1780941987624@@mysql-13746642-egonschneider08-c85e.h.aivencloud.com@10714@industrial_db
USE industrial_db;

-- 1. Liste todos os setores cadastrados na fábrica.
SELECT * FROM setores;

-- 2. Liste o nome, cargo e salário de todos os funcionários.
SELECT nome, cargo, salario FROM funcionarios;

-- 3. Exiba o código, nome e preço de fabricação de todos os produtos cadastrados.
SELECT codigo, nome, preco_fabricacao FROM produtos_industriais;

-- 4. Exiba apenas o nome e a quantidade em estoque dos produtos.
SELECT nome, quantidade_estoque FROM produtos_industriais;

-- 5. Liste os funcionários admitidos após uma determinada data (Exemplo: '2020-01-01').
-- Mude a data '2020-01-01' para a data que o professor pedir.
SELECT * FROM funcionarios WHERE data_contratacao > '2020-01-01';

-- 6. Exiba todos os produtos cuja quantidade em estoque seja superior a 100 unidades.
SELECT * FROM produtos_industriais WHERE quantidade_estoque > 100;

-- 7. Liste todos os fornecedores localizados em uma cidade específica (Exemplo: 'São Paulo').
-- Mude 'São Paulo' para a cidade que o professor pedir.
SELECT * FROM fornecedores WHERE cidade = 'São Paulo';

-- 8. Exiba os produtos cujo preço de fabricação esteja entre R$ 50,00 e R$ 500,00.
SELECT * FROM produtos_industriais WHERE preco_fabricacao BETWEEN 50.00 AND 500.00;

-- 9. Liste os funcionários cujo salário seja superior a R$ 3.000,00.
SELECT * FROM funcionarios WHERE salario > 3000.00;

-- 10. Liste os funcionários cujo cargo contenha a palavra "Operador".
SELECT * FROM funcionarios WHERE cargo LIKE '%Operador%';

-- 11. Exiba todos os fornecedores que possuem telefone cadastrado.
-- (Como a coluna é NOT NULL, filtramos onde não esteja vazia).
SELECT * FROM fornecedores WHERE telefone IS NOT NULL AND telefone <> '';

-- 12. Exiba os produtos cuja descrição contenha uma palavra/trecho informado (Exemplo: 'hidráulicos').
-- Mude 'hidráulicos' para a palavra que o professor pedir.
SELECT * FROM produtos_industriais WHERE descricao LIKE '%hidráulicos%';

-- 13. Exiba todos os produtos ordenados pelo nome em ordem alfabética.
SELECT * FROM produtos_industriais ORDER BY nome ASC;

-- 14. Liste todos os produtos ordenados pelo preço de fabricação em ordem decrescente.
SELECT * FROM produtos_industriais ORDER BY preco_fabricacao DESC;

-- 15. Exiba as ordens de produção com status "Concluída".
SELECT * FROM ordens_producao WHERE status_producao = 'Concluída';

-- 16. Exiba a quantidade total de funcionários cadastrados na empresa.
SELECT COUNT(*) AS total_funcionarios FROM funcionarios;

-- 17. Apresente o salário médio dos funcionários.
SELECT AVG(salario) AS salario_medio FROM funcionarios;

-- 18. Exiba o menor preço de fabricação entre todos os produtos.
SELECT MIN(preco_fabricacao) AS menor_preco FROM produtos_industriais;

-- 19. Apresente a quantidade de produtos cadastrados em cada categoria.
SELECT id_categoria, COUNT(*) AS quantidade_produtos 
FROM produtos_industriais 
GROUP BY id_categoria;

-- 20. Exiba a quantidade de ordens de produção cadastradas por funcionário responsável.
SELECT id_funcionarios, COUNT(*) AS total_ordens 
FROM ordens_producao 
GROUP BY id_funcionarios;

-- 21. Liste o nome dos funcionários e o nome do setor ao qual cada funcionário pertence.
SELECT f.nome AS nome_funcionario, s.nome AS nome_setor
FROM funcionarios f
INNER JOIN setores s ON f.id_setores = s.id_setores;

-- 22. Exiba o nome dos produtos juntamente com o nome de suas respectivas categorias.
SELECT p.nome AS nome_produto, c.nome_categoria
FROM produtos_industriais p
INNER JOIN categoria_produtos c ON p.id_categoria = c.id_categoria;

-- 23. Liste o nome do produto, o nome do fornecedor e o preço de fabricação.
-- (Relacionados através da categoria em comum).
SELECT p.nome AS nome_produto, f.nome AS nome_fornecedor, p.preco_fabricacao
FROM produtos_industriais p
INNER JOIN fornecedores f ON p.id_categoria = f.id_categoria;

-- 24. Exiba o(s) produto(s) que possuem o maior preço de fabricação cadastrado.
SELECT * FROM produtos_industriais 
WHERE preco_fabricacao = (SELECT MAX(preco_fabricacao) FROM produtos_industriais);

-- 25. Liste os funcionários cujo salário seja superior ao salário médio da empresa.
SELECT * FROM funcionarios 
WHERE salario > (SELECT AVG(salario) FROM funcionarios);