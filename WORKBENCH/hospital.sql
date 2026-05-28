-- Active: 1779904718701@@mysql-13746642-egonschneider08-c85e.h.aivencloud.com@10714@mysql
-- Active: 1779904718701@@mysql-13746642-egonschneider08-c85e.h.aivencloud.com@10714@defaultdb
CREATE DATABASE IF NOT EXISTS HospitalDB;
USE HospitalDB;

-- Tabela Hospitais
CREATE TABLE Hospitais (
    id_hospital INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(100),
    estado CHAR(2),
    endereco VARCHAR(200)
);

-- Tabela Especialidades
CREATE TABLE Especialidades (
    id_especialidade INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE
);

-- Tabela Medicos
CREATE TABLE Medicos (
    id_medico INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    crm VARCHAR(20) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    salario DECIMAL(10,2),
    id_especialidade INT NOT NULL,
    id_hospital INT NOT NULL,
    FOREIGN KEY (id_especialidade) REFERENCES Especialidades(id_especialidade),
    FOREIGN KEY (id_hospital) REFERENCES Hospitais(id_hospital)
);

-- Tabela Pacientes
CREATE TABLE Pacientes (
    id_paciente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE,
    data_nascimento DATE,
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco VARCHAR(200),
    tipo_sanguineo VARCHAR(5),
    alergias TEXT
);

-- Tabela Convenios
CREATE TABLE Convenios (
    id_convenio INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    cobertura TEXT
);

-- Tabela Paciente Convenio
CREATE TABLE PacienteConvenio (
    id_paciente_convenio INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    id_convenio INT NOT NULL,
    numero_carteira VARCHAR(50),
    FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente),
    FOREIGN KEY (id_convenio) REFERENCES Convenios(id_convenio)
);

-- Tabela Consultas
CREATE TABLE Consultas (
    id_consulta INT PRIMARY KEY AUTO_INCREMENT,
    data_consulta DATETIME NOT NULL,
    diagnostico TEXT,
    observacoes TEXT,
    valor DECIMAL(10,2),
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES Medicos(id_medico)
);

-- Tabela Medicamentos
CREATE TABLE Medicamentos (
    id_medicamento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    fabricante VARCHAR(100),
    estoque INT,
    preco DECIMAL(10,2)
);

-- Tabela Receitas
CREATE TABLE Receitas (
    id_receita INT PRIMARY KEY AUTO_INCREMENT,
    id_consulta INT NOT NULL,
    data_receita DATE,
    observacoes TEXT,
    FOREIGN KEY (id_consulta) REFERENCES Consultas(id_consulta)
);

-- Tabela Receita Medicamento
CREATE TABLE ReceitaMedicamento (
    id_receita_medicamento INT PRIMARY KEY AUTO_INCREMENT,
    id_receita INT NOT NULL,
    id_medicamento INT NOT NULL,
    dosagem VARCHAR(100),
    frequencia VARCHAR(100),
    FOREIGN KEY (id_receita) REFERENCES Receitas(id_receita),
    FOREIGN KEY (id_medicamento) REFERENCES Medicamentos(id_medicamento)
);

-- Tabela Exames
CREATE TABLE Exames (
    id_exame INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    resultado TEXT,
    data_exame DATE,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES Medicos(id_medico)
);

-- Tabela Quartos
CREATE TABLE Quartos (
    id_quarto INT PRIMARY KEY AUTO_INCREMENT,
    numero VARCHAR(10),
    tipo VARCHAR(50),
    capacidade INT,
    status_quarto VARCHAR(50),
    id_hospital INT NOT NULL,
    FOREIGN KEY (id_hospital) REFERENCES Hospitais(id_hospital)
);

-- Tabela Internacoes
CREATE TABLE Internacoes (
    id_internacao INT PRIMARY KEY AUTO_INCREMENT,
    data_entrada DATETIME,
    data_saida DATETIME,
    motivo TEXT,
    id_paciente INT NOT NULL,
    id_quarto INT NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente),
    FOREIGN KEY (id_quarto) REFERENCES Quartos(id_quarto)
);

-- Tabela Setores
CREATE TABLE Setores (
    id_setor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL
);

-- Tabela Funcionarios
CREATE TABLE Funcionarios (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    cpf CHAR(11),
    cargo VARCHAR(100),
    salario DECIMAL(10,2),
    id_setor INT NOT NULL,
    id_hospital INT NOT NULL,
    FOREIGN KEY (id_setor) REFERENCES Setores(id_setor),
    FOREIGN KEY (id_hospital) REFERENCES Hospitais(id_hospital)
);

