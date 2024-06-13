--1
USE Bank

CREATE TABLE Logs
(LogId INT PRIMARY KEY IDENTITY,
AccountId INT, 
OldSum MONEY,
NewSum MONEY)

--Create the trigger where table is Accounts and trigger is for UPDATE put old and new info in other tables named Logs
CREATE OR ALTER TRIGGER tr_ChangeTroughAccount
ON Accounts
FOR UPDATE
AS
	INSERT INTO Logs(AccountId, NewSum, OldSum)
	SELECT i.Id, i.Balance, d.Balance FROM inserted AS i
	JOIN deleted AS d ON i.Id = d.Id
	WHERE i.Balance <> d.Balance
GO

UPDATE Accounts SET Balance += 1000 
WHERE Id = 1


--2
CREATE TABLE NotificationEmails
(Id INT PRIMARY KEY IDENTITY,
Recipient INT NOT NULL,
[Subject] NVARCHAR(MAX) NOT NULL,
Body NVARCHAR(MAX) NOT NULL)

CREATE OR ALTER TRIGGER tr_SendNotification
ON Logs
FOR INSERT
AS
	INSERT INTO NotificationEmails(Recipient, [Subject], Body)
	SELECT i.AccountId,
	CONCAT_WS(' ', 'Balance change for account:', i.AccountId), 
	CONCAT_WS(' ', 'On', GETDATE(), 'your balance was changed from',  i.OldSum, 'to', i.NewSum) from inserted AS i
GO

UPDATE Accounts SET Balance += 1000 
WHERE Id = 1

--3
CREATE PROCEDURE usp_DepositMoney(@AccountId INT, @MoneyAmount MONEY) 
AS
BEGIN
	IF(@MoneyAmount > 0)
	BEGIN
		UPDATE Accounts SET Balance += @MoneyAmount
			WHERE Id = @AccountId
	END
END

EXEC usp_DepositMoney 2, 700

--4
CREATE PROCEDURE usp_WithdrawMoney (@AccountId INT, @MoneyAmount MONEY) 
AS
BEGIN
	IF(@MoneyAmount > 0)
	BEGIN
		UPDATE Accounts SET Balance -= @MoneyAmount
			WHERE Id = @AccountId
	END
END

EXEC usp_WithdrawMoney 1, 5000

--5
CREATE OR ALTER PROCEDURE usp_TransferMoney(@SenderId INT, @ReceiverId INT, @Amount MONEY)
AS
BEGIN
	--First Approach
	--UPDATE Accounts SET Balance -= @Amount
	--Where Id = @SenderId AND Balance > @Amount
	--UPDATE Accounts SET Balance += @Amount
	--Where Id = @ReceiverId

	--Second Approach
	EXEC usp_WithdrawMoney @SenderId, @Amount
	EXEC usp_DepositMoney @ReceiverId, @Amount
END

EXEC usp_TransferMoney 2, 1, 100

--8
USE SoftUni

CREATE PROCEDURE usp_AssignProject(@emloyeeId INT, @projectID INT) 
AS
BEGIN TRANSACTION
	DECLARE @employeeProjectsCount INT = 
	(
		SELECT COUNT(ProjectId)
			FROM EmployeesProjects
			WHERE EmployeeId = @emloyeeId
	)

	IF(@employeeProjectsCount >= 3)
	BEGIN
		RAISERROR('The employee has too many projects!', 16, 1)
	END

	INSERT INTO EmployeesProjects
	VALUES
	(@emloyeeId, @projectId)

COMMIT TRANSACTION

EXEC usp_AssignProject 46, 1

--To check which employees had under 3 projects
SELECT EmployeeId FROM EmployeesProjects
GROUP BY EmployeeID
HAVING COUNT(ProjectId) < 3

--9
CREATE TABLE Deleted_Employees
(EmployeeId INT PRIMARY KEY,
FirstName VARCHAR(20),
LastName VARCHAR(20),
MiddleName VARCHAR(20),
JobTitle VARCHAR(50),
DepartmentId INT,
Salary MONEY) 

CREATE OR ALTER TRIGGER tr_DeletedEmployees
ON Employees
FOR DELETE
AS
	INSERT INTO Deleted_Employees
	SELECT d.EmployeeId, d.FirstName, d.LastName, d.MiddleName, d.JobTitle, d.DepartmentId, d.Salary 
		FROM deleted AS d
GO

DELETE FROM Employees
WHERE EmployeeId = 293

