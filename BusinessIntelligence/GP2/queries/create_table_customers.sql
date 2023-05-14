CREATE TABLE {db}.{schema}.customers (
	[CustomerID] CHAR(100) PRIMARY KEY
	,[CompanyName] VARCHAR(150)
	,[ContactName] VARCHAR(50)
    ,[ContactTitle] VARCHAR(50)
    ,[Address] VARCHAR(50)
    ,[City] VARCHAR(50)
    ,[Region] VARCHAR(50) NULL
    ,[PostalCode] VARCHAR(50) NULL
    ,[Country] VARCHAR(100)
    ,[Phone] VARCHAR(100)
    ,[Fax] VARCHAR(100) NULL);