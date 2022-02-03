-- create a table named test_table that has an incrementing id
CREATE TABLE test_table_3 (
    id serial PRIMARY KEY,
    name VARCHAR(20)
);

-- Language: sql
-- insert a row into test_table
insert into test_table (name) values ('two');


-- Language: sql
select * from test_table