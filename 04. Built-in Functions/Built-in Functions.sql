USE SoftUni

--1
SELECT FirstName, LastName
FROM EMPLOYEES
WHERE FirstName LIKE 'Sa%'

--2
SELECT FirstName, LastName 
FROM Employees
WHERE LastName LIKE '%ei%'

--3
SELECT FirstName 
From Employees
WHERE DepartmentID IN (3, 10) AND
DATEPART(YEAR, HireDate) BETWEEN 1995  AND 2005

--4
SELECT FirstName, LastName
FROM Employees
WHERE JobTitle NOT LIKE '%engineer%'

--5
SELECT [Name]
FROM Towns
WHERE LEN([Name]) = 5 OR LEN([Name]) = 6
ORDER BY [Name]

--6
SELECT TownID, [Name]
FROM Towns
WHERE [Name] LIKE '[mkbe]%'
ORDER BY [Name]

--7
SELECT TownID, Name
FROM Towns
WHERE Name NOT LIKE '[rbd]%'
ORDER BY [Name]

--8
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName
FROM Employees
WHERE DATEPART(YEAR, HireDate) > 2000

SELECT * FROM V_EmployeesHiredAfter2000

--9
SELECT FirstName, LastName
FROM Employees
WHERE LEN(LastName) = 5

--10
--TOMOROW I SHOW YOU
