DELIMITER //
CREATE PROCEDURE OrderSave (
	`@OrderID` INT,
    `@PersonID` INT,
    `@Products` VARCHAR(256),
    `@Status` enum('Pending','Confirmed','Complete','Rejected')
)
BEGIN
	IF `@OrderID` IS NULL OR `@OrderID` = ''
    THEN 
		INSERT INTO `Order`(PersonID, `Status`)
        VALUES (`@PersonID`, `@OrderID`);
        
        SET `@OrderID` = @@IDENTITY;
        
        INSERT INTO OrderProduct(OrderID, ProductID)
        SELECT `@OrderID`, ProductID
        FROM Product
        WHERE FIND_IN_SET(ProductID, `@Products`);
    ELSE
		UPDATE `Order`
        SET `Status` = `@Status`
        WHERE OrderID = `@OrderID`;
        
        IF `@Products` IS NULL OR `@Products` = ''
        THEN
			UPDATE OrderProduct
            SET IsDeleted = TRUE
            WHERE OrderID = `@OrderID`;
            
            INSERT INTO OrderProduct(OrderID, ProductID)
			SELECT `@OrderID`, ProductID
			FROM Product
			WHERE FIND_IN_SET(ProductID, `@Products`);
        END IF;
    END IF;
    
    SELECT
		o.OrderID,
        o.PersonID,
        o.CreatedDate,
        o.Status
	FROM `Order` o
    WHERE OrderID = `@OrderID`;
END//

DELIMITER ;
