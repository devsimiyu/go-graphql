CREATE TABLE `Order` (
    OrderID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    PersonID INT NOT NULL,
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID),
    CreatedDate TIMESTAMP DEFAULT NOW(),
    `Status` ENUM('Pending','Confirmed','Complete','Rejected')
)