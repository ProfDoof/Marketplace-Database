CREATE VIEW `Stores` AS
    SELECT 
        STOR.StoreID,
        STOR.StoreName,
        STVT.TypeDescription,
        STOR.Location,
        STOR.MarketDiff,
        STOR.HaggleDiff
    FROM
        STOR,
        STVT
    WHERE
        STOR.StoreType = STVT.StoreType