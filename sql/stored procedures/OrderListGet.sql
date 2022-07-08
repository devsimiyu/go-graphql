CREATE PROCEDURE `OrderListGet`(
	`@start` VARCHAR(56),
  `@end` VARCHAR(56),
  `@status` enum('Pending','Confirmed','Complete','Rejected'),
  `@pageNumber` INT,
  `@recordCount` INT,
  `@skipRecords` INT
)
BEGIN
	IF `@start` IS NULL OR `@start` = ''
    THEN
		SET `@start` = CAST(NOW() AS DATE);
    END IF;
    
    IF `@end` IS NULL OR `@end` = ''
    THEN
		SET `@end` = CAST(NOW() AS DATE);
    END IF;
    
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
		o.OrderID,
        o.PersonID,
        o.CreatedDate,
        o.Status
	FROM `Order` o
    WHERE CAST(o.CreatedDate AS DATE) >= CAST(`@start` AS DATE) 
    AND CAST(o.CreatedDate AS DATE) <= CAST(`@end` AS DATE) 
    AND 1 = CASE
			WHEN `@status` IS NULL OR `@status` = '' THEN 1
			WHEN o.Status = `@status` THEN 1
		END
    LIMIT `@recordCount`
    OFFSET `@skipRecords`;
END