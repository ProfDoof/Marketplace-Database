-- Table Creation - Item Table

CREATE TABLE `worldwide_market`.`item` (
  `ItemID` INT NOT NULL AUTO_INCREMENT,
  `ItemName` VARCHAR(45) NOT NULL,
  `ItemDescription` VARCHAR(45) NOT NULL,
  `Cost` VARCHAR(45) NULL,
  `ItemType` VARCHAR(45) NULL,
  PRIMARY KEY (`ItemID`))
COMMENT = ' This Stores all items that will be used by the stores ';