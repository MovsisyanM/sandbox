CREATE TABLE {db}.{schema}.employees (
   [EmployeeID] INT PRIMARY KEY
   ,[LastName] VARCHAR(150)
   ,[FirstName] VARCHAR(50)
    ,[Title] VARCHAR(50)
    ,[TitleOfCourtesy] VARCHAR(50)
    ,[BirthDate] DATE
    ,[HireDate] DATE
    ,[Address] VARCHAR(100)
    ,[City] VARCHAR(50)
    ,[Region] VARCHAR(50) NULL
    ,[PostalCode] VARCHAR(50)
    ,[Country] VARCHAR(50)
    ,[HomePhone] VARCHAR(100)
    ,[Extension] INT
    ,[Notes] VARCHAR(500)
    ,[ReportsTo] INT NULL
    ,[PhotoPath] VARCHAR(200)
    ,CONSTRAINT FK_Employees_ReportsTo FOREIGN KEY (ReportsTo) REFERENCES {db}.{schema}.employees (EmployeeID));

--CREATE TABLE {db}.{schema}.employees (
--   [EmployeeID] INT PRIMARY KEY
--   ,[LastName] VARCHAR(150)
--   ,[FirstName] VARCHAR(50)
--    ,[Title] VARCHAR(50)
--    ,[TitleOfCourtesy] VARCHAR(50)
--    ,[BirthDate] DATE
--    ,[HireDate] DATE
--    ,[Address] VARCHAR(100)
--    ,[City] VARCHAR(50)
--    ,[Region] VARCHAR(50) NULL
--    ,[PostalCode] VARCHAR(50)
--    ,[Country] VARCHAR(50)
--    ,[HomePhone] VARCHAR(100)
--    ,[Extension] INT
--    ,[Notes] VARCHAR(500)
--    ,[ReportsTo] INT NULL
--    ,[PhotoPath] VARCHAR(200)
--    CONSTRAINT FK_Employees_ReportsTo FOREIGN KEY (ReportsTo) REFERENCES {db}.{schema}.employees (EmployeeID));