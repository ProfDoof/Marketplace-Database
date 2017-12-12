SELECT 
    STOR.StoreName, 
    STOR.Location,
    ITEM.ItemName,
    ROUND((ITEM.Cost + (ITEM.Cost * STOR.MarketDiff * .01) ), 2)  AS MarketPrice,
    ROUND((ITEM.Cost + (ITEM.Cost * STOR.HaggleDiff * .01) ), 2) AS LowestPrice
FROM 
	STOR INNER JOIN INVY ON (STOR.StoreID = INVY.StoreID) 
		 INNER JOIN ITEM ON (INVY.ItemID = ITEM.ItemID)
WHERE
	ITEM.ItemName IN ('Ale','Bread, loaf') AND
    STOR.Location IN ('Ebberon')
ORDER BY
	STOR.HaggleDiff, STOR.MarketDiff, ITEM.ItemName;