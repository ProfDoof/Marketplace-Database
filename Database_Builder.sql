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
  `ItemDescription` VARCHAR(510) NOT NULL,
  `Cost` DECIMAL(38,2) NOT NULL,
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
        ROUND((ITEM.Cost + (ITEM.Cost * STOR.MarketDiff * .01) ), 2)  AS MarketPrice,
        ROUND((ITEM.Cost + (ITEM.Cost * STOR.HaggleDiff * .01) ), 2) AS LowestPrice,
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
	('MU','Munitions'),
    ('LA','Light Armor'),
    ('MA','Medium Armor'),
    ('HA','Heavy Armor'),
    ('SH','Shield'),
    ('SW','Simple Weapon'),
    ('MW','Martial Weapon'),
    ('FO','Food'),
    ('DR','Drink'),
    ('SI','Spell Item'),
    ('BI','Basic Item');   

-- Data Insertion Spell Table

INSERT INTO SPEL(SpellName, SpellDesc, School, Effect, Components, SPEL.Range, SPEL.Level) VALUES
    ('Acid Splash', 'You may hurl an orb of acid at one target creature or two standing within 5 feet of each other. The orb deals 1d6 acid damage and increases by 1d6 at 5th, 11th, and 17th level.', 'CO', '1d6 Acid Damage', 'VS', 60, 0),
    ('Blade Ward', 'You trace a sigil of warding in the air over yourself. Until the end of your next turn you have resistance to slashing, bludgeoning, and piercing attacks dealt by weapons.', 'AB', 'Grants resistance against physical attacks.', 'VS', 0, 0),
    ('Chill Touch', 'Create a ghostly, skeletal hand and make a ranged spell attack against a target creature. On a hit the creature takes 1d8 necrotic damage and cannot regain HP until the start of your next turn. If the target is undead, they also have disadvantage when attacking you until the end of your next turn. The damage inflicted increased by 1d8 at 5th, 11th, and 17th level.', 'NE', 'Deal 1d8 necrotic damage and prevent healing on target.', 'VS', 120, 0),
    ('Create Bonfire', 'Creates a small bonfire at a location within range. Creatures standing where the bonfire is made must perform a DEX saving throw or take 1d8 fire damage. This damage is raised by 1d8 at 5th, 11th, and 17th level.', 'CO', 'Create a bonfire at a target location within range.', 'VS', 60, 0),
    ('Dancing Lights', 'Create four small floating lights that can be combined into one vaguely humanoid figure. Each light shines for a 10 foot radius. The lights can be moved up to 60 feet at will, but must remain within 20 feet of each other and will disappear if they exit the spell\'s range.', 'EV', 'Create four small floating lights that shed dim light in a 10 foot radius.', 'VSM', 120, 0),
    ('Eldritch Blast', 'You create a crackling beam of energy that flies toward a target. On a hit, they take 1d10 force damage. You generate an additional beam at 5th, 11th, and 17th level. The extra beams can be directed at the same target or up to 3 more targets. Make a separate attack roll for each beam.', 'EV', 'Make a ranged spell attack against a target. On a hit, the target takes 1d10 force damage.', 'VS', 120, 0),
    ('Firebolt', 'Hurl a flaming mote of energy at a target. On a hit they take 1d10 fire damage. Also ignites unattended flammable objects. This spell gains an additional 1d10 damage at 5th, 11th, and 17th level.', 'EV', 'Make a ranged spell attack. On a hit your target takes 1d10 fire damage. Ignites unattended flammable objects.', 'VS', 120, 0),
    ('Friends', 'For the duration of this spell, you have advantage on all charisma checks directed at one target creature of your choice that is not hostile towards you. After the spell ends, the creature will know that you used magic to influence it and will react according to DM discretion.', 'EN', 'Gain advantage on CHR checks vs one target', 'SM', 0,0),
    ('Guidance', 'You touch one willing creature and impart magical guidance on their next action. Once before the spell ends, the target may roll a d4 and add the result to an ability check of their choice. Once used, the spell ends.', 'DI', 'Add 1d4 to ability check of your target\'s choice.', 'VS', 0, 0),
    ('Light', 'You touch one object that is less than 10 feet in any dimension. For one hour, the object sheds bright light in a 20 foot radius, and dim light in a further 20 foot radius.', 'EV', 'An object you touch sheds light for 40 foot for one hour.', 'VM', 0, 0),
    ('Mage Hand', 'Creates a spectral hand with a range of 30 feet that will stay for up to 1 minute. You can use your action to control the hand to do simple tasks, but it can only lift 10 pounds and cannot attack or use magic items.', 'CO', 'Creates a floating hand to do simple tasks for you.', 'VS', 30, 0),
    ('Mending', 'You touch one target object, the spell will repair one break or tear in it, such as a broken chain link, a torn cloak, or a broken key. As long as the break is no longer than 1 foot across, the object will be as good as new. While this spell can fix magic items, if the itme lost its magic from being broken, this will not return it.', 'TR', 'Fix a less than 1 foot break in an object.', 'VSM', 0,0),
    ('Message', 'You point at a target creature within range and whipser a message. The creature will hear it telepathically and may whisper a response only you will hear. If you are familiar with the target and know their location, you may cast this spell through 1 foot thin barriers, but it is blocked by magical silence.', 'TR', 'Send a telepathic message to a target creature.', 'VSM', 120,0),
    ('Minor Illusion', 'Creates a small sustained illusion at a target area within range. This can be anything in the user\'s imagination as long as it is not larger than a 5 foot cube. Sounds can be sustained or delayed and as quiet as a whisper, or loud as a tiger\'s roar.', 'IL', 'Creates a small illusion at a target area.', 'SM', 30,0),
    ('Spare the Dying', 'You touch one target creature with less than 0 HP. That creatures stabilizes immediately.', 'NE', 'Stabilize one creature.', 'VS', 0, 0),
    ('Alarm', 'You set an alarm against unwanted intrustion. Choose an area within range that is no larger than a 20 foot cube. Until the spells ends, any tiny or larger creature that enters the space will set off the alarm. You can designate creatures that won\'t set it off when you cast the spell. The alarm can be a ping or a bell. The ping sounds in your mind only and will awaken you from sleep. The bell is audible out to 60 feet for 10 seconds.', 'AB', 'Sets an alarm in a 20 foot area.', 'VSM', 30, 1),
    ('Animal Friendship', 'You magically convince one creature that you mean it no harm. Select a target beast within range. If the creature has an intelligence of 4 or higher then the spell will fail. Otherwise, the beast must succeed on a WIS saving throw or be charmed by you for the 24 hours. If you or an ally attack the beast, then the spell will end.', 'EN', 'Charm target creature that has less than 4 INT.', 'VSM', 30,1),
    ('Burning Hands', 'You put your hands together and a gout of flames bursts forth in a 15 foot cone in front of you. All creatures caught in it must make a DEX saving throw or take 3d6 damage on a failed save, or half on a passed save.', 'EV', '3d6 Fire Damage in 15 ft cone', 'VS', 15, 1),
    ('Cause Fear', 'You awaken a sense of mortality in one target creature within range. This does not work on constructs or undead. The target must make a WIS saving throw or become frightened of you for one minute.', 'NE', 'Inflict one target with the Frightened status', 'V', 60, 1),
    ('Color Spray', 'You unleash a spray of bright colors in a 15 foot cone. Roll 6d10s and compare the total to the HP of all affected enemies. Start with the lowest HP enemy and if your rolls exceed their HP, then they are blinded. Subtract their HP from your roll total and move on to the next highest HP enemy. Repeat until your roll pool is empty.', 'IL', 'Roll 6d10s, blind all enemies with less HP than the total.', 'VSM', 15, 1),
    ('Comprehend Languages', 'For one hour you understand the literal meaning of all written and spoken languages. You must be touching the surface upon which words are written to read them. It takes one minute to read a page of text. Does not decode secret messages and does not read magic sigils.', 'DI', 'Understand literal meaning of all languages.', 'VSM', 0,1),
    ('Create or Destroy Water', 'You can create or destroy up to 10 gallons of water. Alternatively you can cause it to fall as rain in a 30 foot cube or you can destroy fog in a 30 foot cube.', 'TR', 'Create or destroy up to 10 gallons of water.', 'VSM', 30,1),
    ('Entangle', 'You cause constricting vines and weeds to spring from the ground in a 20 foot square starting from a point within range. For 1 minute, the terrain becomes difficult terrain. Creatures within the area of affect must succeed on a STR save or be restrained by the plants until the spell ends. On their turn, the creature may make a STR save against your spell save DC to escape the vines.', 'TR', 'Create difficult terrain in a 20 foot square.', 'VS', 90,1),
    ('Magic Missile', 'You create three glowing darts of energy and direct them towards up to three targets within range. The darts will automatically hit and cannot be dodged, dealing 1d4+1 damage.', 'EV', 'Attack up to three creatures with 1d4+1 damage or one creature three times. Cannot miss.', 'VS', 120,1),
    ('Aid', 'Bolster your allies with toughness and resolve. Choose up to three creatures within 30 feet. Each target gains +5 to their current and maximum HP.', 'AB', 'Add 5 to the max and current HP of three allies.', 'VSM', 30,2),
    ('Animal Messenger', 'Direct a nearby tiny creature to deliver a message for you. You specify a location, a general description of the recipient, and the message you want delivered. The message may only be up to 25 words in length. The sent creature may travel 50 miles if it can fly or 25 if it must walk. When the creature arrives, it will speak in your voice and deliver your message.', 'EN', 'Direct a tiny creature to deliver a message for you.', 'VSM', 30,2),
    ('Barksin', 'You touch one willing creature. For 1 hour, their skin hardens like bark and their AC cannot be less than 16 regardless of what armor they wear.', 'TR', 'Harden the skin of one willing creature, setting their minimum AC to 16', 'VSM', 0,2),
    ('Blindness/Deafness', 'You blind or deafen one foe within 30 feet. Choose one creature within range, they must make a CON saving throw or suffer your choice of either blindness or deafness. At the end of each of their turns, the target may attempt a new saving throw to end the effect.', 'NE', 'Blind or deafen one nearby target.', 'V', 30,2),
    ('Blur', 'Your body becomes blurred causing all enemies who attempt to attack you to have disadvantage. Enemies are not affected by this if they do not rely upon sight when attacking.', 'IL', 'Impose disadvantage on attackers who rely on sight.', 'V', 0,2),
    ('Branding Smite', 'The next time you deliver a weapon attack after casting this spell, your weapon will gleam with astral radiance. Your attack will deal 2d6 extra radiant damage, dispel invisibility, and force the enemy to shed dim light in a 5 foot radius.', 'EV', '2d6 extra radiant damage, dispel invisibility.', 'V', 0,2),
    ('Cloud of Daggers', 'You fill the air with spinning daggers in a 5 foot cube. Any creature that enters this radius takes 4d4 slashing damage upon entering or beginning their turn within the cloud of daggers.', 'CO', 'Creature a 5 foot cube of spinning daggers that deals 4d4 damage to any creature that stands within the radius.', 'VSM', 60,2),
    ('Find Traps', 'You sense the presence of any trap within range within line of sight. A trap is defined as anything that would cause you harm or inflict a unexpected effect. You learn that traps are present, but not their exact location.', 'DI', 'Reveal the presence of nearby traps within line of sight.', 'VS', 120,2),
    ('Web', 'You conjure a mass of thick, sticky webbing, filling up a 20 foot cube with webs. Any creature that begins their turn in the webs or enters them must make a DEX saving throw or become entangled.', 'CO', 'Creature a 20 foot mass of webs. Entangle creatures standing in them.', 'VSM', 60,2);  

