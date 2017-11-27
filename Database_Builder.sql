-- Database Creation

-- Schema Creation

CREATE SCHEMA `worldwide_market` ;

-- Table Creation

CREATE TABLE `worldwide_market`.`stor` (
  `StoreID` INT NOT NULL AUTO_INCREMENT,
  `StoreName` VARCHAR(45) NOT NULL,
  `StoreType` VARCHAR(45) NOT NULL,
  `Location` VARCHAR(45) NOT NULL,
  `%MarketDiff` INT NOT NULL,
  `%HaggleDiff` INT NOT NULL,
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

