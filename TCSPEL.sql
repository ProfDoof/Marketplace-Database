-- Table Creation - Spell Table

CREATE TABLE `worldwide_market`.`spell` (
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