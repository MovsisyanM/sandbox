INSERT INTO {db}.{schema}.Employees
   ([EmployeeID],[LastName],[FirstName],[Title]
	,[TitleOfCourtesy],[BirthDate],[HireDate],[Address],[City], [Region]
	,[PostalCode],[Country],[HomePhone], [Extension], [Notes], [ReportsTo], [PhotoPath])
	values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);