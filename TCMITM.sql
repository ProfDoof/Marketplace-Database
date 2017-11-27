-- Table Creation - Magic Item Table

CREATE TABLE `worldwide_market`.`mitm` (
  `ItemID` INT NOT NULL,
  `SpellID` INT NOT NULL,
  `ArtifactName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ItemID`, `SpellID`))
COMMENT = 'Stores items that have magical properties or are enhanced in some way.';
