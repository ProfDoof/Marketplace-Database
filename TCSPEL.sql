-- Table Creation - Spell Table

CREATE TABLE `worldwide_market`.`spell` (
  `SpellID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Description` VARCHAR(45) NULL,
  `School` VARCHAR(45) NULL,
  `Effect` VARCHAR(45) NULL,
  `Components` VARCHAR(45) NULL,
  `Range` INT NULL,
  `Level` INT NULL,
  PRIMARY KEY (`SpellID`))
COMMENT = 'Stores various spells and their effects.';