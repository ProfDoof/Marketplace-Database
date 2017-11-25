CREATE TABLE `worldwide_market`.`inventory` (
  `StoreID` INT NOT NULL,
  `ItemID` INT NOT NULL,
  `QuantityInStore` INT NOT NULL,
  `QuantityOnOrder` INT NOT NULL,
  PRIMARY KEY (`StoreID`, `ItemID`))
COMMENT = 'The current stock of a store';