/*
Задание 6
Используя базу данных ShopDB и страницу Customers 
(удалите таблицу, если есть и создайте заново первый раз без первичного ключа затем – с первичным) 
и затем добавьте индексы и проанализируйте выборку данных.
*/

DROP TABLE ShopDB.Customers;
CREATE TABLE ShopDB.Customers     -- таблица КУЧА
(                                      
	CustumerNo int NOT NULL, 
	CustumerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	Address2 varchar(25) NOT NULL,
	City      varchar(15) NOT NULL,
	State char(2) NOT NULL,
	Zip varchar(10) NOT NULL,
	Contact varchar(25) NOT NULL,
	Phone char(12),
	FedIDNo  varchar(10) NOT NULL,
	DateInSystem date NOT NULL 
);
DROP TABLE ShopDB.Customers;

CREATE TABLE ShopDB.Customers     
(                                      
	CustumerNo int NOT NULL PRIMARY KEY,    -- кластеризированный идекс PRIMARY KEY
	CustumerName varchar(25) NOT NULL,
	Address1 varchar(25) NOT NULL,
	Address2 varchar(25) NOT NULL,
	City      varchar(15) NOT NULL,
	State char(2) NOT NULL,
	Zip varchar(10) NOT NULL,
	Contact varchar(25) NOT NULL,
	Phone char(12) NOT NULL unique,
	FedIDNo  varchar(10) NOT NULL,
	DateInSystem date NOT NULL 
);
INSERT INTO ShopDB.Customers
( CustumerNo, CustumerName, Address1, Address2, City, State, Zip, Contact, Phone, FedIDNo, DateInSystem)
VALUES
(1,'Alex', 'NewSTR', 'NewSTR2', 'City', 'NS', 'NewZip', 'dfgjs@mail.ru', '(093)1231212', 'FedID_001', NOW()),
(2,'Bob', 'NewSTR2', 'NewSTR22', 'City2', 'SN', 'NewZip2', 'dfg2@mail.ru', '(093)2221212', 'FedID_002', NOW());

CREATE INDEX CustumerName ON ShopDB.Customers (CustumerName);
EXPLAIN  SELECT * FROM ShopDB.Customers WHERE CustumerName in ('Bob');
-- filtered  = 100

EXPLAIN  SELECT * FROM ShopDB.Customers WHERE Phone in ('(093)1231212');
-- filtered  = 100

EXPLAIN  SELECT * FROM ShopDB.Customers WHERE FedIDNo in ('FedID_002'); -- столбец без индекса
-- filtered  = 50