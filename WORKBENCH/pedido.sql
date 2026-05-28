-- DROP DATABASE pedidos;

CREATE DATABASE pedidos;
USE  pedidos;

CREATE TABLE Pedidos (
idPedido INT AUTO_INCREMENT,
idItem INT,
quantidadeComprada INT,
valorTotal  DECIMAL(9,2),
dataPedido DATE,
PRIMARY KEY(idPedido)
);


INSERT INTO Pedidos
(idItem, quantidadeComprada, valorTotal, dataPedido)
VALUES
(2,12,5.20,'2023-11-10'),
(2,20,5.20,'2023-06-15'),
(1,5,7.50,'2023-08-01');

SELECT * FROM Pedidos;
