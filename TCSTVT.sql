-- Table Creation - Store Type Validation Table

CREATE TABLE `worldwide_market`.`valstore` (
  `StoreType` VARCHAR(45) NOT NULL,
  `TypeDescription` VARCHAR(45) NULL,
  PRIMARY KEY (`StoreType`))
COMMENT = ' Designed to hold the store types codes and a description of each code.';
