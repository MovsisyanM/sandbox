INSERT INTO {db}.{schema}.Customers
   ([CustomerID],[CompanyName],[ContactName],[ContactTitle]
	,[Address],[City],[Region],[PostalCode],[Country], [Phone], [Fax])
	values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);