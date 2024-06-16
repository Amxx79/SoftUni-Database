SELECT l.[Name] AS Library, c.Email AS Email
	FROM Libraries AS l
	JOIN Contacts AS c ON c.Id = l.ContactId
	WHERE NOT EXISTS(
	SELECT 1
	FROM LibrariesBooks AS lb
	JOIN Books AS b ON b.Id = lb.BookId
	JOIN Genres AS g ON g.Id = b.GenreId
	JOIN Contacts AS c ON c.Id = l.ContactId
	WHERE lb.LibraryId = l.Id AND g.[Name] = 'Mystery')
	ORDER BY l.Name

