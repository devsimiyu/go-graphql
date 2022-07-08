CREATE PROCEDURE ProductSave (
	`@ProductID` INT,
    `@ProductName` VARCHAR(256),
    `@Price` INT,
    `@Quantity` INT
)
BEGIN
	IF `@ProductID` IS NULL OR `@ProductID` = ''
    THEN
		INSERT INTO Product(ProductName, Price, Quantity)
        VALUES (`@ProductName`, `@Price`, `@Quantity`);
        
        SET `@ProductID` = @@IDENTITY;
    ELSE
		UPDATE Product
		SET 
			ProductName = COALESCE(`@ProductName`, ProductName),
			Price = COALESCE(`@Price`, Price),
			Quantity = COALESCE(`@Quantity`, Quantity)
		WHERE ProductID = `@ProductID`;
    END IF;
    
    SELECT
		p.ProductID,
        p.ProductName,
        p.Price,
        p.Quantity,
        p.CreatedDate
	FROM Product p
    WHERE p.ProductID = `@ProductID`;
END