-- Tabela Pagamentos
CREATE TABLE Pagamentos (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    valor DECIMAL(10,2),
    data_pagamento DATE,
    forma_pagamento VARCHAR(50),
    id_consulta INT,
    FOREIGN KEY (id_consulta) REFERENCES Consultas(id_consulta)
);

-- Tabela UsuariosSistema
CREATE TABLE UsuariosSistema (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    usuario VARCHAR(50) UNIQUE,
    senha_hash VARCHAR(255),
    nivel_acesso VARCHAR(50)
);

-- Tabela Logs
CREATE TABLE Logs (
    id_log INT PRIMARY KEY AUTO_INCREMENT,
    acao TEXT,
    data_log DATETIME,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES UsuariosSistema(id_usuario)
);

-- =========================================================
-- POPULAÇÃO DO BANCO HospitalDB
-- =========================================================

USE HospitalDB;

-- =========================================================
-- HOSPITAIS
-- =========================================================

INSERT INTO Hospitais
(nome, cidade, estado, endereco)
VALUES
('Hospital São Lucas', 'Joinville', 'SC', 'Rua das Flores, 120'),
('Hospital Vida Nova', 'Curitiba', 'PR', 'Av. Central, 450'),
('Hospital Santa Clara', 'Florianópolis', 'SC', 'Rua Beira Mar, 900'),
('Hospital Esperança', 'Blumenau', 'SC', 'Rua XV de Novembro, 88'),
('Hospital Saúde Total', 'Porto Alegre', 'RS', 'Av. Brasil, 300');

-- =========================================================
-- ESPECIALIDADES
-- =========================================================

INSERT INTO Especialidades
(nome)
VALUES
('Cardiologia'),
('Ortopedia'),
('Pediatria'),
('Neurologia'),
('Clínico Geral');

-- =========================================================
-- MÉDICOS
-- =========================================================

INSERT INTO Medicos
(nome, crm, telefone, email, salario,
 id_especialidade, id_hospital)
VALUES
('Carlos Mendes', 'CRM1001', '47999990001',
 'carlos@hospital.com', 18000.00, 1, 1),

('Fernanda Lima', 'CRM1002', '47999990002',
 'fernanda@hospital.com', 22000.00, 2, 1),

('Ricardo Alves', 'CRM1003', '41999990003',
 'ricardo@hospital.com', 19500.00, 3, 2),

('Patricia Souza', 'CRM1004', '48999990004',
 'patricia@hospital.com', 25000.00, 4, 3),

('Juliana Costa', 'CRM1005', '47999990005',
 'juliana@hospital.com', 17000.00, 5, 4);

-- =========================================================
-- PACIENTES
-- =========================================================

INSERT INTO Pacientes
(nome, cpf, data_nascimento,
 telefone, email, endereco,
 tipo_sanguineo, alergias)
VALUES
('João Pedro', '11111111111',
 '2000-05-10', '47988880001',
 'joao@email.com',
 'Rua Azul, 100',
 'O+', 'Dipirona'),

('Mariana Silva', '22222222222',
 '1995-08-15', '47988880002',
 'mariana@email.com',
 'Rua Verde, 220',
 'A+', 'Nenhuma'),

('Lucas Almeida', '33333333333',
 '1988-12-01', '47988880003',
 'lucas@email.com',
 'Rua Vermelha, 50',
 'B-', 'Amendoim'),

('Ana Costa', '44444444444',
 '2002-03-20', '47988880004',
 'ana@email.com',
 'Rua das Palmeiras, 77',
 'AB+', 'Penicilina'),

('Bruno Rocha', '55555555555',
 '1990-11-11', '47988880005',
 'bruno@email.com',
 'Av. Central, 500',
 'O-', 'Nenhuma');

-- =========================================================
-- CONVÊNIOS
-- =========================================================

INSERT INTO Convenios
(nome, telefone, cobertura)
VALUES
('Unimed', '0800111111',
 'Consultas e exames'),

('Bradesco Saúde', '0800222222',
 'Internações e cirurgias'),

('SulAmérica', '0800333333',
 'Cobertura nacional'),

('Amil', '0800444444',
 'Consultas, exames e internações'),

('Particular', '0800555555',
 'Sem cobertura');

-- =========================================================
-- PACIENTE CONVÊNIO
-- =========================================================

INSERT INTO PacienteConvenio
(id_paciente, id_convenio, numero_carteira)
VALUES
(1,1,'UNI123456'),
(2,2,'BRA987654'),
(3,3,'SUL456789'),
(4,4,'AMI654321'),
(5,5,'PAR111222');

-- =========================================================
-- CONSULTAS
-- =========================================================

