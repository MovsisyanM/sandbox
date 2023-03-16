/*
-----------------------------------------------------------------------------------------
PRELIM: Create a new SQL query (.sql) and save it using the following name format: Name_Surname_hw.sql
-----------------------------------------------------------------------------------------
*/

/*
-----------------------------------------------------------------------------------------
PART 1
-----------------------------------------------------------------------------------------
*/

/*
Exercise 1 (2 points): Create a new database named hw_db using the CREATE DATABASE statement with the following explicit specifications for database and transaction log files:
•	Store the database file with the logical name hw_db_dat in the same directory as the SQL script file under the name hw_db.mdf, set the initial size of mdf to 5MB, set the maximum size as unlimited, and the file growth at 8 percent. 
•	Store the log file called hw_db_log in the same directory as the SQL script under the name hw_db_log.ldf. Set the initial size to 2MB, the maximum size to 10MB, and the file growth to 500KB.
*/

CREATE DATABASE hw_db
ON
(
    NAME = hw_db_dat,
    FILENAME = 'C:\Projects\sandbox\BusinessIntelligence\Hw3\hw_db.mdf',
    SIZE = 5MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 8%
)
LOG ON
(
    NAME = hw_db_log,
    FILENAME = 'C:\Projects\sandbox\BusinessIntelligence\Hw3\hw_db_log.ldf',
    SIZE = 2MB,
    MAXSIZE = 10MB,
    FILEGROWTH = 500KB
);

/*
Exercise 2 (2 points): Using the ALTER DATABASE statement, add a new log file to the hw_db database. 
Store the log file in the same directory as the SQL script file under the name emp_log.ldf. 
Set the initial size of the file to 3MB, with growth of 2MB and an unlimited maximum size.
*/

ALTER DATABASE hw_db
ADD LOG FILE
(
    NAME = emp_log,
    FILENAME = 'C:\Projects\sandbox\BusinessIntelligence\Hw3\emp_log.ldf',
    SIZE = 3MB,
    FILEGROWTH = 2MB,
    MAXSIZE = UNLIMITED
);

/*
Exercise 3 (2 points): Using the ALTER DATABASE statement, change the database file size of the hw_db database to 10MB.
*/

ALTER DATABASE hw_db
MODIFY FILE
(
    NAME = hw_db_dat,
    SIZE = 10MB
);


/*
Exercise 4 (2 points): Create the tables customers and orders with the following columns (Check Moodle). 
Do not declare the corresponding primary and foreign keys.)
*/
/*
::`customers` table::
customerid char(5) not null
companyname varchar(40) not null
contactname char(30) null
address varchar(60) null
city char(15) null
phone char(24) null
fax char(24) null
*/
/*
::`orders` table::
orderid integer not null
customerid char(5) not null
orderdate date null
shippeddate date null
freight money null
shipname varchar(40) null
shipaddress varchar(60) null
quantity integer null
*/

USE hw_db;
GO

CREATE TABLE customers
(
    customerid CHAR(5) NOT NULL,
    companyname VARCHAR(40) NOT NULL,
    contactname CHAR(30) NULL,
    address VARCHAR(60) NULL,
    city CHAR(15) NULL,
    phone CHAR(24) NULL,
    fax CHAR(24) NULL
);

CREATE TABLE orders
(
    orderid INTEGER NOT NULL,
    customerid CHAR(5) NOT NULL,
    orderdate DATE NULL,
    shippeddate DATE NULL,
    freight MONEY NULL,
    shipname VARCHAR(40) NULL,
    shipaddress VARCHAR(60) NULL,
    quantity INTEGER NULL
);


/*
Exercise 5 (2 points): Using the ALTER TABLE statement, add a new column named shipregion to the orders table. The fields should be nullable and contain integers.
*/

ALTER TABLE orders
ADD shipregion INTEGER NULL;

/*
Exercise 6 (2 points): Using the ALTER TABLE statement, change the data type of the column 
shipregion from INTEGER to CHARACTER with length 10. The fields may contain NULL values.
*/

ALTER TABLE orders
ALTER COLUMN shipregion CHAR(10) NULL;

/*
Exercise 7 (2 points): Delete the formerly created column shipregion.
*/

ALTER TABLE orders
DROP COLUMN shipregion;

/*
Exercise 8 (2 points): Drop both tables customers and order and recreate them, 
enhancing their definition with all primary and foreign keys constraints (customers: customerid as PRIMARY KEY, orders: orderid as PRIMARY KEY and customerid as FOREIGN KEY).
*/

DROP TABLE orders;
DROP TABLE customers;


