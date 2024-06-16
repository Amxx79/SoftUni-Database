SELECT a.Name, b.Title, l.Name AS Library, c.PostAddress
	FROM Books AS b
	JOIN LibrariesBooks AS lb ON lb.BookId = b.Id
	JOIN Libraries AS l ON lb.LibraryId = l.Id
	JOIN Authors AS a ON a.Id = b.AuthorId
	JOIN Contacts AS c ON c.Id = l.ContactId
	JOIN Genres AS g ON g.Id = b.GenreId
	WHERE g.Name = 'Fiction' AND c.PostAddress LIKE '%denver%'
	ORDER BY b.Title

	 --a.Name AS Author, Title, l.[Name] AS [Library], c.PostAddress AS [Library Address]
