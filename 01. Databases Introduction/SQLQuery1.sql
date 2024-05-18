--01 - Create Database

DROP TABLE Minions

--02 - Create table Minions
CREATE TABLE Minions
	(Id INT PRIMARY key,
	[Name] VARCHAR(200),
	Age INT
	)
--03 - Create table Towns
CREATE TABLE Towns
(Id INT PRIMARY key,
[Name] VARCHAR(200),
)

ALTER TABLE Minions
Add TownId Int

ALTER TABLE Minions
ADD FOREIGN KEY (TownId) REFERENCES Towns(Id)

--04 - Insert Records in Both Tables
INSERT INTO Towns (Id, [Name])
	VALUES(1, 'Sofia'),
	(2, 'Plovdiv'),
	(3, 'Varna')

	SELECT * FROM TOWNS

INSERT INTO Minions (Id, [Name], Age, TownId)
Values(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', Null, 2)

SELECT * FROM Minions

