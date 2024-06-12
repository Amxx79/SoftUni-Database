--1
USE SoftUni

CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000
AS
BEGIN
	SELECT FirstName, LastName
	FROM
		Employees
		WHERE Salary > 35000
END

EXEC usp_GetEmployeesSalaryAbove35000

--2
CREATE OR ALTER PROCEDURE usp_GetEmployeesSalaryAboveNumber(@amount DECIMAL(18,4))
AS
BEGIN
	SELECT FirstName, LastName
	FROM Employees
	WHERE Salary >= @amount
END

EXEC usp_GetEmployeesSalaryAboveNumber 35000

--3
CREATE OR ALTER PROCEDURE usp_GetTownsStartingWith(@string VARCHAR(MAX))
AS
BEGIN
	SELECT [Name] AS Town
	FROM Towns
	WHERE [Name] LIKE CONCAT(@string,'%')
	
END

EXEC usp_GetTownsStartingWith 'M'

--4
CREATE PROCEDURE usp_GetEmployeesFromTown(@townName VARCHAR(MAX))
AS
BEGIN
	SELECT FirstName, LastName
	FROM Employees AS e
	JOIN Addresses AS a ON e.AddressID = a.AddressID
	JOIN Towns AS t ON t.TownID = a.TownID
	WHERE t.[Name] = @townName
END

EXEC usp_GetEmployeesFromTown 'Seattle'

--5
CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @salaryLevel VARCHAR(MAX)
	IF(@salary < 30000)
		SET @salaryLevel = 'Low'
	ELSE IF (@salary BETWEEN 30000 AND 50000)
		SET @salaryLevel = 'Average'
	ELSE
		SET @salaryLevel = 'High'
	RETURN @salaryLevel
END

SELECT FirstName, LastName, dbo.ufn_GetSalaryLevel(Salary) FROM Employees

--6
CREATE PROCEDURE usp_EmployeesBySalaryLevel(@salaryLevel VARCHAR(10))
AS
BEGIN
	SELECT FirstName, LastName
	FROM Employees
	WHERE dbo.ufn_GetSalaryLevel(Salary) = @salaryLevel
END

EXEC usp_EmployeesBySalaryLevel average

--7
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(MAX), @word VARCHAR(MAX))
RETURNS BIT
AS
BEGIN
	DECLARE @wordLenght INT = LEN(@word)
	DECLARE @iterator INT = 1

	WHILE(@iterator <= @wordLenght)
	BEGIN
		IF(CHARINDEX(SUBSTRING(@word, @iterator, 1), @setOfLetters) = 0)
		RETURN 0
		SET @iterator += 1
	END
	RETURN 1
END

SELECT dbo.ufn_IsWordComprised('oistmiahf', 'Sofia')

--8
CREATE PROCEDURE usp_DeleteEmployeesFromDepartment (@departmentId INT) 
AS
BEGIN
	DECLARE @firedEmployees TABLE (Id INT)
	INSERT INTO @firedEmployees
		SELECT EmployeeId
		FROM Employees
		WHERE DepartmentId = @departmentId

	ALTER TABLE Departmends
	ALTER COLUMN ManagerId INT NULL

	UPDATE Departments
	SET ManagerId = NULL
	WHERE ManagerId IN
	(
		SELECT * FROM @firedEmployees
	)

	DELETE FROM EmployeesProjects
	WHERE EmployeeID IN
	(
		SELECT * FROM @firedEmployees
	)

	UPDATE Employees
	SET ManagerID = NULL
	WHERE ManagerID IN
	(
		SELECT * FROM @firedEmployees
	)

	DELETE FROM Employees
	WHERE DepartmentID = @departmentId

	DELETE FROM Departments
	WHERE DepartmentID = @departmentId

	SELECT COUNT(*) FROM Employees
	WHERE DepartmentId = @departmentId
END
