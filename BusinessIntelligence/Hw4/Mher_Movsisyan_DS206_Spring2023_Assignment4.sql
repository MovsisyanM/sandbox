-- Run the following script to generate two tables 
DROP TABLE IF EXISTS [dbo].[employees];
GO

DROP TABLE IF EXISTS [dbo].[departments];
GO

CREATE TABLE [dbo].[departments] (
	DepartmentID int NOT NULL IDENTITY(1,1),
	DepartmentName varchar(20) DEFAULT NULL,
		CONSTRAINT dept_prim_key PRIMARY KEY (DepartmentID)
	);
INSERT INTO [dbo].[departments] (DepartmentName) Values ('Executive'),('Marketing'),('Production');

-- Test the contents of the table
SELECT * FROM [dbo].[departments];

CREATE TABLE [dbo].[employees] (
	EmployeeID int NOT NULL IDENTITY(1,1),
	FirstName varchar(20) DEFAULT NULL,
	LastName varchar(25) DEFAULT NULL,
	Education varchar(25) DEFAULT NULL,
	Position varchar(20) DEFAULT NULL,
	YearlyIncome  int DEFAULT NULL,
	ReportsTo int DEFAULT NULL,
	DepartmentID int DEFAULT NULL,
	HireDate datetime DEFAULT NULL,
		PRIMARY KEY (EmployeeID),
		CONSTRAINT dept_id_fk FOREIGN KEY (DepartmentID) REFERENCES [dbo].[departments] (DepartmentID)
	);
INSERT INTO [dbo].[employees] (FirstName,LastName,Education,Position,YearlyIncome,ReportsTo,DepartmentID,HireDate) 
	VALUES 
	('Steven','King','Masters','Manager', 100000,NULL, 1,'1992-04-03 00:00:00'),
	('Neena','Kochhar','Bachelors', 'Executive Assistant', 40000,1,1,'1992-04-04 00:00:00'),
	('Mike', 'Tyson', 'Ph.D.', 'Financial Consultant', 75000, 1, 1, '1992-05-03 00:00:00'),
	('Lex','De Haan', 'Masters', 'Department Manager', 85000,1,2,'1992-05-04 00:00:00'),
	('Alexander','Hunold','Masters','Department Manager', 85000,1,3,'1992-05-04 00:00:00'),
	('Bruce','Ernst','Masters','Team Lead',50000,4,2,'1992-05-13 00:00:00'),
	('David','Beckham','Masters','Expert',45000,6,2,'1998-05-14 00:00:00'),
	('David','Austin','Bachelors','Senior Specialist',40000,6,2,'1998-05-30 00:00:00'),
	('Valli','Pataballa','Bachelors','Junior Specialist',25000,6,2,'1998-06-03 00:00:00'),
	('Nancy','Greenberg','Masters','Unit Manager',40000,5,3,'1998-05-13 00:00:00'),
	('Conor','McGregor','Masters','Unit Manager',40000,5,3,'1998-05-14 00:00:00'),
	('Diana','Lorentz','High School','Skilled Manual',15000,10,3,'1998-05-15 00:00:00'),
	('Joe','Frazier','High School','Junior Manual',7000,10,3,'1998-05-17 00:00:00'),
	('Daniel','Faviet','High School','Junior Manual',7000,10,3,'1998-05-18 00:00:00'),
	('John','Chen','High School','Skilled Manual',15000,11,3,'2000-05-20 00:00:00'),
	('John','Cena','High School','Junior Manual',6500,11,3,'2000-05-21 00:00:00'),
	('Randy','Orton','High School','Junior Manual',6500,11,3,'2000-05-22 00:00:00');

-- Test the contents of the table
SELECT * FROM [dbo].[employees];
GO

/*
Exercise 1 (5 points): 
			Create a user-defined function (UDF) with no parameters called 
			CalculateAverageIncome
			that calculates the average yearly income of all employees of the 
			[dbo].[employees] table. Test the function.
*/

CREATE FUNCTION CalculateAverageIncome()
RETURNS DECIMAL(10, 2)
AS
BEGIN
	DECLARE @avgIncome DECIMAL(10, 2)

	SELECT @avgIncome = AVG(dbo.employees.YearlyIncome)
	FROM dbo.employees

	RETURN @avgIncome
END
GO

-- Test the function
SELECT dbo.CalculateAverageIncome() AS avg_income

/*
Exercise 2 (3 points): 
			Use CalculateAverageIncome() UDF created above to run a query on [dbo].[employees] that returns:
			- FirstName,
			- LastName,
			- YearlyIncome,
			- AverageIncomeCompany,
			- IncomeDifference (= YearlyIncome - AverageIncomeCompany).
			Test the function.
*/ 
SELECT * FROM [dbo].[employees];

