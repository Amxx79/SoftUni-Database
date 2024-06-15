CREATE DATABASE TouristAgency

USE TouristAgency
--01
CREATE TABLE Countries(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE Destinations(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL,
	CountryId INT FOREIGN KEY REFERENCES Countries(Id) NOT NULL
)

CREATE TABLE Rooms(
	Id INT PRIMARY KEY IDENTITY,
	[Type] VARCHAR(40) NOT NULL,
	Price Decimal(18,2) NOT NULL,
	BedCount INT NOT NULL
		CHECK (BedCount > 0 AND BedCount <= 10)
)

CREATE TABLE Hotels(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL,
	DestinationId INT FOREIGN KEY REFERENCES Destinations(Id) NOT NULL
)

CREATE TABLE Tourists(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(80) NOT NULL,
	PhoneNumber VARCHAR(20) NOT NULL,
	Email VARCHAR(80),
	CountryId INT FOREIGN KEY REFERENCES Countries(Id) NOT NULL
)

CREATE TABLE Bookings(
	Id INT PRIMARY KEY IDENTITY,
	ArrivalDate DATETIME2 NOT NULL,
	DepartureDate DATETIME2 NOT NULL,
	AdultsCount INT NOT NULL
		CHECK (AdultsCount > 0 AND AdultsCount <= 10),
	ChildrenCount INT NOT NULL
		CHECK (ChildrenCount >= 0 AND ChildrenCount <= 9),
	TouristId INT FOREIGN KEY REFERENCES Tourists(Id) NOT NULL,
	HotelId INT FOREIGN KEY REFERENCES Hotels(Id) NOT NULL,
	RoomId INT FOREIGN KEY REFERENCES Rooms(Id) NOT NULL
)

CREATE TABLE HotelsRooms(
	HotelId INT FOREIGN KEY REFERENCES Hotels(Id) NOT NULL,
	RoomId INT FOREIGN KEY REFERENCES Rooms(Id) NOT NULL
	CONSTRAINT PK_HotelsRooms PRIMARY KEY (HotelId, RoomId)
)

--02
INSERT INTO Tourists([Name], PhoneNumber, Email, CountryId)
VALUES
	('John Rivers',	'653-551-1555', 'john.rivers@example.com', 6),
	('Adeline Aglaé', '122-654-8726',	'adeline.aglae@example.com', 2),
	('Sergio Ramirez', '233-465-2876', 's.ramirez@example.com', 3),
	('Johan Müller',	'322-876-9826', 'j.muller@example.com', 7),
	('Eden Smith', '551-874-2234',	'eden.smith@example.com', 6)

INSERT INTO Bookings
VALUES
	('2024-03-01',	'2024-03-11', 1, 0, 21, 3, 5),
	('2023-12-28',	'2024-01-06', 2, 1, 22, 13, 3),
	('2023-11-15',	'2023-11-20', 1, 2, 23, 19, 7),
	('2023-12-05',	'2023-12-09', 4, 0, 24, 6, 4),
	('2024-05-01',	'2024-05-07', 6, 0, 25, 14, 6)

--03
UPDATE Bookings
SET DepartureDate = DATEADD(DAY, 1, DepartureDate)
WHERE ArrivalDate >= '2023-12-01' AND ArrivalDate <= '2023-12-31' 

UPDATE Tourists
SET Email = NULL
WHERE [Name] LIKE '%Ma%'

--04
BEGIN TRANSACTION
SELECT * FROM Tourists
WHERE [NAME] LIKE '%SMITH'

DECLARE @deletedTouristsSmith TABLE (Id INT)
INSERT INTO @deletedTouristsSmith
SELECT Id FROM Tourists
WHERE [Name] LIKE '%SMITH'

DELETE FROM Bookings
WHERE TouristId IN (SELECT Id FROM @deletedTouristsSmith)

DELETE FROM Tourists
WHERE Id IN (SELECT Id FROM @deletedTouristsSmith)
COMMIT

--05
SELECT FORMAT(ArrivalDate, 'yyyy-MM-dd'),
	AdultsCount, ChildrenCount
	FROM Bookings AS b
	JOIN Rooms AS r ON b.RoomId = r.Id
	ORDER BY Price DESC, ArrivalDate ASC

--06
SELECT h.Id, [Name] FROM Hotels AS h
	JOIN HotelsRooms AS hr ON h.Id = hr.HotelId
	JOIN Rooms AS r ON r.Id = hr.RoomId
	JOIN Bookings AS b ON b.HotelId = h.Id
	WHERE r.Type = 'VIP Apartment'
	GROUP BY h.[Name], h.Id
	ORDER BY COUNT(*) DESC

--07
SELECT Id, [Name], PhoneNumber
	FROM Tourists
	WHERE Id NOT IN (SELECT TouristId FROM Bookings)
	ORDER BY [Name]

--08
SELECT TOP(10) h.[Name] AS HotelName, d.[Name] AS DestinationName, c.[Name] AS CountryName
	FROM Bookings AS b
	JOIN Hotels AS h ON h.Id = b.HotelId
	JOIN Destinations AS d ON d.Id = h.DestinationId
	JOIN Countries AS c ON c.Id = d.CountryId
	WHERE ArrivalDate < '2023-12-31' AND 
	h.Id % 2 != 0
	ORDER BY c.[Name], ArrivalDate


--09
SELECT h.[Name], r.Price
	FROM Tourists AS t
	JOIN Bookings AS b ON b.TouristId = t.Id
	JOIN Hotels AS h ON h.Id = b.HotelId
	JOIN Rooms AS r ON r.Id = b.RoomId
	WHERE t.[Name] NOT LIKE '%EZ'
	ORDER BY r.Price DESC


--10
SELECT * 
	FROM Bookings AS b



	

