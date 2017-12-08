CREATE VIEW `Items` AS
SELECT ITEM.ItemName, ITVT.ItemDescription, ITEM.ItemDescription, ITEM.Cost 
FROM ITEM, ITVT
WHERE ITEM.ItemType = ITVT.ItemType;