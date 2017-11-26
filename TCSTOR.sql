-- Table Creation - Store Table

CREATE TABLE `worldwide_market`.`store` (
  `StoreID` INT NOT NULL AUTO_INCREMENT,
  `StoreName` VARCHAR(45) NOT NULL,
  `StoreType` VARCHAR(45) NOT NULL,
  `Location` VARCHAR(45) NOT NULL,
  `%MarketDiff` INT NOT NULL,
  `%HaggleDiff` INT NOT NULL,
  PRIMARY KEY (`StoreID`))
COMMENT = ' Designed to hold the store names and types among the worldwide marketplace ';
