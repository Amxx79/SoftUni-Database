SELECT t.[Name],
		rs.[Name]
	FROM RailwayStations AS rs
	JOIN Towns AS t ON t.Id = rs.TownId
	WHERE rs.Id NOT IN(SELECT RailwayStationId FROM TrainsRailwayStations)
	ORDER BY t.[Name], rs.[Name]