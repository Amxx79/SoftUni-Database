CREATE PROCEDURE usp_SearchByTown(@townName VARCHAR(50))
AS
BEGIN
	SELECT p.[Name] AS PassengerName, t.DateOfDeparture, tr.HourOfDeparture
		FROM Passengers AS p
		JOIN Tickets AS t ON t.PassengerId = p.Id
		JOIN Trains AS tr ON tr.Id = t.TrainId
		JOIN Towns AS tw ON tw.Id = tr.ArrivalTownId
		WHERE tw.[Name] = @townName
		ORDER BY t.DateOfDeparture DESC, p.[Name]
END

EXEC usp_SearchByTown 'Berlin'
