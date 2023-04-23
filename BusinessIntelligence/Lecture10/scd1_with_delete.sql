USE week10;
GO

DROP TABLE IF EXISTS Products;
GO

CREATE TABLE Products
(
   ProductID INT PRIMARY KEY,
   ProductName VARCHAR(100),
   Rate MONEY
) 
GO

DROP TABLE IF EXISTS Dim_Products_SCD1;
GO
CREATE TABLE Dim_Products_SCD1
(
   ProductID_SK INT PRIMARY KEY IDENTITY(1,1),
   ProductID_NK INT,
   ProductName VARCHAR(100),
   Rate MONEY
) 
GO

DROP PROCEDURE dbo.product_SCD1_ETL;
GO

CREATE PROCEDURE dbo.product_SCD1_ETL
AS
BEGIN TRY
MERGE Dim_Products_SCD1 AS TARGET
USING Products AS SOURCE 
ON (TARGET.ProductID_NK = SOURCE.ProductID) 
--When records are matched, update the records if there is any change
WHEN MATCHED AND TARGET.ProductName <> SOURCE.ProductName OR TARGET.Rate <> SOURCE.Rate 
THEN UPDATE SET TARGET.ProductName = SOURCE.ProductName, TARGET.Rate = SOURCE.Rate 
--When no records are matched, insert the incoming records from source table to target table
WHEN NOT MATCHED BY TARGET 
THEN INSERT (ProductID_NK, ProductName, Rate) VALUES (SOURCE.ProductID, SOURCE.ProductName, SOURCE.Rate)
--When there is a row that exists in target and same record does not exist in source then delete this record target
WHEN NOT MATCHED BY SOURCE 
THEN DELETE 
--$action specifies a column of type nvarchar(10) in the OUTPUT clause that returns 
--one of three values for each row: 'INSERT', 'UPDATE', or 'DELETE' according to the action that was performed on that row
OUTPUT $action, 
DELETED.ProductID_NK AS TargetProductID, 
DELETED.ProductName AS TargetProductName, 
DELETED.Rate AS TargetRate, 
INSERTED.ProductID_NK AS SourceProductID, 
INSERTED.ProductName AS SourceProductName, 
INSERTED.Rate AS SourceRate; 

SELECT @@ROWCOUNT;

END TRY
BEGIN CATCH
    THROW
END CATCH
GO

-- Testing
--Insert records into target table
INSERT INTO Products
VALUES
   (1, 'Tea', 10.00),
   (2, 'Coffee', 20.00),
   (3, 'Muffin', 30.00),
   (4, 'Biscuit', 40.00)
GO
SELECT * FROM products;

EXEC dbo.product_SCD1_ETL;

SELECT * FROM Dim_Products_SCD1;

INSERT INTO Products
VALUES
   (5, 'Ice Tea', 9.00)
GO

Update Products
SET Rate = 15.00 
WHERE ProductID = 1;

EXEC dbo.product_SCD1_ETL;

SELECT * FROM Dim_Products_SCD1;

DELETE FROM Products
WHERE ProductID = 2;

EXEC dbo.product_SCD1_ETL;

SELECT * FROM Dim_Products_SCD1;

