SELECT TOP(3) Title, YearPublished AS Year, g.Name
	FROM Books AS b
	JOIN Genres AS g ON g.Id = b.GenreId
	WHERE (YearPublished > 2000 AND
	Title LIKE '%a%' AND g.Name <> 'Fantasy') OR
	YearPublished < 1950 AND g.Name = 'Fantasy'
	ORDER BY Title ASC , YearPublished DESC