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
  `Cost` INT NOT NULL,
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
  `SpellID` INT NOT NULL AUTO_INCREMENT,
  `SpellName` VARCHAR(45) NOT NULL,
  `SpellDesc` VARCHAR(510) NOT NULL,
  `School` VARCHAR(15) NOT NULL,
  `Effect` VARCHAR(255) NOT NULL,
  `Components` VARCHAR(45) NULL,
  `Range` INT NOT NULL,
  `Level` INT NOT NULL,
  PRIMARY KEY (`SpellID`))
COMMENT = 'Stores various spells and their effects.';

CREATE TABLE `worldwide_market`.`spvt` (
  `SchoolType` VARCHAR(8) NOT NULL,
  `SchoolDescription` VARCHAR(45) NOT NULL,
PRIMARY KEY (`SchoolType`));

-- Referential Integrity Constraints

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

-- Database Selection

USE worldwide_market;

-- View Creation

CREATE VIEW `Stores` AS
    SELECT 
        STOR.StoreID,
        STOR.StoreName,
        STVT.TypeDescription,
        STOR.Location,
        STOR.MarketDiff,
        STOR.HaggleDiff
    FROM
        STOR INNER JOIN STVT ON STOR.StoreType = STVT.StoreType;

CREATE VIEW `Items` AS
    SELECT 
        ITEM.ItemName, 
        ITVT.ItemDescription AS ItemType, 
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
        ITEM INNER JOIN INVY ON (ITEM.ItemID = INVY.ItemID) INNER JOIN STOR ON STOR.StoreID = INVY.StoreID;

CREATE VIEW `MagicItems` AS
    SELECT
        (ITEM.ItemName + MITM.ArtifactName) AS MagicItemName,
        SPEL.SpellName,
        ITEM.ItemDescription,
        SPEL.SpellDesc,
        SPEL.Effect,
        SPEL.Range,
        SPEL.Level,
        ITEM.Cost
    FROM
        ITEM INNER JOIN MITM ON (ITEM.ItemID = MITM.ItemID) INNER JOIN SPEL ON SPEL.SpellID = MITM.SpellID;
        
CREATE VIEW `Spells` AS
	SELECT
		SPEL.SpellName,
        SPEL.SpellDesc,
        SPVT.SchoolDescription,
        SPEL.Effect,
        SPEL.Components,
        SPEL.Range,
        SPEL.Level
    FROM
		SPEL INNER JOIN SPVT ON (SPEL.School = SPVT.SchoolType);
        
-- Data Insertion

-- Data Insertion Spell Table

INSERT INTO SPVT(SchoolType, SchoolDescription) VALUES
	('AB', 'Abjuration'),
    ('CO', 'Conjuration'),
    ('DI', 'Divination'),
    ('EN', 'Enchantment'),
    ('EV', 'Evocation'),
    ('IL', 'Illusion'),
    ('NE', 'Necromancy'),
    ('TR', 'Transmutation'),
    ('UN', 'Universal');

-- Data Insertion Store Type Validation Table

INSERT INTO STVT(StoreType, TypeDescription) VALUES
	('I', 'Inn'),
    ('T', 'Tailor'),
	('G', 'General Store'),
    ('W', 'Weaponsmith'),
    ('A', 'Armorer'),
    ('S', 'Scribe');
 
 -- Data Insertion Item Validation Table
 
INSERT INTO ITVT(ItemType, ItemDescription) VALUES
	('M','Munitions'),
    ('A','Armor'),
    ('W','Weapon'),
    ('F','Food'),
    ('D','Drink'),
    ('S','Spell Item'),
    ('B','Basic Item');    

-- Data Insertion Spell Table

INSERT INTO SPEL(SpellName, SpellDesc, School, Effect, Components, SPEL.Range, SPEL.Level) VALUES
	('Acid Splash', 'You may hurl an orb of acid at one target creature or two standing within 5 feet of each other. The orb deals 1d6 acid damage and increases by 1d6 at 5th, 11th, and 17th level.', 'CO', '1d6 Acid Damage', 'VS', 60, 0),
	('Blade Ward', 'You trace a sigil of warding in the air over yourself. Until the end of your next turn you have resistance to slashing, bludgeoning, and piercing attacks dealt by weapons.', 'AB', 'Grants resistance against physical attacks.', 'VS', 0, 0),
    ('Chill Touch', 'Create a ghostly, skeletal hand and make a ranged spell attack against a target creature. On a hit the creature takes 1d8 necrotic damage and cannot regain HP until the start of your next turn. If the target is undead, they also have disadvantage when attacking you until the end of your next turn. The damage inflicted increased by 1d8 at 5th, 11th, and 17th level.', 'NE', 'Deal 1d8 necrotic damage and prevent healing on target.', 'VS', 120, 0),
    ('Create Bonfire', 'Creates a small bonfire at a location within range. Creatures standing where the bonfire is made must perform a DEX saving throw or take 1d8 fire damage. This damage is raised by 1d8 at 5th, 11th, and 17th level.', 'CO', 'Create a bonfire at a target location within range.', 'VS', 60, 0),
    ('Dancing Lights', 'Create four small floating lights that can be combined into one vaguely humanoid figure. Each light shines for a 10 foot radius. The lights can be moved up to 60 feet at will, but must remain within 20 feet of each other and will disappear if they exit the spell\'s range.', 'EV', 'Create four small floating lights that shed dim light in a 10 foot radius.', 'VSM', 120, 0),
    ('Eldritch Blast', 'You create a crackling beam of energy that flies toward a target. On a hit, they take 1d10 force damage. You generate an additional beam at 5th, 11th, and 17th level. The extra beams can be directed at the same target or up to 3 more targets. Make a separate attack roll for each beam.', 'EV', 'Make a ranged spell attack against a target. On a hit, the target takes 1d10 force damage.', 'VS', 120, 0),
    ('Firebolt', 'Hurl a flaming mote of energy at a target. On a hit they take 1d10 fire damage. Also ignited unattended flammable objects. This spell gains an additional 1d10 damage at 5th, 11th, and 17th level.', 'EV', 'Make a ranged spell attack. On a hit your target takes 1d10 fire damage. Ignites unattended flammable objects.', 'VS', 120, 0);

-- Data Insertion Store Table

INSERT INTO STOR(StoreName, StoreType, Location, MarketDiff, HaggleDiff) VALUES
	('The Fatted Cafe', 'I', 'Ebberon', 0, 0),
    ('The Silken Cloak', 'T', 'Ebberon', 0, 0),
    ('The Piggly Wiggly', 'G', 'Ebberon', 0, 0),
    ('The Sword and Shield', 'W', 'Ebberon', 0, 0),
    ('The Scale-mail Chicken', 'A', 'Ebberon', 0, 0),
    ('The Mapping Scribe', 'S', 'Ebberon', 0, 0);