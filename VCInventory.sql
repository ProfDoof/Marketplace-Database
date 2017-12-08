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