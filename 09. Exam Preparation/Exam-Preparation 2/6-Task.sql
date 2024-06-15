SELECT p.[Name], t.Price AS TicketPrice, t.DateOfDeparture, TrainId
	FROM Tickets AS t
	JOIN Passengers AS p ON t.PassengerId = p.Id
	ORDER BY t.Price DESC, p.[Name]