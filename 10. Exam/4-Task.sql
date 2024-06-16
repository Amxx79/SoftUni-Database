begin transaction

DELETE
	FROM LibrariesBooks 
	WHERE BookId = 1

DELETE 
	FROM Books
	WHERE AuthorId = 1

DELETE FROM Authors
WHERE ID = 1
rollback transaction