select 
	FirstName, 
	LastName,
	YearlyIncome,
	dbo.CalculateAverageIncome() as AverageIncomeCompany,
	YearlyIncome - dbo.CalculateAverageIncome() as IncomeDifference
from dbo.employees;

/*
Exercise 3 (5 points): 
			Create a UDF named FullName that concatenates FirstName and LastName into a single Varchar.
			Use the created UDF to run a query run a query on [dbo].[employees] that returns:
			- FullName,
			- Position,
			- Education.
			Test the function.
*/
GO

create function FullName(@firstName VARCHAR(50), @lastName VARCHAR(50))
returns varchar(100)
as
begin
	declare @fullName varchar(100)

	select @fullName = @firstName + ' ' + @lastName

	return @fullName
end
GO

-- Test the function
SELECT dbo.FullName('Gugo', 'Aper') AS full_name


-- Use the created UDF to run a query on [dbo].[employees]
SELECT 
    dbo.FullName(FirstName, LastName) AS FullName,
    Position,
    Education
FROM
    [dbo].[employees]
GO


/*
Exercise 4 (8 points): 
			Create a UDF named TopEmployees that returns the top N (where N is a parameter)
			employees based on their yearly income. Test the function.
*/

CREATE FUNCTION dbo.TopEmployees (@N INT)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP (@N) *
    FROM
        [dbo].[employees] e
    ORDER BY
        e.YearlyIncome DESC
)
GO

SELECT *
FROM dbo.TopEmployees(5)
GO


/* Exercise 5 (8 points): 
			  Create a UDF named PositionCountByDepartment that accepts a department_name parameter and returns
			  - [DepartmentName],
			  - [Position],
			  - [count_of_position]
			  for the given department.

			  Test your function.
*/

CREATE FUNCTION dbo.PositionCountByDepartment (@DepartmentName NVARCHAR(100))
RETURNS TABLE
AS
RETURN
(
    SELECT
        d.DepartmentName,
        e.Position,
        COUNT(*) AS count_of_position
    FROM
        [dbo].[employees] e
        JOIN [dbo].[departments] d ON e.DepartmentID = d.DepartmentID
    WHERE
        d.DepartmentName = @DepartmentName
    GROUP BY
        d.DepartmentName,
        e.Position
)
GO

SELECT *
FROM dbo.PositionCountByDepartment('Marketing')
GO


SELECT *
FROM dbo.PositionCountByDepartment('Executive')
GO

SELECT *
FROM dbo.PositionCountByDepartment('Production')
GO


/* Exercise 6 (7 points)
			Write a script (using a correlated subquery) to return all the employees (FirstName, LastName, YearlyIncome, DepartmentID)
			the yearly income of which exceeeds the average of the employee's respective department.
*/


select * 
FROM (
	select 
		FirstName, 
		LastName,
		YearlyIncome,
		dbo.CalculateAverageIncome() as AverageIncomeCompany,
		YearlyIncome - dbo.CalculateAverageIncome() as IncomeDifference
	from dbo.employees
) cq
where cq.IncomeDifference > 0;

/* Exercise 7 (6 points)
			Write a script (using windows functions) to return all the employees (FirstName, LastName, YearlyIncome, DepartmentID)
			along with the following attributes:
			- running_total: the running total YearlyIncome across all the employees,
			- running_total_per_dpt: the running total YearlyIncome across each department,
			- avg_per_dpt: the average YearlyIncome for each department,
			- diff_from_avg_dpt: how much the difference is between the YearlyIncome and avg_per_dpt for each employee,
			- first_emp_in_dpt: the first hired employee of each department (FirstName + LastName).
*/

SELECT 
  e.FirstName, 
  e.LastName, 
  e.YearlyIncome, 
  e.DepartmentID,
  SUM(e.YearlyIncome) OVER (ORDER BY e.EmployeeID) as running_total,
  SUM(e.YearlyIncome) OVER (PARTITION BY e.DepartmentID ORDER BY e.EmployeeID) as running_total_per_dpt,
  AVG(e.YearlyIncome) OVER (PARTITION BY e.DepartmentID) as avg_per_dpt,
  e.YearlyIncome - AVG(e.YearlyIncome) OVER (PARTITION BY e.DepartmentID) as diff_from_avg_dpt,
  CONCAT(e2.FirstName, ' ', e2.LastName) as first_emp_in_dpt
