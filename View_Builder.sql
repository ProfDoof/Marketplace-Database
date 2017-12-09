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
		SPEL.SpellName
        SPEL.SpellDesc
        SPVT.SchoolDescription
        SPEL.Effect
        SPEL.Components
        SPEL.Range
        SPEL.Level
    FROM
		SPEL INNER JOIN SPVT ON (SPEL.School = SPVT.SchoolType);