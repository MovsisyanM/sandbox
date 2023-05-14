INSERT INTO {db}.{schema}.Orders
   ([OrderID],[CustomerID],[EmployeeID],[OrderDate],[RequiredDate],[ShippedDate]
	,[ShipVia],[Freight],[ShipName],[ShipAddress],[ShipCity], [ShipRegion]
	,[ShipPostalCode],[ShipCountry],[TerritoryID])
	values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);