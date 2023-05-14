CREATE TABLE {db}.{schema}.Territories (
	[TerritoryID] INT PRIMARY KEY
	,[TerritoryDescription] VARCHAR(50)
	,[RegionID] INT
    ,CONSTRAINT FK_Regions_RegionID FOREIGN KEY (RegionID) REFERENCES {db}.{schema}.Region (RegionID));