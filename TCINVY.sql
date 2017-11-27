CREATE TABLE `worldwide_market`.`invy` (
  `StoreID` INT NOT NULL,
  `ItemID` INT NOT NULL,
  `QuanInStore` INT NOT NULL,
  `QuanOnOrder` INT NOT NULL,
  PRIMARY KEY (`StoreID`, `ItemID`))
COMMENT = 'The current stock of a particular item at a particular store';