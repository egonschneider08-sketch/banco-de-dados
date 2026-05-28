DROP DATABASE hp1;

CREATE DATABASE hp1;
USE hp1;

CREATE TABLE Alunos (
    id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    cidade VARCHAR(100),
    idade INT
);

CREATE TABLE Cursos (
    id_curso INT PRIMARY KEY AUTO_INCREMENT,
    nome_curso VARCHAR(100),
    carga_horaria INT
);

CREATE TABLE Matriculas (
    id_matricula INT PRIMARY KEY AUTO_INCREMENT,
    id_aluno INT,
    id_curso INT,
    nota DECIMAL(4,2),
    faltas INT,
FOREIGN KEY (id_aluno)REFERENCES Alunos(id_aluno),
FOREIGN KEY (id_curso)REFERENCES Cursos(id_curso)
);

INSERT INTO Alunos (nome, cidade, idade)VALUES
('Carlos','São Paulo',18),
('Mariana','Curitiba',22),
('João','Florianópolis',19),
('Fernanda','São Paulo',25),
('Lucas','Rio de Janeiro',20),
('Patricia','Curitiba',21),
('Ana','Porto Alegre',23),
('Bruno','São Paulo',24);

INSERT INTO Cursos (nome_curso, carga_horaria)VALUES
('Python',40),
('Banco de Dados',60),
('Java',80),
('Data Science',100);

INSERT INTO Matriculas (id_aluno, id_curso, nota, faltas)VALUES
(1,1,8.5,2),
(1,2,7.0,5),
(2,1,9.5,1),
(2,4,8.0,4),
(3,2,6.5,6),
(3,3,7.5,3),
(4,4,9.0,0),
(5,1,5.5,10),
(5,2,6.0,7),
(6,3,8.5,2),
(7,4,7.0,5),
(8,2,9.5,1);

-- Básicas

SELECT * FROM Alunos;

select nome as Alunos FROM Alunos;

SELECT * FROM Cursos;

SELECT nome, cidade
FROM Alunos
WHERE cidade = 'São Paulo';

SELECT nome, idade
FROM Alunos
WHERE idade>20;

SELECT nome_curso, carga_horaria
FROM Cursos
where carga_horaria > 50;

SELECT nome, idade
FROM Alunos
WHERE idade BETWEEN 18 and 22;

SELECT nome, cidade
FROM Alunos
WHERE cidade = 'Curitiba';

SELECT nome, idade
FROM Alunos
WHERE idade < 21;

SELECT * FROM Matriculas;

--INTERMEDIARIAS

SELECT Alunos.nome, Matriculas.nota
FROM Alunos
JOIN Matriculas
ON Alunos.id_aluno = Matriculas.id_aluno
WHERE nota>8;

SELECT Alunos.nome, Matriculas.faltas
FROM Alunos
JOIN Matriculas
ON Alunos.id_aluno = Matriculas.id_aluno
WHERE Matriculas.faltas > 5;

SELECT nome_curso, carga_horaria
FROM Cursos
WHERE carga_horaria = 80;

SELECT nome, cidade
FROM Alunos
WHERE NOT cidade = 'São Paulo';

SELECT nome
FROM Alunos
WHERE nome LIKE 'A%';

SELECT nome
FROM Alunos
WHERE nome LIKE '%A';

SELECT *
FROM Cursos
WHERE nome_curso LIKE '%Dados%';

SELECT *
FROM Matriculas
WHERE nota BETWEEN 7 AND 9;

SELECT *
FROM Alunos
WHERE idade = 20;

SELECT *
FROM Cursos
WHERE carga_horaria <= 60;

--  GROUP BY

SELECT cidade, COUNT(*) AS quantidade_alunos
FROM Alunos
GROUP BY cidade;

SELECT cidade, AVG(idade) AS media_idade
FROM Alunos
GROUP BY cidade;

SELECT Cursos.nome_curso, COUNT(*) AS quantidade_matriculas
FROM Matriculas
JOIN Cursos
ON Matriculas.id_curso = Cursos.id_curso
GROUP BY Cursos.nome_curso;

