SELECT t.Id, tw.[Name], m.Details
	FROM MaintenanceRecords AS m
	JOIN Trains AS t ON t.Id = m.TrainId
	JOIN Towns AS tw ON tw.Id = t.DepartureTownId
WHERE Details LIKE '%inspection%'
ORDER BY t.Id