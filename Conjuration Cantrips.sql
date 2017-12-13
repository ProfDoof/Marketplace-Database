SELECT 
	SPEL.SpellName, 
    SPEL.SpellDesc, 
    SPEL.Effect, 
    SPEL.Components, 
    SPEL.Range, 
    SPEL.Level
FROM 
	SPEL
WHERE
	SPEL.School = 'CO' AND
    SPEL.Level = 0;