SELECT Cursos.nome_curso, AVG(Matriculas.nota) AS media_notas
FROM Matriculas
JOIN Cursos
ON Matriculas.id_curso = Cursos.id_curso
GROUP BY Cursos.nome_curso;

SELECT Cursos.nome_curso, SUM(Matriculas.faltas) AS total_faltas
FROM Matriculas
JOIN Cursos
ON Matriculas.id_curso = Cursos.id_curso
GROUP BY Cursos.nome_curso;

SELECT Cursos.nome_curso, MAX(Matriculas.nota) AS maior_nota
FROM Matriculas
JOIN Cursos
ON Matriculas.id_curso = Cursos.id_curso
GROUP BY Cursos.nome_curso;

SELECT Cursos.nome_curso, MIN(Matriculas.nota) AS menor_nota
FROM Matriculas
JOIN Cursos
ON Matriculas.id_curso = Cursos.id_curso
GROUP BY Cursos.nome_curso;

SELECT Alunos.nome, SUM(Matriculas.faltas) AS total_faltas
FROM Matriculas
JOIN Alunos
ON Matriculas.id_aluno = Alunos.id_aluno
GROUP BY Alunos.nome;

SELECT Alunos.nome, AVG(Matriculas.nota) AS media_notas
FROM Matriculas
JOIN Alunos
ON Matriculas.id_aluno = Alunos.id_aluno
GROUP BY Alunos.nome;

SELECT idade, COUNT(*) AS quantidade_alunos
FROM Alunos
GROUP BY idade;



-- HAVING e ORDER BY



SELECT cidade, COUNT(*) AS quantidade_alunos
FROM Alunos
GROUP BY cidade
HAVING COUNT(*) > 2;



SELECT Cursos.nome_curso, AVG(Matriculas.nota) AS media_notas
FROM Matriculas
JOIN Cursos
ON Matriculas.id_curso = Cursos.id_curso
GROUP BY Cursos.nome_curso
HAVING AVG(Matriculas.nota) > 8;


SELECT Cursos.nome_curso, COUNT(*) AS quantidade_matriculas
FROM Matriculas
JOIN Cursos
ON Matriculas.id_curso = Cursos.id_curso
GROUP BY Cursos.nome_curso
HAVING COUNT(*) > 2;


SELECT Alunos.nome, SUM(Matriculas.faltas) AS total_faltas
FROM Matriculas
JOIN Alunos
ON Matriculas.id_aluno = Alunos.id_aluno
GROUP BY Alunos.nome
HAVING SUM(Matriculas.faltas) > 5;


SELECT Cursos.nome_curso, MIN(Matriculas.nota) AS menor_nota
FROM Matriculas
JOIN Cursos
ON Matriculas.id_curso = Cursos.id_curso
GROUP BY Cursos.nome_curso
HAVING MIN(Matriculas.nota) > 6;

SELECT *
FROM Cursos
ORDER BY carga_horaria DESC;

SELECT *
FROM Alunos
ORDER BY idade DESC;

SELECT Cursos.nome_curso, AVG(Matriculas.nota) AS media_notas
FROM Matriculas
JOIN Cursos
ON Matriculas.id_curso = Cursos.id_curso
GROUP BY Cursos.nome_curso
ORDER BY media_notas DESC;


SELECT cidade, COUNT(*) AS quantidade_alunos
FROM Alunos
GROUP BY cidade
ORDER BY quantidade_alunos DESC;


SELECT Alunos.nome, AVG(Matriculas.nota) AS media_notas
FROM Matriculas
JOIN Alunos
ON Matriculas.id_aluno = Alunos.id_aluno
GROUP BY Alunos.nome
HAVING AVG(Matriculas.nota) > 7
ORDER BY media_notas DESC;

-- Questões — SUBQUERY (Subconsulta)

SELECT * FROM Matriculas 
WHERE nota = ( 
SELECT MAX(nota)
FROM Matriculas
); 