FROM 
  employees e
  INNER JOIN (
    SELECT 
      DepartmentID, 
      FirstName, 
      LastName, 
      ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY HireDate ASC) as rn
    FROM 
      employees
  ) e2 ON e.DepartmentID = e2.DepartmentID AND e2.rn = 1
ORDER BY 
  e.EmployeeID;


/* Exercise 8 (7 points):
			   Create a DimEmployee_SCD1 table based on the [dbo].[employees] table.
			   The newly created dimension table should be a type 1 slowly changing dimension
			   with all the necessary additional columns (if applicable).
			   Create a stored procedure named dbo.DimEmployee_SCD1_ETL for populating 
			   the dimension table.
			   Test the procedure on both INSERT and UPDATE cases.
*/

CREATE TABLE DimEmployee_SCD1
(
    EmployeeID int PRIMARY KEY,
    FirstName varchar(50) NOT NULL,
    LastName varchar(50) NOT NULL,
    BirthDate date NOT NULL,
    HireDate date NOT NULL,
    TerminationDate date,
    YearlyIncome decimal(10,2) NOT NULL,
    DepartmentID int NOT NULL
);
go

CREATE PROCEDURE dbo.DimEmployee_SCD1_ETL
    @EmployeeID int,
    @FirstName varchar(50),
    @LastName varchar(50),
    @BirthDate date,
    @HireDate date,
    @YearlyIncome decimal(10,2),
    @DepartmentID int
AS
BEGIN
    IF EXISTS (SELECT * FROM DimEmployee_SCD1 WHERE EmployeeID = @EmployeeID)
    BEGIN
        UPDATE DimEmployee_SCD1 SET
            FirstName = @FirstName,
            LastName = @LastName,
            BirthDate = @BirthDate,
            HireDate = @HireDate,
            YearlyIncome = @YearlyIncome,
            DepartmentID = @DepartmentID
        WHERE EmployeeID = @EmployeeID;
    END
    ELSE
    BEGIN
        INSERT INTO DimEmployee_SCD1 (EmployeeID, FirstName, LastName, BirthDate, HireDate, YearlyIncome, DepartmentID)
        VALUES (@EmployeeID, @FirstName, @LastName, @BirthDate, @HireDate, @YearlyIncome, @DepartmentID);
    end
end

exec dbo.DimEmployee_SCD1_ETL 99, 'Gugo', 'Aper', '1999-01-01', '2023-01-01', 90000, 1;


exec dbo.DimEmployee_SCD1_ETL 99, 'Gugo', 'Axper', '1999-01-01', '2023-01-01', 120000, 1;

select * from DimEmployee_SCD1

/* Exercise 9 (8 points): 
			   Create a DimEmployee_SCD2 table based on the [dbo].[employees] table.
			   The newly created dimension table should be a type 2 slowly changing dimension
			   with all the necessary additional columns (if applicable).
			   Create a stored procedure named dbo.DimEmployee_SCD2_ETL for populating 
			   the dimension table.
			   Test the procedure on both INSERT and UPDATE cases.
*/
drop table if exists DimEmployee_SCD2;
go

CREATE TABLE DimEmployee_SCD2
(
	SID_pk_sk int,
    EmployeeID int,
    FirstName varchar(50) NOT NULL,
    LastName varchar(50) NOT NULL,
    BirthDate date NOT NULL,
    HireDate date NOT NULL,
    TerminationDate date,
    YearlyIncome decimal(10,2) NOT NULL,
    DepartmentID int NOT NULL,
    EffectiveStartDate date NOT NULL,
    EffectiveEndDate date,
    IsCurrent bit DEFAULT 1,
    CONSTRAINT PK_DimEmployee_SCD2 PRIMARY KEY CLUSTERED (SID_pk_sk)
);
go

DROP procedure if exists dbo.DimEmployee_SCD2_ETL;
GO

CREATE PROCEDURE dbo.DimEmployee_SCD2_ETL
    @EmployeeID int,
    @FirstName varchar(50),
    @LastName varchar(50),
    @BirthDate date,
    @HireDate date,
    @YearlyIncome decimal(10,2),
    @DepartmentID int
