 /*Exercise 1 (3 points)
Write a SELECT statement that lists the employees. 
Include only their
- ids,
- full names (first name + ' '  + last name),
- manager ids,
- full names of managers. 
 */
use BikeStores
go

select 
  e.staff_id,
  e.first_name + ' ' + e.last_name as full_name,
  e.manager_id,
  m.first_name + ' ' + m.last_name as manager_full_name  
from sales.staffs e
left join sales.staffs m
on m.staff_id = e.manager_id;


go

 /*Exercise 2 (3 points)
Write a query using a WHERE clause that displays all the sales people listed in staffs table 
who work in a store from the NY state only. Display the staff IDs, first and last names, and their e-mails.
 */


select 
  e.staff_id,
  e.first_name,
  e.last_name,
  e.email 
from sales.staffs e
left join sales.stores s
on s.store_id = e.store_id
where state = 'NY';

go

 /*Exercise 3 (3 points)
Write a query that displays all the rows and columns from the sales.orders table where the orders were made 
during March, 2016 (reference column: order_date).
 */

select *
from sales.orders o
where o.order_date >= '2016-03-01' AND o.order_date < '2016-04-01';

go
  /*Exercise 4 (3 points)
Write a query that displays all the rows and columns from the sales.orders table where the shipments were made 
between March-April, 2016 on WEEKENDS (reference column: shipped_date).
 */

select *
from sales.orders o
where shipped_date >= '2016-03-01' AND shipped_date < '2016-05-01'
  AND DATEPART(weekday, shipped_date) IN (1, 7);

go

/*Exercise 5 (3 points)
Write a query that displays the product ID and name for each product from the
Production.Product table where the length of the product name is composed of no less than 25 characters.
*/

select p.product_id, p.product_name
from production.products p
where len(p.product_name) >=25;

go

/*Exercise 6 (3 points)
Write a query that displays the product ID and name for all the products 
that either have both 'Surly' and 'Wednesday' in their names
or have names containing 'Superfly' or 'Checkpoint'.
 */

select p.product_id, p.product_name
from production.products p
where ((p.product_name like '%Surly%')
  and (p.product_name like '%Wednesday%'))
  or (p.product_name like '%Superfly%')
  or (p.product_name like '%Checkpoint%');

go
 
/* Exercise 7 (3 points)
Write a query displaying the order ID, order date, and customer id from the sales.orders
table where the order was placed during the month of February 2016.
Retrieve only those rows where the customer first_ name starts with letter A, B, C, D.
*/

select o.order_id, o.order_date, o.customer_id
from sales.orders o
where o.customer_id in (
  select c.customer_id
  from sales.customers c
  where (c.first_name like 'A%') 
    or (c.first_name like 'B%')
    or (c.first_name like 'C%')
    or (c.first_name like 'D%')
) and o.order_date >= '2016-02-01' and o.order_date < '2016-03-01';

go


/* Exercise 8 (3 points)
Write a script (using windows functions) to return the following:
- product_id,
- order_date,
- total_purchase as quantity*list_price,
- running total purchase per product for each product,
*/

select 
    product_id,
    order_date,
    quantity * list_price as total_purchase,
    SUM(quantity * list_price) over (partition by product_id order by order_date) as running_total_purchase
from sales.order_items oi
left join sales.orders o
on oi.order_id = o.order_id;


/* Exercise 9 (3 points)
Write a query using the sales.orders table displaying the 
order_id, order_date, shipped_date columns. 
If the shipped_date column contains a NULL value, replace the NULL value with 'No shipment (yet)'. 
*/

select 
  order_id, 
  order_date, 
  COALESCE(cast(shipped_date as varchar (25)), 'No shipment (yet)') AS shipped_date
from sales.orders;

go


/* Exercise 10 (3 points)
Add a new column named in the sales.orders table that shows the differences in days between
order_date and shipped_date. 
Compare the performance of sales staff members by creating a query that contains
a) the full name of the staff member,
b) his/her average date_diff.
Return the top 3 members (based on their average date_diff) only.
*/

alter table sales.orders
add date_diff int null;


UPDATE sales.orders
SET date_diff = DATEDIFF(day, order_date, shipped_date);

go

select top 3
  first_name + ' ' + last_name as full_name,
  avg(date_diff) as avg_date_diff
