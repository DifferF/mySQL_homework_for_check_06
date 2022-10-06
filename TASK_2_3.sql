/*
Задание 2
Зайдите в базу данных “MyJoinsDB”, под созданным в предыдущем уроке пользователем. 
Проанализируйте, какие типы индексов заданы на созданных в предыдущем домашнем задании таблицах. 

---------------- Ответ ----------------
В моем случае в ДЗ 4 и 5 использоавл кластеризированный идекс PRIMARY KEY для связи объектов между таблицами
*/

/*
Задание 3
Задайте свои индексы на таблицах, созданных в предыдущем домашнем задании и обоснуйте их необходимость. 
*/

drop database MyJoinsDB;
CREATE DATABASE MyJoinsDB;

 CREATE TABLE MyJoinsDB.Employee
(
    id INT AUTO_INCREMENT NOT NULL, -- кластеризированный идекс PRIMARY KEY для связи объектов между таблицами
	surnamesN VARCHAR(30) NOT NULL,   			 
    nameN VARCHAR(30) NOT NULL, 				 
    patronymicN VARCHAR(30) DEFAULT 'Unknown', 	
    phone VARCHAR(20) NOT NULL unique, -- телефон  unique для оптимизированного поиска по номеру телефона, тажке поле может содержать только уникальные значения
    --  phone VARCHAR(20) NOT NULL, 
	PRIMARY KEY (id)
);

CREATE INDEX surnamesN ON MyJoinsDB.Employee (surnamesN); -- / создания индекса вручную / INDEX обеспечивает оптимизированный поиск и сортировку
EXPLAIN  SELECT * FROM MyJoinsDB.Employee WHERE surnamesN in ('Бакланов');
-- filtered до INDEX = 25 
-- filtered с INDEX = 100 для оптимизированного поиска по фамилии в случае необходимости

EXPLAIN  SELECT * FROM MyJoinsDB.Employee WHERE phone in ('(092)7612343');
-- filtered без unique = 25 
-- filtered с unique = 100

INSERT MyJoinsDB.Employee( nameN, patronymicN, surnamesN, phone)
VALUES
('Василий', 'Петрович', 'Гуглов', '(094)7612343'),
('Зигмунд', 'Федорович', 'Вишенька', '(093)7612343'),
('Олег', 'Евстафьевич', 'Бакланов', '(092)7612343'),
('Виктор', 'Евстафьевич', 'Абрамов', '(091)7612343');
 SELECT * FROM  MyJoinsDB.Employee ;
 ------------------------------------------------------------------------- 
  