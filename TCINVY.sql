CREATE TABLE `worldwide_market`.`inventory` (
  `StoreID` INT NOT NULL,
  `ItemID` INT NOT NULL,
  `QuantityInStore` INT NULL,
  `QuantityOnOrder` INT NULL,
  PRIMARY KEY (`StoreID`, `ItemID`))
COMMENT = 'The current stock of a store';