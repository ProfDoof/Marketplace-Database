-- Database Creation

-- Schema Creation

CREATE SCHEMA `worldwide_market` ;

-- Table Creation

CREATE TABLE `worldwide_market`.`stor` (
  `StoreID` INT NOT NULL AUTO_INCREMENT,
  `StoreName` VARCHAR(45) NOT NULL,
  `StoreType` VARCHAR(45) NOT NULL,
  `Location` VARCHAR(45) NOT NULL,
  `MarketDiff` INT NOT NULL,
  `HaggleDiff` INT NOT NULL,
  PRIMARY KEY (`StoreID`))
COMMENT = ' Designed to hold the store names and types among the worldwide marketplace ';

CREATE TABLE `worldwide_market`.`stvt` (
  `StoreType` VARCHAR(45) NOT NULL,
  `TypeDescription` VARCHAR(45) NULL,
  PRIMARY KEY (`StoreType`))
COMMENT = ' Designed to hold the store types codes and a description of each code.';

CREATE TABLE `worldwide_market`.`item` (
  `ItemID` INT NOT NULL AUTO_INCREMENT,
  `ItemName` VARCHAR(45) NOT NULL,
  `ItemType` VARCHAR(45) NOT NULL,
  `ItemDescription` VARCHAR(45) NOT NULL,
  `Cost` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ItemID`))
COMMENT = ' This Stores all items that will be used by the stores ';

CREATE TABLE `worldwide_market`.`invy` (
  `StoreID` INT NOT NULL,
  `ItemID` INT NOT NULL,
  `QuanInStore` INT NOT NULL,
  `QuanOnOrder` INT NOT NULL,
  PRIMARY KEY (`StoreID`, `ItemID`))
COMMENT = 'The current stock of a particular item at a particular store';

CREATE TABLE `worldwide_market`.`mitm` (
  `ItemID` INT NOT NULL,
  `SpellID` INT NOT NULL,
  `ArtifactName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ItemID`, `SpellID`))
COMMENT = 'Stores items that have magical properties or are enhanced in some way.';

CREATE TABLE `worldwide_market`.`itvt` (
  `ItemType` VARCHAR(8) NOT NULL,
  `ItemDescription` LONGTEXT NOT NULL,
PRIMARY KEY (`ItemType`));

CREATE TABLE `worldwide_market`.`spel` (
  `SpellID` INT NOT NULL,
  `SpellName` VARCHAR(45) NOT NULL,
  `SpellDesc` VARCHAR(200) NOT NULL,
  `School` VARCHAR(15) NOT NULL,
  `Effect` VARCHAR(15) NOT NULL,
  `Components` VARCHAR(45) NULL,
  `Range` INT NOT NULL,
  `Level` INT NOT NULL,
  PRIMARY KEY (`SpellID`))
COMMENT = 'Stores various spells and their effects.';

CREATE TABLE `worldwide_market`.`spvt` (
  `SchoolType` VARCHAR(8) NOT NULL,
  `SchoolDescription` VARCHAR(45) NOT NULL,
PRIMARY KEY (`SchoolType`));

ALTER TABLE `worldwide_market`.`item` 
ADD INDEX `ItemType_idx` (`ItemType` ASC);
ALTER TABLE `worldwide_market`.`item` 
ADD CONSTRAINT `ItemType`
  FOREIGN KEY (`ItemType`)
  REFERENCES `worldwide_market`.`itvt` (`ItemType`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `worldwide_market`.`spel` 
ADD INDEX `SchoolType_idx` (`School` ASC);
ALTER TABLE `worldwide_market`.`spel` 
ADD CONSTRAINT `SchoolType`
  FOREIGN KEY (`School`)
  REFERENCES `worldwide_market`.`spvt` (`SchoolType`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `worldwide_market`.`stor` 
ADD INDEX `StoreType_idx` (`StoreType` ASC);
ALTER TABLE `worldwide_market`.`stor` 
ADD CONSTRAINT `StoreType`
  FOREIGN KEY (`StoreType`)
  REFERENCES `worldwide_market`.`stvt` (`StoreType`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `worldwide_market`.`mitm` 
ADD INDEX `Item` (`ItemID` ASC),
ADD INDEX `Spell` (`SpellID` ASC);
ALTER TABLE `worldwide_market`.`mitm` 
ADD CONSTRAINT `SpellID`
  FOREIGN KEY (`SpellID`)
  REFERENCES `worldwide_market`.`spel` (`SpellID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `ItemID`
  FOREIGN KEY (`ItemID`)
  REFERENCES `worldwide_market`.`item` (`ItemID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `worldwide_market`.`invy` 
ADD INDEX `Item` (`ItemID` ASC),
ADD INDEX `Store` (`StoreID` ASC);
ALTER TABLE `worldwide_market`.`invy` 
ADD CONSTRAINT `StoreINVY`
  FOREIGN KEY (`StoreID`)
  REFERENCES `worldwide_market`.`stor` (`StoreID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
ADD CONSTRAINT `ItemINVY`
  FOREIGN KEY (`ItemID`)
  REFERENCES `worldwide_market`.`item` (`ItemID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

CREATE VIEW `Stores` AS
    SELECT 
        STOR.StoreID,
        STOR.StoreName,
        STVT.TypeDescription,
        STOR.Location,
        STOR.MarketDiff,
        STOR.HaggleDiff
    FROM
        STOR,
        STVT
    WHERE
        STOR.StoreType = STVT.StoreType

CREATE VIEW `Items` AS
    SELECT 
        ITEM.ItemName, 
        ITVT.ItemDescription, 
        ITEM.ItemDescription, 
        ITEM.Cost 
    FROM 
        ITEM, 
        ITVT
    WHERE 
        ITEM.ItemType = ITVT.ItemType;

CREATE VIEW `Inventory` AS
    SELECT 
        STOR.StoreName,
        ITEM.ItemName,
        (ITEM.Cost * STOR.MarketDiff * .01) AS MarketPrice,
        (ITEM.Cost * STOR.HaggleDiff * .01) AS LowestPrice,
        INVY.QuanInStore,
        INVY.QuanOnOrder
    FROM
        STOR,
        ITEM,
        INVY
    WHERE
        STOR.StoreID = INVY.StoreID
            AND ITEM.ItemID = INVY.ItemID;

