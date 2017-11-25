-- Table Creation - Spell Table

CREATE TABLE `worldwide_market`.`spell` (
  `SpellID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Description` VARCHAR(200) NULL,
  `School` VARCHAR(15) NULL,
  `Effect` VARCHAR(15) NULL,
  `Components` VARCHAR(45) NULL,
  `Range` INT NULL,
  `Level` INT NULL,
  PRIMARY KEY (`SpellID`))
COMMENT = 'Stores various spells and their effects.';