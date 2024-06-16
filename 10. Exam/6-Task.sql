SELECT b.Id, b.Title, ISBN, g.Name
	FROM Books AS b
	JOIN Genres AS g ON g.Id = b.GenreId
	WHERE g.Name = 'Biography' OR g.Name = 'Historical Fiction'
	ORDER BY g.Name, b.Title