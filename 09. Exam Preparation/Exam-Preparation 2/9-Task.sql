SELECT tw.Name, COUNT(*) AS PassengersCount
	FROM Passengers AS p
	JOIN Tickets AS t ON t.PassengerId = p.Id
	JOIN Trains AS tr ON tr.Id = t.TrainId
	JOIN Towns AS tw ON tw.Id = tr.ArrivalTownId
	WHERE t.Price > 76.99
	GROUP BY tw.[Name]
	ORDER BY tw.[Name]