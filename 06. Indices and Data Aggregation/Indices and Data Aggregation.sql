USE Gringotts

--1
SELECT COUNT(Id) AS Count
	FROM WizzardDeposits

--2
SELECT TOP(1) MAX(MagicWandSize) AS LongestMagicWand
	FROM WizzardDeposits
	GROUP BY DepositGroup


--3
SELECT DepositGroup, MAX(MagicWandSize) AS LongestMagicWand
	FROM WizzardDeposits
	GROUP BY DepositGroup

--4
SELECT TOP(2)  DepositGroup, AVG(MagicWandSize) AS [Avg]
	FROM WizzardDeposits
	GROUP BY DepositGroup
	ORDER BY [Avg]

--5
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum
	FROM WizzardDeposits
	GROUP BY DepositGroup

--6
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum
	FROM WizzardDeposits
	WHERE MagicWandCreator = 'Ollivander family'
	GROUP BY DepositGroup

--7
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum
	FROM WizzardDeposits
	WHERE MagicWandCreator = 'Ollivander family'
	GROUP BY DepositGroup
	HAVING SUM(DepositAmount) < 150000
	ORDER BY TotalSum DESC

--8
SELECT DepositGroup, MagicWandCreator, MIN(DepositCharge) AS MinDepositCharge
	FROM WizzardDeposits
	GROUP BY DepositGroup, MagicWandCreator
	ORDER BY DepositGroup, MagicWandCreator

--9
SELECT AgeGroup, COUNT(*) AS WizardCount
FROM
(
	SELECT
	CASE
		WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
		WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
		WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
		WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
		WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
		WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
		WHEN Age > 61 THEN '[61+]'
	END AS AgeGroup
		FROM WizzardDeposits
) AS query
WHERE AgeGroup IS NOT NULL
	GROUP BY AgeGroup

--10
SELECT FirstLetter 
FROM
(
SELECT SUBSTRING(FirstName, 1, 1) AS FirstLetter
	FROM WizzardDeposits
	WHERE DepositGroup = 'Troll Chest'
) AS query
	GROUP BY FirstLetter

--11
SELECT DepositGroup, IsDepositExpired, AVG(DepositInterest) AS AverageInterest
	FROM WizzardDeposits
	WHERE DepositStartDate > '1985-01-01'
	GROUP BY DepositGroup, IsDepositExpired
	ORDER BY DepositGroup DESC, IsDepositExpired

--12
SELECT SUM([Difference]) AS SumDifference
FROM
(
	SELECT FirstName AS [Host Wizard], DepositAmount AS [Host Wizard Deposit],
	LEAD(FirstName) OVER (ORDER BY Id) AS [Guest Wizard],
	LEAD(DepositAmount) OVER (ORDER BY Id) AS [Guest Wizard Deposit],
	(DepositAmount - LEAD(DepositAmount) OVER (ORDER BY Id)) AS [Difference]
		FROM WizzardDeposits
) AS query

--13
USE SoftUni

SELECT d.DepartmentID, SUM(e.Salary) AS TotalSalary
	FROM Departments AS d
JOIN Employees AS e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentID
ORDER BY d.DepartmentID

--14
SELECT DepartmentID, MIN(Salary) AS MinimumSalary
	FROM Employees
	WHERE HireDate > '2000-01-01' AND
	DepartmentID IN (2, 5, 7)
	GROUP BY DepartmentID

--15
SELECT * INTO RichEmployees
	FROM Employees
WHERE Salary > 30000

DELETE FROM RichEmployees
WHERE ManagerID = 42

UPDATE RichEmployees
SET Salary += 5000
WHERE DepartmentID = 1

SELECT DepartmentID, AVG(Salary) AS AverageSalary
	FROM RichEmployees
	GROUP BY DepartmentId

 