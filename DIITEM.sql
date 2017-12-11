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