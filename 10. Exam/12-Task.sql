CREATE OR ALTER PROCEDURE usp_SearchByGenre(@genreName VARCHAR(50))
AS
BEGIN
	SELECT b.Title, b.YearPublished AS [Year], ISBN, a.[Name] AS Author, g.[Name] AS Genre
	FROM Books AS b
	JOIN Genres AS g ON g.Id = b.GenreId
	JOIN Authors AS a ON a.Id = b.AuthorId
	WHERE g.Name = @genreName
	ORDER BY b.Title ASC
END

EXEC usp_SearchByGenre 'Fantasy'