CREATE TABLE customers
(
    customerid CHAR(5) NOT NULL,
    companyname VARCHAR(40) NOT NULL,
    contactname CHAR(30) NULL,
    address VARCHAR(60) NULL,
    city CHAR(15) NULL,
    phone CHAR(24) NULL,
    fax CHAR(24) NULL,
    PRIMARY KEY (customerid)
);

CREATE TABLE orders
(
    orderid INTEGER NOT NULL,
    customerid CHAR(5) NOT NULL,
    orderdate DATE NULL,
    shippeddate DATE NULL,
    freight MONEY NULL,
    shipname VARCHAR(40) NULL,
    shipaddress VARCHAR(60) NULL,
    quantity INTEGER NULL,
    PRIMARY KEY (orderid),
    FOREIGN KEY (customerid) REFERENCES customers(customerid)
);

/*
Exercise 9 (2 points): Using the ALTER TABLE statement, add the current system date and time 
as the default value to the orderdate column of the orders table via a constraint. 
*/

ALTER TABLE orders
ADD CONSTRAINT DF_orderdate
DEFAULT (GETDATE()) FOR orderdate;


/*
Exercise 10 (2 points): Using the ALTER TABLE statement, create an integrity constraint (CHECK) 
that limits the possible values of the quantity column in the orders table to values between 5 and 40.
*/

ALTER TABLE orders
ADD CONSTRAINT CHK_quantity
CHECK (quantity >= 5 AND quantity <= 40);

/*
Exercise 11 (2 points): Try deleting the primary key constraint of the customers table. 
Why isn’t that working?
*/
--Answer:
-- Removing the primary key constraint while the foreign key constraint is still in place would violate referential integrity, 
-- and the db management system prevents this from happening.

-- Declare variables for constraint names
DECLARE @PrimaryKeyConstraintName NVARCHAR(128);
DECLARE @ForeignKeyConstraintName NVARCHAR(128);

-- Find the primary key constraint name for the customers table
SELECT @PrimaryKeyConstraintName = CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'customers' AND CONSTRAINT_TYPE = 'PRIMARY KEY';

-- Find the foreign key constraint name for the orders table
SELECT @ForeignKeyConstraintName = CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'orders' AND CONSTRAINT_TYPE = 'FOREIGN KEY';

-- Remove the foreign key constraint from the orders table
DECLARE @DropForeignKeyConstraintSQL NVARCHAR(MAX);
SET @DropForeignKeyConstraintSQL = N'ALTER TABLE orders DROP CONSTRAINT ' + QUOTENAME(@ForeignKeyConstraintName) + ';';
EXEC sp_executesql @DropForeignKeyConstraintSQL;

-- Remove the primary key constraint from the customers table
DECLARE @DropPrimaryKeyConstraintSQL NVARCHAR(MAX);
SET @DropPrimaryKeyConstraintSQL = N'ALTER TABLE customers DROP CONSTRAINT ' + QUOTENAME(@PrimaryKeyConstraintName) + ';';
EXEC sp_executesql @DropPrimaryKeyConstraintSQL;

/*
Exercise 12 (2 points): Rename the city column of the customers table to town (2 different approaches)
*/

-- 1
EXEC sp_rename 'customers.city', 'town', 'COLUMN';

-- 2
-- Add a new column 'town' to the customers table
ALTER TABLE customers
ADD town CHAR(15) NULL;

-- Copy the data from the 'city' column to the 'town' column
UPDATE customers
SET town = city;

-- Drop the 'city' column
ALTER TABLE customers
DROP COLUMN city;

/*
-----------------------------------------------------------------------------------------
PART 2: RUN THE FOLLOWING SCRIPT TO GENERATE A DATABASE NAMED sample
-----------------------------------------------------------------------------------------
*/
--CREATING THE DATABASE sample (put mdf and ldf in the same directory)
use master;
CREATE DATABASE sample
	ON
	(NAME=sample_dat,
	 FILENAME="C:\Projects\sandbox\BusinessIntelligence\Hw3\sample.mdf", -- Put the desired mdf filename (full path) here
	 SIZE=10,
	 MAXSIZE=100,
	 FILEGROWTH=5)
	LOG ON
	(NAME=sample_log,
	 FILENAME="C:\Projects\sandbox\BusinessIntelligence\Hw3\sample.ldf", -- Put the desired ldf filename (full path) here
	 SIZE=10,
	 MAXSIZE=100,
	 FILEGROWTH=5);

--CREATING TABLES WITH PRIMARY KEY AND FOREIGN KEY CONSTRAINTS
USE sample;
GO

DROP TABLE IF EXISTS works_on;
GO
DROP TABLE IF EXISTS employee;
GO
DROP TABLE IF EXISTS department;
GO
DROP TABLE IF EXISTS project;

USE sample;
GO

