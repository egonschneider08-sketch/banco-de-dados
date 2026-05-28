DROP DATABASE estoqueitem;

create database estoqueitem;
use estoqueitem;

CREATE TABLE ItensEstoque(
idItem INT NOT NULL AUTO_INCREMENT,
descricaoItem VARCHAR(200),
setorItem VARCHAR(200),
precoVendaItem DOUBLE(9,2),
estoqueItem INT,
PRIMARY KEY (idItem)
);

INSERT INTO ItensEstoque
(descricaoItem,setorItem,precoVendaItem,estoqueItem)VALUES
('Suco de Laranja','Bebidas','7.50',250),
('Macarrão 1kg','Alimentos','5.20',180),
('Sabão em pó','Limpeza','12.90',90),
('Café Torrado','Alimentos','15.80',120),
('Iogurte Natural','Laticínios','4.30',350),
('Biscoito Integral',NULL,'3.90',210),
('Molho de Tomate','Alimentos','2.80',500);





SELECT*FROM ItensEstoque
WHERE precoVendaItem = (
SELECT MAX(precoVendaItem)
FROM ItensEstoque
);

SELECT*FROM ItensEstoque
WHERE precoVendaItem > (select precovendaitem
from itensestoque
where precovendaitem = 7.50
);
select precoVendaItem
from ItensEstoque
where precovendaitem= 7.50;



SELECT*FROM ItensEstoque
WHERE precoVendaItem<> (
SELECT MAX(precoVendaItem)
FROM ItensEstoque
);