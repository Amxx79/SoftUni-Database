SELECT TOP(3) tr.Id, tr.HourOfDeparture, tck.Price, twns.[Name]
	FROM Trains AS tr
	JOIN Tickets AS tck ON tck.TrainId = tr.Id
	JOIN Towns AS twns ON twns.Id = tr.ArrivalTownId
	WHERE CAST(HourOfDeparture AS TIME) BETWEEN '8:00' AND '8:59' AND
	tck.Price > 50
	ORDER BY tck.Price