CREATE TABLE department  (
	dept_no CHAR(4) NOT NULL,
    dept_name CHAR(25) NOT NULL,
    location CHAR(30) NULL,
	CONSTRAINT prim_dept PRIMARY KEY (dept_no));
GO

CREATE TABLE employee  (
	emp_no INTEGER NOT NULL,
    emp_fname CHAR(20) NOT NULL,
    emp_lname CHAR(20) NOT NULL,
    dept_no CHAR(4) NULL,
    emp_loc CHAR(35) NULL,
	CONSTRAINT prim_emp PRIMARY KEY (emp_no),
	CONSTRAINT foreign_emp FOREIGN KEY (dept_no) 
		REFERENCES department(dept_no));
GO

CREATE TABLE project  (
	project_no CHAR(4) NOT NULL,
    project_name CHAR(15) NOT NULL,
    budget FLOAT NULL,
	CONSTRAINT prim_proj PRIMARY KEY(project_no));
GO

CREATE TABLE works_on  (
	emp_no INTEGER NOT NULL,
    project_no CHAR(4) NOT NULL,
    job CHAR (15) NULL,
    enter_date DATE NULL,
	CONSTRAINT prim_works PRIMARY KEY (emp_no, project_no),
	CONSTRAINT foreign1_works FOREIGN KEY(emp_no) 
		REFERENCES employee(emp_no),
	CONSTRAINT foreign2_works FOREIGN KEY (project_no)
		REFERENCES project(project_no));
GO

--LOAD DATA INTO THE DEPARTMENT TABLE
INSERT INTO department VALUES ('d1', 'Research', 'Dallas');
INSERT INTO department VALUES ('d2', 'Accounting', 'Seattle');
INSERT INTO department VALUES ('d3', 'Marketing', 'Dallas');
GO

--LOAD DATA INTO THE EMPLOYEE TABLE
INSERT INTO employee VALUES (25348, 'Matthew', 'Smith','d3','Denton County');
INSERT INTO employee VALUES (10102, 'Ann', 'Jones','d3','Denton County');
INSERT INTO employee VALUES (18316, 'John', 'Barrimore', 'd1','Northeast Dallas County');
INSERT INTO employee VALUES (29346, 'James', 'James', 'd2','Central Seattle');
INSERT INTO employee VALUES (9031, 'Elsa', 'Bertoni', 'd2','Central Seattle');
INSERT INTO employee VALUES (2581, 'Elke', 'Hansel', 'd2','North Seattle');
INSERT INTO employee VALUES (28559, 'Sybill', 'Moser', 'd1','Northwest Dallas County');
INSERT INTO employee VALUES (28640, 'Jack', 'James', 'd1','South Dallas County');
GO

--LOAD DATA INTO THE PROJECT TABLE
INSERT INTO project VALUES ('p1', 'Apollo', 120000.00);
INSERT INTO project VALUES ('p2', 'Gemini', 95000.00);
INSERT INTO project VALUES ('p3', 'Mercury', 186500.00);
GO

--LOAD DATA INTO THE WORKS_ON TABLE
INSERT INTO works_on VALUES (10102,'p1', 'Analyst', '2006.10.1');
INSERT INTO works_on VALUES (10102, 'p3', 'Manager', '2008.2.1');
INSERT INTO works_on VALUES (25348, 'p2', 'Clerk', '2007.2.15');
INSERT INTO works_on VALUES (18316, 'p2', NULL, '2007.6.1');
INSERT INTO works_on VALUES (29346, 'p2', NULL, '2006.12.15');
INSERT INTO works_on VALUES (2581, 'p3', 'Analyst', '2007.10.15');
INSERT INTO works_on VALUES (9031, 'p1', 'Manager', '2007.4.15');
INSERT INTO works_on VALUES (28559, 'p1', 'NULL', '2007.8.1');
INSERT INTO works_on VALUES (28559, 'p2', 'Clerk', '2008.2.1');
INSERT INTO works_on VALUES (9031, 'p3', 'Clerk', '2006.11.15');
INSERT INTO works_on VALUES (28640, 'p1', 'Clerk', '2006.10.15');
GO

/*
Exercise 13 (2 points): Get all rows of the works_on table.
*/

SELECT *
FROM works_on;


/*
Exercise 14 (2 points): Get the employee numbers for all clerks.
*/

SELECT emp_no
FROM works_on;

/*
Exercise 15 (2 points): Get the employee numbers for employees working on project p3 and having employee numbers lower than 10000.
*/

select emp_no
from works_on
where project_no = 'p3';

/*
Exercise 16 (2 points): Get the employee numbers for employees who didn’t enter their project in 2007.
*/

select emp_no
from works_on
where YEAR(enter_date) <> 2007;

