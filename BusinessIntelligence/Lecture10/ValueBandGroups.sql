USE master;
DROP TABLE IF EXISTS AgeBands;
CREATE TABLE AgeBands (
    AgeGroup varchar(255)
    ,LowerAge INTEGER
    ,UpperAge INTEGER
);
INSERT INTO AgeBands VALUES 
			('Infant', 0, 4)
            ,('Elementary', 5, 13)
            ,('HighSchool', 14, 17);
GO

SELECT * FROM AgeBands;
GO

USE master;
DROP TABLE IF EXISTS Children;
CREATE TABLE Children (
    FirstName varchar(255)
    ,Age INTEGER
);
GO

USE master;
INSERT INTO Children VALUES 
			('Armen', 1)
            ,('Petros', 2)
            ,('Suren', 6)
            ,('Narek', 15);
GO

SELECT * FROM AgeBands;
GO
SELECT * FROM Children;
GO


USE master;
SELECT 
		FirstName
		,Age
		,AgeGroup
FROM Children AS table1
LEFT JOIN  AgeBands as table2
	ON  (table1.Age >= table2.LowerAge) 
	AND (table1.Age < table2.UpperAge);
GO