AS
BEGIN
    IF EXISTS (SELECT * FROM DimEmployee_SCD2 WHERE EmployeeID = @EmployeeID AND IsCurrent = 1)
    BEGIN
        UPDATE DimEmployee_SCD2 SET
            EffectiveEndDate = DATEADD(day, -1, GETDATE()),
            IsCurrent = 0
        WHERE EmployeeID = @EmployeeID AND IsCurrent = 1;
        
        INSERT INTO DimEmployee_SCD2 (EmployeeID, FirstName, LastName, BirthDate, HireDate, YearlyIncome, DepartmentID, EffectiveStartDate, EffectiveEndDate, IsCurrent)
        VALUES (@EmployeeID, @FirstName, @LastName, @BirthDate, @HireDate, @YearlyIncome, @DepartmentID, GETDATE(), NULL, 1);
    END
    ELSE
    BEGIN
        INSERT INTO DimEmployee_SCD2 (EmployeeID, FirstName, LastName, BirthDate, HireDate, YearlyIncome, DepartmentID, EffectiveStartDate, EffectiveEndDate, IsCurrent)
        VALUES (@EmployeeID, @FirstName, @LastName, @BirthDate, @HireDate, @YearlyIncome, @DepartmentID, GETDATE(), NULL, 1);
    END
END
go

exec dbo.DimEmployee_SCD2_ETL 99, 'Gugo', 'Aper', '1999-01-01', '2023-01-01', 90000, 1;
go

exec dbo.DimEmployee_SCD2_ETL 99, 'Gugo', 'Axper', '1999-01-01', '2023-01-01', 120000, 1;
go
select * from DimEmployee_SCD2


/* Exercise 10 (8 points): 
			   Create a DimEmployee_SCD3 table based on the [dbo].[employees] table.
			   The newly created dimension table should be a type 3 slowly changing dimension
			   with all the necessary additional columns (if applicable). 
			   The dimension saves the previous two positions of the employee
			   with the respective validity date.
			   Create a stored procedure named dbo.DimEmployee_SCD3_ETL for populating 
			   the dimension table.
			   Test the procedure on both INSERT and UPDATE cases.
*/


/* Exercise 11 (8 points)
			Create a stored procedure named CreatePopulateDateDim with two parameters start_date (YYYY-MM-DD) 
			and end_date (YYYY-MM-DD) that returns a date dimension table 
			named DimDate with the following columns

 DateID				| int		| NOT NULL | PRIMARY KEY | IDENTITY (1,1)
 DateAlternateKey   | int		| NOT NULL | YYYYMMDD    |
 Date				| datetime  | NOT NULL |			 |
 Year				| int		| NOT NULL |			 |
 Month				| int		| NOT NULL |			 |
 Day				| int		| NOT NULL |			 |
 QuarterNumber		| int		| NOT NULL |			 |

 Test the stored procedure by choosing any two-year interval.
*/


/* Exercise 12 (6 points)
			Create a stored procedure named AddPopulateHolidayCols with a single parameter 
			@tablename (VARCHAR) that accepts the date dimension table name as parameter and
			a) adds two new columns to the table
			----HoldayARM VARCHAR(30) NULL - a column for storing the name of the holiday (if it exist for a particular day)
			----IsHolidayARM BIT NULL = a binary (flag) column indicating whether a particular day is an Armenian holiday or not
			b) populates the newly created columns with the following Armenian holidays
			---National Army Day (January 28),
			---Genocide Memorial Day (April 24)
			---Victory Day (May 9),
			---Independence Day (September 21).

			Hint: You will need dynamic sql queries to complete this exercise: https://www.sqlshack.com/dynamic-sql-in-sql-server/

			Test the stored procedure on the DimDate table created in Exercise 9.
*/


/* Exercise 13 (7 points)
			Create a procedure that accepts the employee_id as an input parameter and returns 
			all the subordinates (employees managed by the given /input/ employee).
			Test the stored procedure.

			Hint: You will recursive CTEs to complete this exercise: https://learnsql.com/blog/sql-recursive-cte/

			Columns to be returned by the procedure: EmployeeID, FirstName, LastName, ReportsTo
			Sample return when @employee_id = 4

			4	Lex	De Haan	1
			6	Bruce	Ernst	4
			7	David	Beckham	6
			8	David	Austin	6
			9	Valli	Pataballa	6
*/


/* Exercise 14 (7 points)
			Create a procedure that accepts the employee_id as an input parameter and returns 
			all the superordinates (all the employees above the given /input/ employee)
			Test the stored procedure.

			Hint: You will recursive CTEs to complete this exercise: https://learnsql.com/blog/sql-recursive-cte/

			Columns to be returned by the procedure: EmployeeID, FirstName, LastName, ReportsTo
			Sample return when @employee_id = 17

			17	Randy	Orton	11
			11	Conor	McGregor	5
			5	Alexander	Hunold	1
			1	Steven	King	NULL
*/


/* Exercise 15 (7 points)
			Add a column to the employees table named deleted_flg that is not null and has a default value of 0.
			Create a trigger that would be activated when attempting to delete a row from the employees table
			and would set the deleted_flg value to 1 instead of deleting the row.
*/


