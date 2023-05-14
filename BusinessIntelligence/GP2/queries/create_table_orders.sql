CREATE TABLE {db}.{schema}.Orders (
	[OrderID] INT PRIMARY KEY
	,[CustomerID] CHAR(100)
	,[EmployeeID] INT
	,[OrderDate] DATE
	,[RequiredDate] DATE
	,[ShippedDate] DATE NULL
	,[ShipVia] INT
	,[Freight] FLOAT(38)
	,[ShipName] VARCHAR(100)
	,[ShipAddress] VARCHAR(100)
	,[ShipCity] VARCHAR(50)
	,[ShipRegion] VARCHAR(50) NULL
	,[ShipPostalCode] VARCHAR(50)
	,[ShipCountry] VARCHAR(50)
	,[TerritoryID] INT
    ,CONSTRAINT FK_Customers_CustomerID FOREIGN KEY (CustomerID) REFERENCES {db}.{schema}.Customers (CustomerID)
    ,CONSTRAINT FK_Employees_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES {db}.{schema}.Employees (EmployeeID)
    ,CONSTRAINT FK_Shippers_ShipVia FOREIGN KEY (ShipVia) REFERENCES {db}.{schema}.Shippers (ShipperID)
    ,CONSTRAINT FK_Territories_TerritoryID FOREIGN KEY (TerritoryID) REFERENCES {db}.{schema}.Territories (TerritoryID));