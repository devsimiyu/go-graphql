CREATE PROCEDURE `PersonSave`(
	PersonID INT,
    DisplayName VARCHAR(256),
    PhoneNumber VARCHAR(256),
    IsActive BOOLEAN
)
BEGIN
	IF PersonID IS NULL OR PersonID = '' OR PersonID = 0
    THEN
		INSERT INTO Person(DisplayName, PhoneNumber, IsActive)
        VALUES (DisplayName, PhoneNumber, IsActive);
        
        SET PersonID = @@IDENTITY;
    ELSE
		UPDATE Product
		SET 
			DisplayName = COALESCE(DisplayName, DisplayName),
			PhoneNumber = COALESCE(PhoneNumber, PhoneNumber),
			IsActive = COALESCE(IsActive, IsActive);
    END IF;
    
    SELECT
		p.PersonID,
        p.DisplayName,
        p.PhoneNumber,
        p.IsActive,
        p.CreatedDate
	FROM Person p
    WHERE p.PersonID = PersonID;
END