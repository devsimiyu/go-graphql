CREATE PROCEDURE `ProductListGet`(
	`@activeProduct` BOOLEAN,
    `@pageNumber` INT,
    `@recordCount` INT,
    `@skipRecords` INT
)
BEGIN
	IF `@recordCount` IS NULL
    THEN
		SET `@recordCount` = 10;
    END IF;
    
    IF `@pageNumber` IS NULL
    THEN 
		SET `@pageNumber` = 0;
	END IF;
    
    SET `@skipRecords` = `@recordCount` * `@pageNumber`;
    
	SELECT 
		p.ProductID,
        p.ProductName,
        p.Price,
        p.Quantity,
        p.CreatedDate
	FROM Product p 
    WHERE 1 = CASE
		WHEN `@activeProduct` IS NULL OR `@activeProduct` = '' OR `@activeProduct` = 0 THEN 1
		WHEN `@activeProduct` = TRUE AND p.Quantity > 0 THEN 1
	END
	LIMIT `@recordCount`
	OFFSET `@skipRecords`;
END