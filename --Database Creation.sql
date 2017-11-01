--Database Creation

--Schema Creation

CREATE SCHEMA `worldwide_market` ;

--Table Creation

CREATE TABLE `worldwide_market`.`store` (
  `StoreID` INT NOT NULL AUTO_INCREMENT,
  `StoreName` VARCHAR(45) NULL,
  `StoreType` VARCHAR(45) NULL,
  PRIMARY KEY (`StoreID`))
COMMENT = 'Designed to hold the store names and types among the worldwide marketplace';

CREATE TABLE `worldwide_market`.`valstore` (
  `StoreType` VARCHAR(45) NOT NULL,
  `TypeDescription` VARCHAR(45) NULL,
  PRIMARY KEY (`StoreType`));

CREATE TABLE `worldwide_market`.`item` (
  `ItemID` INT NOT NULL AUTO_INCREMENT,
  `ItemName` VARCHAR(45) NOT NULL,
  `ItemDescription` VARCHAR(45) NOT NULL,
  `Cost` VARCHAR(45) NULL,
  `ItemType` VARCHAR(45) NULL,
  PRIMARY KEY (`ItemID`))
COMMENT = 'This Stores all items that will be used by the stores';

--Insertion Section

--Insert into Store Table

INSERT INTO STORE VALUES(
	null, 'The Fatted Cafe', 'I');
INSERT INTO STORE VALUES(
	null, 'The Silken Cloak', 'T');
INSERT INTO STORE VALUES(
	null, 'The Piggly Wiggly', 'G');
INSERT INTO STORE VALUES(
	null, 'The Sword and Shield', 'W');
INSERT INTO STORE VALUES(
	null, 'The Scale-mail Chicken', 'A');
INSERT INTO STORE VALUES(
	null, 'The Mapping Scribe', 'S');

--Insert into the StoreType Validation Table

INSERT INTO VALSTORE VALUES(
	'I', 'Inn');
INSERT INTO VALSTORE VALUES(
	'T', 'Tailor');
INSERT INTO VALSTORE VALUES(
	'G', 'General Store');
INSERT INTO VALSTORE VALUES(
	'W', 'Weaponsmith');
INSERT INTO VALSTORE VALUES(
	'A', 'Armorer');
INSERT INTO VALSTORE VALUES(
	'S', 'Scribe');