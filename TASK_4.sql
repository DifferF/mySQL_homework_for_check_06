/*
Задание 4
Создайте представления для таких заданий: 
1. VIEW Необходимо узнать контактные данные сотрудников (номера телефонов, место жительства). 
2. VIEW Необходимо узнать информацию о дате рождения всех не женатых сотрудников и номера телефонов этих сотрудников. 
3. VIEW Необходимо узнать информацию о дате рождения всех сотрудников с должностью менеджер и номера телефонов этих сотрудников.
*/

drop database MyJoinsDB;
CREATE DATABASE MyJoinsDB;

 CREATE TABLE MyJoinsDB.Employee  -- работник
(
    id INT AUTO_INCREMENT NOT NULL,
	surnamesN VARCHAR(30) NOT NULL,   			 -- Фамили
    nameN VARCHAR(30) NOT NULL, 				 -- Имя
    patronymicN VARCHAR(30) DEFAULT 'Unknown', 	 -- Отчество
    phone VARCHAR(20) NOT NULL, -- телефон
	PRIMARY KEY (id)
);

INSERT MyJoinsDB.Employee( nameN, patronymicN, surnamesN, phone)
VALUES
('Василий', 'Петрович', 'Лященко', '(091)7612343'),
('Зигмунд', 'Федорович', 'Унакий', '(092)7612343'),
('Олег', 'Евстафьевич', 'Выжлецов', '(093)7612343'),
('Виктор', 'Евстафьевич', 'Наглецов', '(094)7612343');
 SELECT * FROM  MyJoinsDB.Employee ;
 ------------------------------------------------------------------------- 
  CREATE TABLE MyJoinsDB.workingPosition 
(	
	-- id INT AUTO_INCREMENT NOT NULL,
     EmployeeIDPosition INT not null,
     jobTitle VARCHAR(30) NOT NULL,    	-- Должность
     salary double NOT NULL, 			-- Зарлата     
     FOREIGN KEY(EmployeeIDPosition) references Employee(id),
     PRIMARY KEY (EmployeeIDPosition)
);

INSERT INTO MyJoinsDB.workingPosition																			   
(EmployeeIDPosition, jobTitle, salary)
VALUES
(1, 'главный директор', 150000.00),
(2, 'менеджер', 120000.00),
(3, 'рабочий', 100000.00),
(4, 'менеджер', 100000.00);
SELECT * FROM  MyJoinsDB.workingPosition;
 -------------------------------------------------------------------------
 CREATE TABLE MyJoinsDB.workingStatus   
(		 
     EmployeeID INT not null,
     statusF VARCHAR(30) NOT NULL, 
     dateBirth DATE NOT NULL, 			
     address VARCHAR(100) NOT NULL, 		 
     FOREIGN KEY(EmployeeID) references Employee(id),
     PRIMARY KEY (EmployeeID)
);

INSERT INTO MyJoinsDB.workingStatus 																			   
(EmployeeID, statusF, dateBirth, address)
VALUES
(1, 'не женат', '1981-11-11', 'Ул Плюшкина / 1'),
(2, 'женат', '1982-11-11', 'Ул Плюшкина / 2'),
(3, 'не женат', '1983-11-11', 'Ул Плюшкина / 3'),
(4, 'женат', '1984-11-11', 'Ул Плюшкина / 4');
SELECT * FROM  MyJoinsDB.workingStatus;
 -------------------------------------------------------------------------
 
-- 1. VIEW Необходимо узнать контактные данные сотрудников (номера телефонов, место жительства).
CREATE VIEW MyJoinsDB.View_address_phone
AS SELECT phone, address FROM MyJoinsDB.Employee
JOIN MyJoinsDB.workingStatus  ON id = EmployeeID;
SELECT * FROM MyJoinsDB.View_address_phone;

-- 2. VIEW Необходимо узнать информацию о дате рождения всех не женатых сотрудников и номера телефонов этих сотрудников.
CREATE VIEW MyJoinsDB.View_statusF_phone
AS SELECT dateBirth, phone FROM MyJoinsDB.Employee 
JOIN MyJoinsDB.workingStatus   ON  statusF = 'не женат' and id = EmployeeID;
SELECT * FROM MyJoinsDB.View_statusF_phone;

-- 3. VIEW Необходимо узнать информацию о дате рождения всех сотрудников с должностью менеджер и номера телефонов этих сотрудников.
CREATE VIEW MyJoinsDB.View_dateBirth_phone
AS SELECT phone as ТЕЛЕФОН, dateBirth as ДЕНЬ_РОЖДЕНИЯ, CONCAT(surnamesN, ' ', nameN) as ИМЯ FROM MyJoinsDB.Employee 
JOIN MyJoinsDB.workingPosition
ON     jobTitle = 'менеджер'  and id = EmployeeIDPosition
JOIN MyJoinsDB.workingStatus 
ON id = EmployeeID;
SELECT * FROM MyJoinsDB.View_dateBirth_phone;