CREATE DATABASE TableRelations
USE TableRelations

--DROP TABLE Passports
--DROP TABLE Persons
--DROP DATABASE TableRelations

--1.

CREATE TABLE Passports
(
	PassportID INT PRIMARY KEY IDENTITY(101, 1),
	PassportNumber VARCHAR(32) NOT NULL
)

CREATE TABLE Persons
(
	PersonID INT PRIMARY KEY IDENTITY(1, 1),
	FirstName VARCHAR(32) NOT NULL,
	Salary DECIMAL(10, 2),
	PassportID INT UNIQUE FOREIGN KEY REFERENCES Passports(PassportID)
)

INSERT INTO Passports
	VALUES
	('N34FG21B'),
	('K65LO4R7'),
	('ZE657QP2')

INSERT INTO Persons
	VALUES
	('Roberto', 43300, 102),
	('Tom', 56100, 103),
	('Yana', 60200, 101)

--2.

CREATE TABLE Manufacturers
(
	ManufacturerID INT PRIMARY KEY IDENTITY(1,1),
	[Name] VARCHAR(32) NOT NULL,
	EstablishedOn DATETIME2
)

CREATE TABLE Models
(
	ModelID INT PRIMARY KEY IDENTITY(101, 1),
	[Name] VARCHAR(32) NOT NULL,
	ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
)

INSERT INTO Manufacturers
	VALUES
	('BMW', '07/03/1916'),
	('Tesla', '01/01/2003'),
	('Lada', '01/05/1966')

INSERT INTO Models
VALUES
	('X1', 1),
	('i6', 1),
	('Model S', 2),
	('Model X', 2),
	('Model 3', 2),
	('Nova', 3)

SELECT * FROM Manufacturers

--03.

CREATE TABLE Students
(
	StudentID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(16) NOT NULL
)

CREATE TABLE Exams
(
	ExamID INT PRIMARY KEY IDENTITY(101, 1),
	[Name] VARCHAR(16) NOT NULL
)

CREATE TABLE StudentsExams
(
	StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
	ExamID INT FOREIGN KEY REFERENCES Exams(ExamID)
	CONSTRAINT PK_StudentsExams PRIMARY KEY(StudentID, ExamID)
)

INSERT INTO Students
	VALUES
	('Mila'),
	('Toni'),
	('Ron')

INSERT INTO Exams
	VALUES
	('SpringMVC'),
	('Neo4j'),
	('Oracle 11g')

INSERT INTO StudentsExams
	VALUES
	(1, 101),
	(1, 102),
	(2, 101),
	(3, 103),
	(2, 102),
	(2, 103)

--JOIN Operator on the third table 

SELECT Students.Name, Exams.Name
FROM StudentsExams
JOIN Students ON StudentsExams.StudentID = Students.StudentID
JOIN Exams ON StudentsExams.ExamID = Exams.ExamID

--04.

CREATE TABLE Teachers
(
	TeacherID INT PRIMARY KEY IDENTITY(101,1),
	[Name] VARCHAR(32),
	ManagerID INT FOREIGN KEY REFERENCES Teachers(TeacherID)
)

INSERT INTO Teachers(Name)
	VALUES
	('John'),
	('Maya'),
	('Silvia'),
	('Ted'),
	('Mark'),
	('Greta')

SELECT * FROM Teachers

UPDATE Teachers
SET ManagerID = NULL
WHERE TeacherID = 101

UPDATE Teachers
SET ManagerID = 106
WHERE TeacherID = 102

UPDATE Teachers
SET ManagerID = 106
WHERE TeacherID = 103

UPDATE Teachers
SET ManagerID = 105
WHERE TeacherID = 104

UPDATE Teachers
SET ManagerID = 101
WHERE TeacherID = 105

UPDATE Teachers
SET ManagerID = 101
WHERE TeacherID = 106

--05.
--CREATE E/R Diagram

CREATE DATABASE OnlineStore
USE OnlineStore

CREATE TABLE ItemTypes
(
	ItemTypeID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(32) NOT NULL
)

CREATE TABLE Items
(
	ItemID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(32) NOT NULL,
	ItemTypeID INT FOREIGN KEY REFERENCES ItemTypes(ItemTypeID)
)

CREATE TABLE Cities
(
	CityID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(32) NOT NULL
)

CREATE TABLE Customers
(
	CustomerID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(32) NOT NULL,
	Birthday DATETIME2,
	CityID INT FOREIGN KEY REFERENCES Cities(CityID)
)

CREATE TABLE Orders
(
	OrderID INT PRIMARY KEY IDENTITY,
	CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID)
)

CREATE TABLE OrderItems
(
	OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
	ItemID INT FOREIGN KEY REFERENCES Items(ItemID)
	CONSTRAINT PK_OrdersItems PRIMARY KEY(OrderID, ItemID)
)

--06.
--CREATE E/R Diagram

CREATE DATABASE University
USE University

CREATE TABLE Majors
(
	MajorID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(32)
)

CREATE TABLE Students
(
	StudentID INT PRIMARY KEY IDENTITY,
	StudentNumber VARCHAR(32),
	StudentName VARCHAR(32),
	MajorID INT FOREIGN KEY REFERENCES Majors(MajorID)
)

CREATE TABLE Payments
(
	PaymentID INT PRIMARY KEY IDENTITY,
	PaymentDate DATETIME2,
	PaymentAmount DECIMAL(10,2),
	StudentID INT FOREIGN KEY REFERENCES Students(StudentID)
)

CREATE TABLE Subjects
(
	SubjectID INT PRIMARY KEY IDENTITY,
	SubjectName VARCHAR(32)
)

CREATE TABLE Agenda
(
	StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
	SubjectID INT FOREIGN KEY REFERENCES Subjects(SubjectID),
	CONSTRAINT PK_Agenda PRIMARY KEY(StudentID,SubjectID)
)
USE Geography

--Example of Joining Countries, With their Country codes and Names of the country

SELECT Countries.CountryName, MountainsCountries.CountryCode, Mountains.MountainRange, MountainId FROM MountainsCountries
JOIN Countries ON Countries.CountryCode = MountainsCountries.CountryCode
JOIN Mountains ON Mountains.Id = MountainsCountries.MountainId

--9.
--Show all peaks in 'Rila' Bulgaria in Descending Order

SELECT MountainRange, PeakName, Elevation FROM Peaks
JOIN Mountains ON Peaks.MountainId = Mountains.Id
WHERE MountainId = 17
ORDER BY Elevation DESC