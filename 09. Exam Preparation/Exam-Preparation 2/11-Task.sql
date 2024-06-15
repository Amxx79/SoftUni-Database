CREATE FUNCTION udf_TownsWithTrains(@name VARCHAR(50))
RETURNS INT
AS
BEGIN
RETURN(
	SELECT COUNT(*)
		FROM Trains AS tr
		JOIN Towns AS ta ON ta.Id = tr.ArrivalTownId
		JOIN Towns AS td ON td.Id = tr.DepartureTownId
		WHERE ta.Name = @name OR td.Name = @name)
END

SELECT dbo.udf_TownsWithTrains('Paris')

