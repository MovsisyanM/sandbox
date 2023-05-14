CREATE TABLE {db}.{schema}.OrderDetails (
	[OrderID] INT 
	,[ProductID] INT 
	,[UnitPrice] FLOAT(38)
    ,[Quantity] INT
    ,[Discount] FLOAT(38)
    ,PRIMARY KEY (OrderID, ProductID)
    ,CONSTRAINT FK_Orders_OrderID FOREIGN KEY (OrderID) REFERENCES {db}.{schema}.Orders (OrderID)
    ,CONSTRAINT FK_Products_ProductID FOREIGN KEY (ProductID) REFERENCES {db}.{schema}.Products (ProductID));