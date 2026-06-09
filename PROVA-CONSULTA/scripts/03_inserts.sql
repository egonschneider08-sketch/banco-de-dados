-- Active: 1780941987624@@mysql-13746642-egonschneider08-c85e.h.aivencloud.com@10714@industrial_db
--USE industria_db;

-- 1. SETORES
INSERT INTO setores (nome, localizacao) VALUES
('Produção', 'Prédio A'),
('Manutenção', 'Prédio B'),
('Logística', 'Prédio C'),
('Qualidade', 'Prédio D'),
('Recursos Humanos', 'Prédio E');

-- 2. FUNCIONARIOS
INSERT INTO funcionarios (nome, cpf, cargo, salario, data_contratacao, id_setores) VALUES
('João Silva', '12345678901', 'Operador de Máquinas', 2500.00, '2020-01-15', 1),
('Maria Oliveira', '23456789012', 'Técnica de Manutenção', 3000.00, '2019-03-10', 2),
('Carlos Pereira', '34567890123', 'Analista de Logística', 3500.00, '2021-06-20', 3),
('Ana Souza', '45678901234', 'Engenheira de Qualidade', 4000.00, '2018-11-05', 4),
('Pedro Santos', '56789012345', 'Gerente de Recursos Humanos', 5000.00, '2017-08-25', 5),
('Luiza Costa', '67890123456', 'Assistente de Produção', 2200.00, '2022-02-01', 1),
('Rafael Lima', '78901234567', 'Supervisor de Manutenção', 3200.00, '2019-12-15', 2),
('Fernanda Gomes', '89012345678', 'Coordenadora de Logística', 3800.00, '2020-05-30', 3),
('Bruno Almeida', '90123456789', 'Especialista em Controle de Qualidade', 4200.00, '2018-09-10', 4),
('Carla Rodrigues', '01234567890', 'Analista de Recursos Humanos', 4500.00, '2017-04-18', 5);

-- 3. CATEGORIA_PRODUTOS (Corrigido: sem id_produtos)
INSERT INTO categoria_produtos (nome_categoria) VALUES 
('parafusos'),                            -- ID 1
('construção civil'),                     -- ID 2
('hidraulica'),                           -- ID 3
('peças automotivas'),                    -- ID 4
('perfil para fabricação e construção');   -- ID 5

-- 4. PRODUTOS_INDUSTRIAIS (Corrigido: nome da coluna id_categoria e pontuação)
INSERT INTO produtos_industriais (codigo, nome, descricao, preco_fabricacao, quantidade_estoque, id_categoria) VALUES
('P001', 'Parafuso de Aço', 'Parafuso de alta resistência para uso industrial', 0.50, 1000, 1),
('P002', 'Viga de Metal', 'Viga de metal para construção civil', 150.00, 500, 2),
('P003', 'Componente Hidráulico', 'Componente para sistemas hidráulicos industriais', 75.00, 200, 3),
('P004', 'Peça Automotiva', 'Peça de reposição para veículos automotivos', 200.00, 300, 4),
('P005', 'Chapa de Metal', 'Chapa de metal para fabricação de estruturas', 100.00, 400, 5),
('P006', 'Parafuso de Alumínio', 'Parafuso leve para aplicações específicas', 0.30, 800, 1),
('P007', 'Perfil de Metal', 'Perfil de metal para construção e fabricação', 120.00, 600, 5),
('P008', 'Bomba Hidráulica', 'Bomba para sistemas hidráulicos industriais', 500.00, 150, 3),
('P009', 'Freio Automotivo', 'Sistema de freio para veículos automotivos', 300.00, 250, 4),
('P010', 'Cilindro Hidráulico', 'Cilindro para sistemas hidráulicos industriais', 400.00, 100, 3);

-- 5. FORNECEDORES (Corrigido: adicionado id_categoria correspondente)
INSERT INTO fornecedores (nome, cnpj, telefone, cidade, id_categoria) VALUES
('Metalúrgica ABC', '12345678000199', '11987654321', 'São Paulo', 5),
('Parafusos XYZ', '23456789000188', '11976543210', 'Rio de Janeiro', 1),
('Componentes Hidráulicos LTDA', '34567890000177', '11965432109', 'Belo Horizonte', 3),
('Peças Automotivas S/A', '45678901000166', '11954321098', 'Curitiba', 4),
('Chapas de Metal Ltda', '56789012000155', '11943210987', 'Porto Alegre', 5);

-- 6. ORDENS_PRODUCAO (Corrigido: adicionados id_funcionarios e id_produtos válidos)
INSERT INTO ordens_producao (data_criacao, quantidade_produzida, status_producao, tempo_estimado, tempo_real, id_funcionarios, id_produtos) VALUES
('2024-01-10', 500, 'Em Produção', 120, 0, 1, 1),
('2024-01-15', 300, 'Concluída', 90, 85, 6, 6),
('2024-01-20', 200, 'Pendente', 60, 0, 1, 2),
('2024-01-25', 400, 'Em Produção', 150, 0, 6, 3),
('2024-01-30', 600, 'Concluída', 180, 170, 1, 4),
('2024-02-05', 350, 'Pendente', 100, 0, 6, 5),
('2024-02-10', 450, 'Em Produção', 130, 0, 1, 7),
('2024-02-15', 250, 'Concluída', 80, 75, 6, 8),
('2024-02-20', 550, 'Pendente', 160, 0, 1, 9),
('2024-02-25', 700, 'Em Produção', 200, 0, 6, 10);

-- 7. CONTROLE_QUALIDADE (Corrigido: adicionado id_ordens_producao associando de 1 a 10)
INSERT INTO controle_qualidade (data_inspecao, resultado, observacoes, id_ordens_producao) VALUES
('2024-01-12', 'Aprovado', 'Produto dentro dos padrões de qualidade', 1),
('2024-01-17', 'Reprovado', 'Defeito encontrado na peça', 2),
('2024-01-22', 'Aprovado', 'Produto atende aos requisitos especificados', 3),
('2024-01-27', 'Aprovado', 'Produto em conformidade com as normas de qualidade', 4),
('2024-02-02', 'Reprovado', 'Problema identificado durante a inspection', 5),
('2024-02-07', 'Aprovado', 'Produto aprovado sem observações', 6),
('2024-02-12', 'Aprovado', 'Produto atende aos critérios de qualidade estabelecidos', 7),
('2024-02-17', 'Reprovado', 'Defeito crítico encontrado na peça', 8),
('2024-02-22', 'Aprovado', 'Produto em conformidade com os padrões de qualidade', 9),
('2024-02-27', 'Aprovado', 'Produto aprovado após inspeção detalhada', 10);