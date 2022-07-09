CREATE  PROCEDURE `PersonGet`(
	`@PersonID` INT,
	`@PhoneNumber` VARCHAR(56)
)
BEGIN
	SELECT
		PersonID,
        DisplayName,
        PhoneNumber,
        CreatedDate,
        IsActive
	FROM Person
    WHERE PersonID = `@PersonID`
    OR PhoneNumber = `@PhoneNumber`
    LIMIT 1;
END