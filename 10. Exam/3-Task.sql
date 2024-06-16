UPDATE Contacts
SET Website = ('www.' + LOWER(REPLACE(a.Name, ' ', '') + '.com'))
FROM Contacts AS c
JOIN Authors AS a ON a.ContactId = c.Id
WHERE Website IS NULL

SELECT COUNT(Website) AS NonNullWebsiteCount
FROM Contacts
WHERE Website IS NOT NULL;