from sales.orders o
join sales.staffs s
  on o.staff_id = s.staff_id
group by first_name + ' ' + last_name
order by avg_date_diff desc;

go

/* Exercise 11 (3 points)
 Write a query that displays 
 a) order date,
 b) the year of each order date, 
 c) the numeric month of each order date,
 d) the day of each order date,
 e) the alternative key of each order date (int, YYYYMMDD),
 f) the previous calendar year date for each order date (type: DATE),
 g) the first day of month for each order date (type: DATE),
 h) the last day of month for each order date (type: DATE) 
 i) the last Monday from the given date for each order date (type: DATE).
 */

select 
  order_date, 
  year(order_date) as order_year, 
  month(order_date) as order_month, 
  day(order_date) as order_day, 
  convert(int, format(order_date, 'yyyyMMdd')) as order_sk,
  dateadd(year, -1, order_date) as previous_year_date,
  datefromparts(year(order_date), month(order_date), 1) as first_day_of_month,
  eomonth(order_date) as last_day_of_month,
  dateadd(day, -(datepart(weekday, order_date) - 2) % 7, order_date) as last_monday
from sales.orders;

go


 /*Exercise 12 (3 points)
Write a query that displays
a) product_id,
b) product_name,
c) number of orders for that product (num_order).
Make sure to include all the products along even if an order has never
been placed for that product (number of orders would be 0)
Sort by the result by the number of orders (descending). 
*/

select 
  p.product_id, 
  p.product_name, 
  count(o.product_id) as num_order
from 
  production.products as p
left join sales.order_items as o 
  on p.product_id = o.product_id
group by
  p.product_id, 
  p.product_name
order by
  num_order desc;

go

/* Exercise 13 (3 points)
Using a subquery, display the product names and product id numbers from the
production.products table that have not been ordered.
*/

select product_id, product_name
from Production.products p
where not exists (
  select 1
  from Sales.order_items oi
  where oi.product_id = p.product_id
);

go

/* Exercise 14 (3 points)
Write a query that displays all customers along with the orders placed in 2016. Use a common
table expression to write the query and include the Customer ID, Customer Full Name, Sales Order ID, and Order Date
columns in the results. 
*/

with cteOrders as (
  select 
    c.customer_id as [Customer ID],
    concat(c.first_name, ' ', c.last_name) as [Customer Full Name],
    so.order_id as [Sales Order ID],
    so.order_date as [Order Date] 
  from sales.customers c
  inner join sales.orders so on c.customer_id = so.customer_id
  where year(so.order_date) = 2016
)
SELECT [Customer ID], [Customer Full Name], [Sales Order ID], [Order Date] 
FROM cteOrders
ORDER BY [Customer Full Name], [Sales Order ID];

go

/* Exercise 15 (8 points)
Create a trigger that would prevent any DML operations on [BikeStores].[sales].[customers]
table on weekends.
*/


create trigger trg_prevent_customer_DML_on_weekends
on [BikeStores].[sales].[customers]
for insert, update, delete
as
begin
  declare @dow int
  set @dow = datepart(weekday, getdate())

  if @dow in (1, 7)
  begin
    print 'DMP ops on the customers table are not allowed on the weekends'
    rollback transaction
  end
end

go

/* Exercise 16 (7 points)
Create a function called dbo.total_sales_by_employee that accepts staff_id for a parameter 
and returns the total value of all the products sold (quantity * listing_price) by that employee
Test the function.
*/

drop function if exists dbo.total_sales_by_employee;
go

create function dbo.total_sales_by_employee (@staff_id int) 
returns money
as
begin
  declare @total_sales money

  select 
    @total_sales = sum(oi.quantity * p.list_price)
  from sales.order_items oi
  inner join sales.orders o on oi.order_id = o.order_id
  inner join production.products p on oi.product_id = p.product_id
  where o.staff_id = @staff_id
  
  return @total_sales
end

go

/* Exercise 17 (7 points)
Create a ListPriceBands table with the following columns:

list_price_band |  varchar(255)                | not null 
lower_band      |  list_price DECIMAL (10, 2)  | not null 
upper_band      |  list_price DECIMAL (10, 2)  | 

Populate the band table with the following band  values:
(lower, 0, 550),
(lower middle, 551, 750),
(upper middle, 751, 1000),
(upper, 1001, )

Run a query that would return the following info about each product:
a) product_id,
b) product_name,
c) listing price,
d) price band of that product (based on listing price).
*/

