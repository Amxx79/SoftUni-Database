--05 - Truncate Table Minions

TRUNCATE TABLE Minions


--View what it's on the minions table
SELECT * FROM Minions

--06 - Drop (Delete) Table Minions and Towns

DROP TABLE Minions
DROP TABLE Towns

--07 - Create Table People

CREATE TABLE People
(
	Id Int Primary Key Identity,
	[Name] nvarchar(200) NOT NULL,
	Picture VARBINARY(MAX),
	Height Decimal(3,2),
	[Weight] DECIMAL(5,2),
	Gender CHAR(1) NOT NULL,
		CHECK(Gender in ('m', 'f')),
	Birthdate DATETIME2 NOT NULL,
	Biography VARCHAR(MAX)
)

--Insert People in table 'People'

INSERT INTO People([Name], Gender, Birthdate)
	VALUES
	('Jorji', 'm', '1999.05.10'),
	('Monica', 'f', '1993.07.11'),
	('Isabell', 'f', '2003.03.06'),
	('Ivan', 'm', '1990.01.02'),
	('Peter', 'm', '1994.04.12')

--Show all people from table
	SELECT * FROM People

--08 - Create Table Users
CREATE TABLE Users
(
	Id BIGINT PRIMARY KEY IDENTITY,
	Username VARCHAR(30) NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	ProfilePicture VARBINARY(MAX),
	LastLoginTime DATETIME2,
	IsDeleted BIT
)

--Insert Users in new Table

INSERT INTO Users(Username, [Password])
	VALUES
	('Pesho', 'thisisstrong'),
	('Jorji', 'weakPAss'),
	('Galya', 'iamidiot'),
	('Rumkata', 'bestCoocker'),
	('Toncheto', 'iwillbeatyou')


--Show all users in new table
SELECT * FROM Users

--09 - Change Primary Key

--Remove Current Primary Key
ALTER TABLE Users
DROP CONSTRAINT PK__Users__3214EC07EB0D323F

--Set new Primary Key
ALTER TABLE Users
ADD CONSTRAINT PK_UsersTable PRIMARY KEY(Id, Username)

SELECT * FROM Users