INSERT INTO Consultas
(data_consulta, diagnostico,
 observacoes, valor,
 id_paciente, id_medico)
VALUES
('2025-08-01 10:00:00',
 'Hipertensão',
 'Paciente apresentou pressão elevada',
 250.00, 1, 1),

('2025-08-02 14:00:00',
 'Fratura no braço',
 'Necessário imobilização',
 450.00, 2, 2),

('2025-08-03 09:30:00',
 'Gripe',
 'Repouso recomendado',
 180.00, 3, 3),

('2025-08-04 16:00:00',
 'Enxaqueca',
 'Solicitado exame complementar',
 320.00, 4, 4),

('2025-08-05 11:15:00',
 'Check-up',
 'Paciente saudável',
 200.00, 5, 5);

-- =========================================================
-- MEDICAMENTOS
-- =========================================================

INSERT INTO Medicamentos
(nome, fabricante, estoque, preco)
VALUES
('Dipirona', 'EMS', 150, 12.50),
('Amoxicilina', 'Medley', 80, 35.90),
('Paracetamol', 'Neo Química', 200, 8.90),
('Ibuprofeno', 'Cimed', 120, 15.40),
('Omeprazol', 'Eurofarma', 90, 22.00);

-- =========================================================
-- RECEITAS
-- =========================================================

INSERT INTO Receitas
(id_consulta, data_receita, observacoes)
VALUES
(1, '2025-08-01', 'Tomar após refeições'),
(2, '2025-08-02', 'Uso por 7 dias'),
(3, '2025-08-03', 'Uso contínuo'),
(4, '2025-08-04', 'Evitar esforço físico'),
(5, '2025-08-05', 'Apenas se necessário');

-- =========================================================
-- RECEITA MEDICAMENTO
-- =========================================================

INSERT INTO ReceitaMedicamento
(id_receita, id_medicamento,
 dosagem, frequencia)
VALUES
(1,1,'500mg','8 em 8 horas'),
(2,2,'1 cápsula','12 em 12 horas'),
(3,3,'750mg','6 em 6 horas'),
(4,4,'400mg','8 em 8 horas'),
(5,5,'20mg','1 vez ao dia');

-- =========================================================
-- EXAMES
-- =========================================================

INSERT INTO Exames
(nome, resultado, data_exame,
 id_paciente, id_medico)
VALUES
('Hemograma',
 'Sem alterações',
 '2025-08-01', 1, 1),

('Raio-X',
 'Fratura confirmada',
 '2025-08-02', 2, 2),

('Teste Covid',
 'Negativo',
 '2025-08-03', 3, 3),

('Ressonância',
 'Sem anomalias',
 '2025-08-04', 4, 4),

('Check-up sanguíneo',
 'Normal',
 '2025-08-05', 5, 5);

-- =========================================================
-- QUARTOS
-- =========================================================

INSERT INTO Quartos
(numero, tipo, capacidade,
 status_quarto, id_hospital)
VALUES
('101', 'UTI', 1, 'Ocupado', 1),
('102', 'Enfermaria', 2, 'Livre', 1),
('201', 'Apartamento', 1, 'Livre', 2),
('202', 'UTI', 1, 'Manutenção', 3),
('301', 'Enfermaria', 3, 'Ocupado', 4);

-- =========================================================
-- INTERNAÇÕES
-- =========================================================

INSERT INTO Internacoes
(data_entrada, data_saida,
 motivo, id_paciente, id_quarto)
VALUES
('2025-08-01 08:00:00',
 '2025-08-05 10:00:00',
 'Cirurgia cardíaca', 1, 1),

('2025-08-02 09:00:00',
 '2025-08-06 14:00:00',
 'Fratura grave', 2, 2),

('2025-08-03 10:00:00',
 NULL,
 'Observação clínica', 3, 3),

('2025-08-04 12:00:00',
 '2025-08-07 09:00:00',
 'Crise de enxaqueca', 4, 4),

('2025-08-05 07:00:00',
 NULL,
 'Exames complementares', 5, 5);

-- =========================================================
-- SETORES
-- =========================================================

INSERT INTO Setores
(nome)
VALUES
('Recepção'),
('TI'),
('Financeiro'),
('Enfermagem'),
('Administração');

-- =========================================================
-- FUNCIONÁRIOS
-- =========================================================

INSERT INTO Funcionarios
(nome, cpf, cargo,
 salario, id_setor, id_hospital)
VALUES
('Roberto Silva', '66666666666',
 'Recepcionista', 3200.00, 1, 1),

('Camila Souza', '77777777777',
 'Analista de TI', 5500.00, 2, 1),

