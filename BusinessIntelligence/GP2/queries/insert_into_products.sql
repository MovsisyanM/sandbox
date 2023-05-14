INSERT INTO {db}.{schema}.Products
    ([ProductID],[ProductName],[SupplierID],[CategoryID],[QuantityPerUnit]
    ,[UnitPrice],[UnitsInStock], [UnitsOnOrder],[ReorderLevel], [Discontinued])
    values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
