CREATE TABLE {db}.{schema}.Suppliers (
	[SupplierID] INT PRIMARY KEY
	,[CompanyName] VARCHAR(100)
	,[ContactName] VARCHAR(100)
	,[ContactTitle] VARCHAR(100)
	,[Address] VARCHAR(100)
	,[City] VARCHAR(50)
	,[Region] VARCHAR(50) NULL
	,[PostalCode] VARCHAR(50)
	,[Country] VARCHAR(50)
	,[Phone] VARCHAR(50)
	,[Fax] VARCHAR(50) NULL
	,[HomePage] VARCHAR(150) NULL);