('Paulo Mendes', '88888888888',
 'Auxiliar Financeiro', 4200.00, 3, 2),

('Juliana Alves', '99999999999',
 'Enfermeira', 6200.00, 4, 3),

('Felipe Rocha', '10101010101',
 'Administrador', 7500.00, 5, 4);

-- =========================================================
-- PAGAMENTOS
-- =========================================================

INSERT INTO Pagamentos
(valor, data_pagamento,
 forma_pagamento, id_consulta)
VALUES
(250.00, '2025-08-01', 'Cartão', 1),
(450.00, '2025-08-02', 'PIX', 2),
(180.00, '2025-08-03', 'Dinheiro', 3),
(320.00, '2025-08-04', 'Cartão', 4),
(200.00, '2025-08-05', 'PIX', 5);

-- =========================================================
-- USUÁRIOS DO SISTEMA
-- =========================================================

INSERT INTO UsuariosSistema
(usuario, senha_hash, nivel_acesso)
VALUES
('admin',
'123hashadmin',
'Administrador'),

('medico01',
'123hashmedico',
'Médico'),

('recepcao01',
'123hashrecepcao',
'Recepção'),

('financeiro01',
'123hashfinanceiro',
'Financeiro'),

('ti01',
'123hashti',
'TI');

-- =========================================================
-- LOGS
-- =========================================================

INSERT INTO Logs
(acao, data_log, id_usuario)
VALUES
('Login no sistema',
 '2025-08-01 08:00:00', 1),

('Cadastro de paciente',
 '2025-08-01 08:10:00', 3),

('Atualização de consulta',
 '2025-08-02 14:30:00', 2),

('Registro de pagamento',
 '2025-08-03 16:00:00', 4),

('Backup do banco executado',
 '2025-08-04 23:00:00', 5);





-- DROP DATABASE HospitalDB;





 select * from Pacientes;




  select * from Consultas;




   select * from Pacientes
   where tipo_sanguineo = 'B-';




SELECT Medicos.nome, Medicos.crm, Especialidades.nome
FROM Medicos, Especialidades
WHERE Medicos.id_especialidade = Especialidades.id_especialidade;




SELECT Medicos.nome,
       Medicos.crm,
       Especialidades.nome,
       Hospitais.nome,
       COUNT(Consultas.id_consulta)
FROM Medicos, Especialidades, Hospitais, Consultas
WHERE Medicos.id_especialidade = Especialidades.id_especialidade
AND Hospitais.id_hospital = Medicos.id_hospital
AND Consultas.id_medico = Medicos.id_medico
AND Medicos.id_hospital = 2
GROUP BY Medicos.nome, Medicos.crm, Especialidades.nome, Hospitais.nome;





select M.nome, M.salario, E.nome, M.crm
from Medicos as M 
join Especialidades as E 
on M.id_especialidade=
    E.id_especialidade;
    group by M.nome, E.nome, M.crm





SELECT M.nome, M.salario, E.nome, M.crm
FROM Medicos AS M 
JOIN Especialidades AS E ON M.id_especialidade = E.id_especialidade
WHERE E.nome LIKE 'Cardiologia';





SELECT M.nome,P.nome,C.data_consulta
FROM Medicos AS M, Pacientes AS P, Consultas AS C
WHERE C.id_medico = M.id_medico
AND C.id_paciente = P.id_paciente;






SELECT M.nome, M.email, E.nome, COUNT(C.id_consulta), M.salario
FROM Medicos AS M 
JOIN Especialidades AS E 
ON M.id_especialidade = E.id_especialidade
JOIN Consultas AS C 
ON M.id_medico = C.id_medico
GROUP BY M.id_medico;





SELECT M.nome, M.email, M.telefone, E.nome as especialidade, H.nome as Hospital, COUNT(Exames.id_exame) as Exames_solicitados
FROM Medicos as M
JOIN Especialidades AS E ON M.id_especialidade = E.id_especialidade
JOIN Hospitais AS H ON M.id_hospital = H.id_hospital
JOIN Exames ON M.id_medico = Exames.id_medico
GROUP BY M.id_medico;






SELECT M.nome, 
       M.email, 
       M.telefone, 
       E.nome as especialidade, 
       H.nome as Hospital, 
       COUNT(Exames.id_exame) as Exames_solicitados
FROM Medicos as M
JOIN Especialidades AS E ON M.id_especialidade = E.id_especialidade
JOIN Hospitais AS H ON M.id_hospital = H.id_hospital
JOIN Exames ON M.id_medico = Exames.id_medico
GROUP BY M.id_medico, M.nome, M.email, M.telefone, E.nome, H.nome;








USE HospitalDB;