/*
Exercise 17 (2 points): Get the employee numbers for all employees 
who have a leading job (i.e., Analyst or Manager) in project p1.
*/

select emp_no
from works_on
where job <> 'Clerk' and project_no = 'p1';

/*
Exercise 18 (2 points): Get the enter dates for all employees in project p2 whose jobs have not been determined yet.
*/



/*
Exercise 19 (2 points): Get the employee numbers and last names of all employees 
whose first names contain two letter t’s (HINT: Use LIKE and regular expressions).
*/


/*
Exercise 20 (2 points): Get the employee numbers and first names of all employees whose last names have a letter o or a as the second character and end with the letters es (HINT: Use LIKE and regular expressions).
*/


/*
Exercise 21 (2 points): Find the employee numbers of all employees whose department is located in Seattle.
*/


/*
Exercise 22 (2 points): Find the last and first names of all employees who entered their projects 
on 06.01.2007.
*/


/*
Exercise 23 (2 points): Group all departments using their locations.
*/


/*
Exercise 24 (2 points): How does the GROUP BY clause manage the NULL values? 
*/
--Answer:

/*
Exercise 25 (2 points): What is the difference between COUNT(*) and COUNT(column)?
*/
--Answer:

/*
Exercise 26 (2 points): Find the largest employee number.
*/


/*
Exercise 27 (2 points): Get the jobs that are done by more than two employees.
*/


/*
Exercise 28 (2 points): Find the distinct employee numbers of all employees
who are clerks or work for department d3.
*/


/*
Exercise 29 (2 points): For the project and works_on tables, create the following:
1.	Natural join
2.	Cartesian product
*/


/*
Exercise 30 (2 points): Get the employee numbers and job titles of all employees 
working on project Gemini. Use the JOIN statement.
*/


/*
Exercise 31 (2 points): Get the first and last names of all employees 
who work for department Research or Accounting. Use the JOIN statement.
*/


/*
Exercise 32 (2 points): Get the enter dates of all clerks who belong to the department d1. Use the JOIN statement.
*/


/*
Exercise 33 (2 points): Get the names of projects on which two or more clerks are working.
Hint: Use subquery and count(*)
*/


/*
Exercise 34 (2 points): Get the first and last names of the employees who are managers and 
work on project Mercury. Use the JOIN statement.
*/


/*
Exercise 35 (2 points): Get the first and last names of all employees 
who entered the project at the same time as at least one other employee.
*/


/*
Exercise 36 (2 points): Explain why is the following statement wrong? 
Write the correct statement

use sample;
select project_name
	from project
	where project_no =
		(select project_no from works_on where job = 'Clerk');
*/
--Answer:


/*
Exercise 37 (2 points): Get the employee numbers of the employees 
living in the same location and belonging to the same department as one another.
*/


/*
Exercise 38 (2 points): Get the employee numbers of all employees belonging to the Marketing department. 
1.	The JOIN operator
2.	The subquery
*/


/*
Exercise 39 (2 points): Insert the data of a new employee called Julia Long, 
whose employee number is 11111. Her department number is not known yet. Her location is North Dallas
*/


/*
Exercise 40 (2 points): Create a new table called emp_d1_d2 with all employees who work for department d1 or d2, and load the corresponding rows from the employee table.
*/


/*
Exercise 41 (2 points): Create a new table of all employees who entered their projects in 2007 
and load it with the corresponding rows from the employee table.
*/


/*
Exercise 42 (2 points): Modify the job of all employees in project p1 who are managers. 
They have to work as clerks from now on.
*/


/*
Exercise 43 (2 points): Increase the budget of the project where the manager has the employee number 10102. The increase is 10 percent.
*/


/*
Exercise 44 (2 points): The budgets of all projects are no longer determined. Assign all budgets the NULL value.
*/


/*
Exercise 45 (2 points): Change the name of the department for which the employee with the first name James works. 
The new department name is Sales.
*/


/*
Exercise 46 (2 points): Modify the jobs of the employee with the employee number 28559. 
From now on she will be the manager for all her projects.
*/


/*
Exercise 47 (2 points): Change the enter date for the projects for those employees 
who work in project p1 and belong to department Sales. 
The new date is 12.12.2007.
*/


/*
Exercise 48 (2 points): Make sure that all the records of a project are automatically
deleted from the works_on table when a project is deleted in the project table.
Test the solution on the p1 project.
*/


/*
Exercise 49 (2 points): Delete the information (rows) in the works_on table for all employees 
who work for the departments located in Dallas.
*/


/*
Exercise 50 (2 points): Make sure that all the info about a department is automatically
updated in the employee table when a department is updated in the department table.
Test the solution on the d3 project (change it to d4).
*/




