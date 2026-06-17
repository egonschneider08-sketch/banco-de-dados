CREATE VIEW vw_info_colaboradores AS
SELECT 
    nome, 
    cargo, 
    setor
FROM FUNCIONARIO;

SELECT * FROM vw_info_colaboradores 
WHERE setor = 'Produção';