drop table if exists ListPriceBands
go

create table ListPriceBands (
  list_price_band varchar (255) not null,
  lower_band decimal (10, 2) not null,
  upper_band decimal (10, 2)
);

go


insert into ListPriceBands
values
  ('lower', 0, 550),
  ('lower middle', 551, 750),
  ('upper middle', 751, 1000),
  ('upper', 1001, null)

go


select
    p.product_id,
    p.product_name,
    p.list_price,
    l.list_price_band
from production.products p
left join ListPriceBands l 
  on p.list_price >= l.lower_band and (p.list_price <= l.upper_band or l.upper_band is null);

go

/* Exercise 18 (18 points)
Design three slowly changing dimension type 1 tables based on the following source tables:
- [BikeStores].[production].[brands],
- [BikeStores].[production].[categories],
- [BikeStores].[sales].[stores].
Make sure to have all the necessary keys in your dimension tables.
Design three procedures for populating the new created dimension tables. 
The procedure for the brands table should include a DELETE component as well.
Do not forget to populate and test the newly created procedures.
*/

drop table if exists dim_production_brands, dim_production_categories, dim_sales_stores
go

create table dim_production_brands (
  brand_id_pk_sk int primary key,
  brand_id_nk int unique not null,
  brand_name varchar(255) not null
);

go

create table dim_production_categories (
  category_id_pk_sk int primary key,
  category_id_nk int unique not null,
  category_name varchar(255) not null
);

go

create table dim_sales_stores (
  store_id_pk_sk int primary key,
  store_id_nk int unique not null,
  store_name varchar (255) not null,
	phone varchar (25),
	email varchar (255),
	street varchar (255),
	city varchar (255),
	state varchar (10),
	zip_code varchar (5)
);

go

-- usp_populate_dim_production_brands

drop proc if exists dbo.usp_populate_dim_production_brands
go

create proc dbo.usp_populate_dim_production_brands
as
begin
  set nocount on;

  -- DELETE existing data
  delete from dim_production_brands;

  -- INSERT new data
  insert into dim_production_brands (brand_id_pk_sk, brand_id_nk, brand_name)
  select distinct 
    ROW_NUMBER() over (order by brand_id) as brand_id_pk_sk, 
    brand_id as brand_id_nk, 
    brand_name
  from BikeStores.production.brands;
end;
go


-- usp_populate_dim_production_categories

drop proc if exists dbo.usp_populate_dim_production_categories
go

create proc dbo.usp_populate_dim_production_categories
as
begin
  set nocount on;

  -- delete existing data
  delete from dim_production_categories;

  -- insert new data
  insert into dim_production_categories (category_id_pk_sk, category_id_nk, category_name)
  select distinct 
    ROW_NUMBER() over (order by category_id) as category_id_pk_sk, 
    category_id as category_id_nk, 
    category_name
  from BikeStores.production.categories;
end;
go

-- usp_populate_dim_sales_stores

drop proc if exists dbo.usp_populate_dim_sales_stores
go

create proc dbo.usp_populate_dim_sales_stores
as
begin
  set nocount on;

  -- delete existing data
  delete from dim_sales_stores;

  -- insert new data
  insert into dim_sales_stores (
    store_id_pk_sk, 
    store_id_nk, 
    store_name, 
    phone, 
    email, 
    street, 
    city, 
    state, 
    zip_code
    )
  select distinct 
    ROW_NUMBER() over (order by store_id) as store_id_pk_sk, 
    store_id as store_id_nk, 
    store_name, 
    phone, 
    email, 
    street, 
    city, 
    state, 
    zip_code
  from BikeStores.sales.stores;
end;
go


-- Populate the dimensions
exec dbo.usp_populate_dim_production_brands;
exec dbo.usp_populate_dim_production_categories;
exec dbo.usp_populate_dim_sales_stores;

-- Verify the data
select * from dim_production_brands;
select * from dim_production_categories;
select * from dim_sales_stores;

select * from production.brands;
select * from production.categories;
select * from sales.stores;
go


