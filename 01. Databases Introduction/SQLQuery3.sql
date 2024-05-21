--10 - Add Check Constraint
ALTER TABLE Users
ADD CONSTRAINT CHK_PassIsAtLeastFiveSymbols
	CHECK(LEN(Password) >= 5)

--11. Make default value for DateTime

--DF is mean default value for last login time 
--Key word default mean, if you don't type specific info in it

ALTER TABLE Users
ADD CONSTRAINT DF_LastLoginTime DEFAULT GETDATE() FOR LastLoginTime

SELECT * FROM Users

INSERT INTO USERS(Username, [Password])
	VALUES('Petyo', 'IaMsTuPiD')


--12 - Set Unique Field

--Remove already created one 
ALTER TABLE Users
DROP CONSTRAINT PK_UsersTable

--Add new one which is only for field id
ALTER TABLE Users
ADD CONSTRAINT PK_UsersTable PRIMARY KEY(Id)

--13 - Create Database Movies

CREATE DATABASE Movies

DROP TABLE Directors
CREATE TABLE Directors
(
	Id INT NOT NULL,
	DirectorName VARCHAR(50),
	Notes VARCHAR(50)
)

DROP TABLE Genres

CREATE TABLE Genres
(
	Id INT NOT NULL,
	GenreName VARCHAR(50),
	Notes VARCHAR(50)
)

DROP TABLE Categories

CREATE TABLE Categories 
(
	Id INT NOT NULL,
	CategoryName VARCHAR(50),
	Notes VARCHAR(50)
)

DROP TABLE Movies

CREATE TABLE Movies 
(
	Id INT NOT NULL,
	Title VARCHAR(50),
	DirectorId INT,
	CopyrightYear INT,
	[Length] INT,
	GenreId INT,
	CategoryId INT,
	Rating INT,
	Notes INT
)

--SET PRIMARY KEY FOR EACH TABLE

ALTER TABLE Directors
	ADD CONSTRAINT PK_DirectorsTable PRIMARY KEY(Id)

ALTER TABLE Categories
	ADD CONSTRAINT PK_CategoriesTable PRIMARY KEY(Id)

ALTER TABLE Genres
	ADD CONSTRAINT PK_GenresTable PRIMARY KEY(Id)

ALTER TABLE Movies
	ADD CONSTRAINT PK_MoviesTable PRIMARY KEY(Id)

--16 - SoftUni Database

CREATE DATABASE SoftUni

CREATE TABLE Towns
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30),
)

CREATE TABLE Addresses
(
	Id INT PRIMARY KEY IDENTITY,
	AddressText VARCHAR(MAX),
	TownId INT FOREIGN KEY REFERENCES Towns(Id)
)


CREATE TABLE Departments 
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(30),
)

CREATE TABLE Employees
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName VARCHAR(60) NOT NULL,
	MiddleName VARCHAR(60),
	LastName VARCHAR(60) NOT NULL,
	JobTitle VARCHAR(60),
	DepartmentId INT FOREIGN KEY REFERENCES Departments(Id),
	HireDate DATETIME2,
	Salary DECIMAL(10,2),
	AddressId INT FOREIGN KEY REFERENCES Addresses(Id),
)

SELECT * FROM Departments


--18 - Basic Insert

USE SoftUni

INSERT INTO Towns
	VALUES('Sofia'),
	('Plovdiv'),
	('Varna'),
	('Burgas')

INSERT INTO Departments
	VALUES('Engineering'),
	('Sales'),
	('Marketing'),
	('Software Development'),
	('Quality Assurance')

INSERT INTO Employees(FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary)
	VALUES('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', '1', '2013/02/01', '3500.00'),
	('Petar', 'Petrov', 'Petrov', 'Senior Engineer', '2', '2004/03/02', '4000.00'),
	('Maria', 'Petrova', 'Ivanova', 'Intern', '3', '2016/08/28', '525.25'),
	('Georgi', 'Teziev', 'Ivanov','CEO', '4', '2007/12/09', '3000.00'),
	('Peter', 'Pan', 'Pan', 'Intern', '5', '2016/08/28', '599.88')



--19 - Basic Select All Fields
SELECT * FROM Towns
SELECT * FROM Departments
SELECT * FROM Employees


--20 - Basic Select All Fields and Order Them
SELECT * FROM Towns
ORDER BY Name ASC

SELECT * FROM Departments
ORDER BY Name ASC


SELECT * FROM Employees
ORDER BY Salary DESC


--21 - Basic Select Some Fields
SELECT Name FROM Towns
ORDER BY Name ASC

SELECT Name FROM Departments
ORDER BY Name ASC

SELECT FirstName, LastName, JobTitle, Salary FROM Employees
ORDER BY Salary DESC

--22 - Increase Employees Salary
UPDATE Employees
SET Salary = Salary * 1.1
SELECT Salary FROM Employees

--23 - Decrease Tax Rate
UPDATE Payments
SET TaxRate = TaxRate * 0.97
SELECT TaxRate FROM Payments

--24 - Delete All Records
TRUNCATE TABLE Occupancies

