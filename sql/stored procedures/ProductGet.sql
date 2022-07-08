CREATE PROCEDURE ProductGet (
	`@ProductID` INT
)
BEGIN
	SELECT
		ProductID,
        ProductName,
        price,
        Quantity,
        CreatedDate
	FROM Product
    WHERE ProductID = `@ProductID`;
END