/* Exercise 19 (9 points)
Design a slowly changing dimension type 2 table based on the [BikeStores].[production].[products] table. 
Make sure to have all the necessary keys in your dimension table. 
Design a procedure for populating the new created dimension table. Make sure to pick up all the necessary
surrogate keys from other dimension tables. Do not forget to test the newly created procedure.
*/

drop table if exists scd2_production_products
go

-- Create the dimension table
create table scd2_production_products (
  product_id_pk_sk int primary key,
  product_id_nk int unique not null,
  product_name varchar(255) not null,
  brand_id_fk int not null,
  category_id_fk int not null,
  start_date datetime not null,
  end_date datetime,
  is_current bit not null default 1,
  constraint fk_brand_id foreign key (brand_id_fk) references dim_production_brands(brand_id_nk),
  constraint fk_category_id foreign key (category_id_fk) references dim_production_categories(category_id_nk)
);
go

-- Create the procedure to populate the table
drop proc if exists dbo.usp_populate_dim_production_products
go

create proc dbo.usp_populate_dim_production_products
as
begin
  set nocount on;

  -- insert new data
  insert into scd2_production_products (
    product_id_pk_sk,
    product_id_nk,
    product_name,
    brand_id_fk,
    category_id_fk,
    start_date
  )
  select
    ROW_NUMBER() over (order by product_id) as product_id_pk_sk,
    product_id as product_id_nk,
    product_name,
    b.brand_id_pk_sk as brand_id_fk,
    c.category_id_pk_sk as category_id_fk,
    getdate()
  from BikeStores.production.products p
  inner join dim_production_brands b on p.brand_id = b.brand_id_nk
  inner join dim_production_categories c on p.category_id = c.category_id_nk;

  -- update end date for old records
  update scd2_production_products
  set end_date = getdate(), is_current = 0
  where product_id_nk in (
  select product_id_nk
  from scd2_production_products
  where is_current = 1
  and product_id_nk not in (
      select product_id
      from BikeStores.production.products
    )
  );
end;
go

-- Populate the dimension
exec dbo.usp_populate_dim_production_products;

-- Verify the data
select * from scd2_production_products;
select * from production.products;

go

drop proc if exists dbo.usp_update_dim_production_products
go

create proc dbo.usp_update_dim_production_products
  @product_id int,
  @product_name varchar(255),
  @brand_id int,
  @category_id int,
  @end_date datetime
as
begin
  set nocount on;

  -- update the previous row to set end_date
  update scd2_production_products
  set
    end_date = dateadd(second, -1, @end_date),
    is_current = 0
  where
    product_id_nk = @product_id
  and is_current = 1;

  -- insert the new row with the updated information
  insert into scd2_production_products (
    product_id_pk_sk
    product_id_nk,
    product_name,
    brand_id_fk,
    category_id_fk,
    start_date,
    end_date,
    is_current
  )
  values select 
    max(product_id_pk_sk) + 1,
    @product_id,
    @product_name,
    @brand_id,
    @category_id,
    dateadd(second, 1, @end_date),
    null,
    1
  from scd2_production_products;
end;
go

-- usp_insert_dim_production_products

drop proc if exists dbo.usp_insert_dim_production_products
go

create proc dbo.usp_insert_dim_production_products
  @product_id int,
  @product_name varchar(255),
  @brand_id int,
  @category_id int
as
begin
  set nocount on;

  -- insert new data
  insert into scd2_production_products (
    product_id_pk_sk,
    product_id_nk,
    product_name,
    brand_id_fk,
    category_id_fk,
    start_date
  )
  select
    max(product_id_pk_sk) + 1,
    @product_id,
    @product_name,
    @brand_id,
    @category_id,
    getdate()
  from
    scd2_production_products;
end;
go

-- Testing
select * from scd2_production_products
exec dbo.usp_insert_dim_production_products 9999, 'Movsisyans ultimate product', 9, 6
select * from scd2_production_products

exec dbo.usp_update_dim_production_products 9999, 'Movsisyans ultimate product', 9, 7, '2023-04-24'

/* Exercise 20 (9 points)
Design a slowly changing dimension type 3 table based on the 
[BikeStores].[sales].[staffs] table by storing the previous 2 e-mails of 
each employee. Make sure to have all the possible keys in your dimension table.
Design a procedure for populating the newly created dimension table. Make sure to pick up all the necessary
surrogate keys from other dimension tables. Do not forget to test the newly created procedure.
*/