-- Data Insertion Store Table

INSERT INTO STOR(StoreName, StoreType, Location, MarketDiff, HaggleDiff) VALUES
	('The Fatted Cafe', 'I', 'Ebberon', 25, 15),
    ('The Silken Cloak', 'T', 'Ebberon', 50, 5),
    ('The Piggly Wiggly', 'G', 'Ebberon', 5, -10),
    ('The Sword and Shield', 'W', 'Ebberon', 75, 25),
    ('The Scale-mail Chicken', 'A', 'Ebberon', 5, 0),
    ('The Mapping Scribe', 'S', 'Ebberon', 9, 7);
    
-- Data Insertion Item Table

INSERT INTO ITEM(ItemName, ItemType, ItemDescription, Cost) VALUES
  	('Padded Armor','LA','Padded Armor consists of quilted layers of cloth and batting, it has an AC of 11 + Dex modifier, has a stealth disadvantage, and weighs 8 lbs', 5),
    ('Hide Armor','MA','This crude armor consists of thick furs and pelts. It is commonly worn by barbarian tribes, evil humanoids, and other folk who lack access to the tools and materials needed to create better armor. It has an AC of 12 plus the Dex modifier(max of 2), and weighs 12 lbs', 10),
    ('Plate Mail','HA','Plate mail consists of shaped, interlocking metal plates to cover the entire body. A suit of plate includes gauntlets, heavy leather boots, a visored helmet, and thick layers of padding underneath the armor. Buckles and straps distribute the weight over the body. It has an AC of 18,requires 15 strength, causes disadvantage on stealth, and weighs 65 pounds.', 1500),
    ('Shield','SH','A shield is defensive device worn on your arm used to redirect attacks and to block them. They increase your AC by 2, and weigh 6 lbs.', 10),
    ('Dagger','SW','A dagger is a small weapon easily concealed and best used in assasination style fights rather than heavy battle. It does 1d4 piercing damage, weighs 1 lb, and has the properties finesse, light, thrown(range 20/60)', 2),
    ('Pike','MW','Pikes are mainly used by armies and guardsmen as they allow you to keep the enemy at a distance during battle opening you up to fewer injuries. They do 1d10 piercing damage, weighs 18 lbs, and have the properties heavy, reach, and two-handed.', 5),
    ('Ale','DR','A favorite drink to get at almost any inn, be careful as when you drink too much of this the only person thanking you are your enemies.', .04),
    ('Bread, loaf','FO','A cheap commodity you can get at almost any inn, it is filling and will certainly help cut the edge on your hunger.', .04),
    ('Candle','BI','For 1 hour, a candle sheds bright light in a 5-foot radius and dim light for an additional 5 feet', .01),
    ('Wand','SI','A magic item about 15 inches long made out of some kind of strange metal. It uses the spell in the next column. It has a specified number of charges that can be found in the DMG.', 500),
    ('Arrows(20)','MU','These are fired from your bow to cause damage. Without these your bow is nothing more than a glorified walking stick. These arrows weigh about 1 lb.', 1);
    
-- Data Insertion Inventory Table

INSERT INTO INVY(StoreID, ItemID, QuanInStore, QuanOnOrder) Values
  	(2,1,5,2),
    (2,2,1,1),
    (5,3,1,0),
    (5,4,5,5),
    (4,5,10,10),
    (4,6,3,2),
    (1,7,30,60),
    (1,8,30,30),
    (3,7,30,60),
    (3,8,30,30),
    (3,9,10,10),
    (3,11,10,10);