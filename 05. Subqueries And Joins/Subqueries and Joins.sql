USE SoftUni

--1
SELECT TOP 5 EmployeeID, JobTitle, a.AddressID, a. AddressText
	FROM
Employees
JOIN Addresses AS a ON Employees.AddressID = a.AddressID
ORDER BY a.AddressID

--2
SELECT TOP 50 FirstName, LastName, t.Name AS Town, a. AddressText
	FROM
Employees AS e
JOIN Addresses AS a ON e.AddressID = a.AddressID
JOIN Towns as t on a.TownID = t.TownID
ORDER BY e.FirstName, e.LastName

--3
SELECT EmployeeID, FirstName, LastName, d.Name AS DepartmentName
	FROM
Employees
JOIN Departments AS d ON Employees.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'
ORDER BY EmployeeID

--4
SELECT TOP 5 EmployeeID, FirstName, Salary, d.Name AS DepartmentName
	FROM
Employees
JOIN Departments AS d ON Employees.DepartmentID = d.DepartmentID
WHERE Employees.Salary > 15000
ORDER BY d.DepartmentID

--5
SELECT TOP(3) Employees.EmployeeId, FirstName
	FROM Employees
	LEFT JOIN EmployeesProjects AS emp ON Employees.EmployeeID = emp.EmployeeID
WHERE emp.EmployeeID IS NULL
ORDER BY EmployeeID

--6
SELECT FirstName, LastName, HireDate, d.Name
	FROM Employees AS e
	JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
WHERE HireDate > '1999-01-01' AND 
d.Name IN ('Sales', 'Finance')

--7
SELECT TOP(5) Employees.EmployeeId, FirstName, p.Name
FROM Employees
JOIN EmployeesProjects AS emp ON Employees.EmployeeID = emp.EmployeeID
JOIN Projects AS p ON emp.ProjectID = p.ProjectID AND p.EndDate IS NULL
WHERE P.StartDate > '2002-08-14'
ORDER BY EmployeeID

--8
SELECT TOP(5) Employees.EmployeeId, FirstName, [p.Name] = 
CASE 
	WHEN DATEPART(YEAR, StartDate) > 2004
	THEN NULL
	ELSE p.Name
END
FROM Employees
JOIN EmployeesProjects AS emp ON Employees.EmployeeID = emp.EmployeeID
JOIN Projects AS p ON emp.ProjectID = p.ProjectID
WHERE Employees.EmployeeID = 24
ORDER BY EmployeeID

--9
WITH CTE_Now AS 
(
	SELECT e.EmployeeId, e.FirstName, e.ManagerID, emp.FirstName AS ManagerName
		FROM Employees AS e
	JOIN Employees AS emp ON e.ManagerID = emp.EmployeeID
)
SELECT * FROM CTE_Now
WHERE ManagerID IN (3, 7)
ORDER BY EmployeeID

--10
SELECT TOP(50) e.EmployeeId, 
CONCAT_WS(' ', e.FirstName, e.LastName) AS EmployeeName,
CONCAT_WS(' ', emp.FirstName, emp.LastName) AS ManagerName,
d.Name AS DeparmentName
	FROM Employees AS e
JOIN Employees AS emp ON e.ManagerID = emp.EmployeeID
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
ORDER BY e.EmployeeID