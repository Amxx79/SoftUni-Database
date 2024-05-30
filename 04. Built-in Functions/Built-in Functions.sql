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

USE SoftUni

--10
SELECT EmployeeID, FirstName, LastName, Salary,
DENSE_RANK() OVER
(PARTITION BY Salary ORDER BY EmployeeID)
FROM Employees
WHERE Salary BETWEEN 10000 AND 50000
ORDER BY Salary DESC

--11
--With Column Table Expression
WITH CTE_RankSelection AS
(
	SELECT EmployeeID, FirstName, LastName, Salary,
	DENSE_RANK() OVER
	(PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
	FROM Employees
	WHERE Salary BETWEEN 10000 AND 50000
)

SELECT * FROM CTE_RankSelection
WHERE [Rank] = 2
	ORDER BY Salary DESC

--Nested query 
SELECT * FROM 
(
	SELECT EmployeeID, FirstName, LastName, Salary,
	DENSE_RANK() OVER
	(PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
	FROM Employees
	WHERE Salary BETWEEN 10000 AND 50000
) AS Result
WHERE Result.Rank = 2
	ORDER BY Salary DESC


--12
USE Geography

SELECT CountryName, IsoCode
FROM Countries
WHERE CountryName LIKE '%A%A%A%'
ORDER BY IsoCode

--13
SELECT PeakName, RiverName,
LOWER(CONCAT(SUBSTRING(PeakName, 1, LEN(PeakName)-1), RiverName)) AS Mix
FROM Peaks, Rivers
WHERE RIGHT(PeakName, 1) = LEFT(RiverName, 1)
ORDER BY Mix

--14
USE Diablo

SELECT TOP 50 [Name], FORMAT([Start], 'yyyy-MM-dd') AS Start
FROM Games
WHERE DATEPART(Year, Start) BETWEEN 2011 AND 2012
ORDER BY [Start], [Name]

SELECT UserName, SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email)) AS 'Email Provider'
FROM Users
ORDER BY [Email Provider], [Username]

--16

--LEGEND: '_' is symbol we should see it, '%' is symbol that may be or bay not be in ip 
SELECT Username, IpAddress 
FROM Users
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username


--17
SELECT [Name] AS Game,
[Part of the Day] = 
CASE
	WHEN DATEPART(HOUR, Start) < 12 THEN 'Morning'
	WHEN DATEPART(HOUR, Start) < 18 THEN 'Afternoon'
	WHEN DATEPART(HOUR, Start) < 24
	THEN 'Evening'
	END,
[Duration] = 
CASE
	WHEN Duration <= 3 THEN 'Extra Short'
	WHEN Duration >= 4 AND Duration <= 6 THEN 'Short'
	WHEN Duration >= 6 THEN 'Long'
	WHEN Duration IS NULL THEN 'Extra Long'
	END
FROM Games
ORDER BY [Name], [Duration], [Part of the Day]

--18
USE Orders

SELECT ProductName, OrderDate,
DATEADD(DAY, 3, OrderDate) AS [Pay Due],
DATEADD(MONTH, 1, OrderDate) AS [Deliver Due]
FROM Orders

--19
CREATE DATABASE People

USE People

CREATE TABLE People
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(32),
	Birthdate DATETIME2
)

INSERT INTO People
	VALUES
	('Victor', '2000-12-07 00:00:00.000'),
	('Steven', '1992-09-10 00:00:00.000'),
	('Stephen', '1910-09-19 00:00:00.000'),
	('John', '2010-01-06 00:00:00.000'),
	('Elenko', '2000-02-18 19:00:00.000')


SELECT * FROM
(
	SELECT Name, 
	[Age in Years] = DATEDIFF(YEAR, [Birthdate], GETDATE()),
	DATEDIFF(MONTH, [Birthdate], GETDATE()) AS [Age in Months],
	DATEDIFF(DAY, [Birthdate], GETDATE()) AS [Age in Days],
	DATEDIFF(MINUTE, [Birthdate], GETDATE()) AS [Age in Minutes]
	FROM People
) AS Result

