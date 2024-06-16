
CREATE FUNCTION udf_AuthorsWithBooks(@name VARCHAR(50)) 
RETURNS INT
AS
BEGIN
RETURN(
	SELECT COUNT(*) FROM Books AS b
	JOIN Authors AS a ON a.Id = b.AuthorId
	WHERE a.Name = @name)
END

SELECT dbo.udf_AuthorsWithBooks('J.K. Rowling')