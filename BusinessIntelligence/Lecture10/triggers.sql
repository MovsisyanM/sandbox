USE master;
GO

CREATE DATABASE week10;

USE week10;
GO

DROP TABLE IF EXISTS Employee;
GO

CREATE TABLE Employee
(  
    EmployeeID int NOT NULL,
    FirstName nvarchar(50) NOT NULL,
    LastName nvarchar(50) NOT NULL,
    HireDate date,    
);
GO

DROP TABLE IF EXISTS EmpLog;
GO

CREATE TABLE EmpLog (
   logID INT IDENTITY(1,1) NOT NULL
   , EmployeeID INT NOT NULL
   , FirstName NVARCHAR(50) NOT NULL
   , LastName NVARCHAR(50) NOT NULL
   , HireDate date NOT NULL
   , Operation NVARCHAR(50)
   , UpdatedOn DATETIME
   , UpdatedBy NVARCHAR(50)
   );
GO

CREATE TRIGGER trgEmployeeAudit ON dbo.Employee
FOR INSERT, UPDATE, DELETE
AS
IF EXISTS ( SELECT 0 FROM Deleted )
BEGIN
   IF EXISTS ( SELECT 0 FROM Inserted )
   BEGIN
      INSERT  INTO dbo.EmpLog
      ( EmployeeID,
      FirstName,
      LastName,
      HireDate,
      Operation,
      UpdatedOn,
      UpdatedBy
      )
      SELECT  u.EmployeeID ,
      u.FirstName,
      u.LastName ,
      u.HireDate ,
      'Updated',
      GETDATE() ,
      SUSER_NAME()
      FROM deleted as u
   END
ELSE
   BEGIN
      INSERT  INTO dbo.EmpLog
      ( EmployeeID ,
      FirstName,
      LastName,
      HireDate,
      Operation,
      UpdatedOn,
      UpdatedBy
      )
      SELECT  d.EmployeeID ,
      d.FirstName ,
      d.LastName ,
      d.HireDate ,
      'Deleted',
      GETDATE() ,
      SUSER_NAME()
      FROM deleted as d
   END
   END
ELSE
   BEGIN
      INSERT  INTO dbo.EmpLog
      ( EmployeeID ,
      FirstName,
      LastName,
      HireDate,
      Operation,
      UpdatedOn,
      UpdatedBy
      )
      SELECT  i.EmployeeID ,
      i.FirstName ,
      i.LastName ,
      i.HireDate ,
      'Inserted',
      GETDATE() ,
      SUSER_NAME()
      FROM inserted as i
   END   
GO


-- Testing the trigger
select * from Employee;
---Insert 
INSERT INTO Employee
VALUES
(101, 'Neena','Kochhar','05-12-2018'),
(112, 'John','King','01-01-2015'),
(203, 'Catherine','Abel','07-21-2010'),
(411, 'Sam','Abolrous','03-12-2016');
GO

SELECT *
FROM EmpLog
ORDER BY logID;
GO


---Update
UPDATE Employee
SET LastName = 'Adams'
WHERE EmployeeID = 101;
GO

SELECT *
FROM EmpLog
ORDER BY logID;
GO


---Delete
DELETE
FROM Employee
WHERE EmployeeID = 203;
GO

SELECT *
FROM EmpLog
ORDER BY logID;
GO
