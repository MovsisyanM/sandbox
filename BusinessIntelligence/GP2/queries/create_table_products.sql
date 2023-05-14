CREATE TABLE {db}.{schema}.Products (
	[ProductID] INT PRIMARY KEY
	,[ProductName] VARCHAR(100)
	,[SupplierID] INT
	,[CategoryID] INT
	,[QuantityPerUnit] VARCHAR(100)
	,[UnitPrice] FLOAT(38)
	,[UnitsInStock] INT
	,[UnitsOnOrder] INT
	,[ReorderLevel] INT
	,[Discontinued] VARCHAR(15)
    ,CONSTRAINT FK_Categories_CategoryID FOREIGN KEY (CategoryID) REFERENCES {db}.{schema}.Categories (CategoryID)
	,CONSTRAINT FK_Suppliers_SupplierID FOREIGN KEY (SupplierID) REFERENCES {db}.{schema}.Suppliers (SupplierID));