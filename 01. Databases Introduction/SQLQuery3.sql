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