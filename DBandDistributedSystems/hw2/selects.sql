-- Excercise 2

select title 
from course 
where course_id in (
    select course_id 
    from prereq 
    where prereq_id = 'CS-101'
);

select name 
from instructor
where id in (
    select distinct id
    from teaches
    where year = '2018'
    and semester = 'Spring'
);

select name
from student
where id in (
    select distinct id
    from takes
    where course_id in (
        select course_id 
        from takes 
        where id = '12345'));


-- Excercise 4
drop table if exists "User", "Phone", "Address";

create table "Address"(
    address_id serial primary key,
    city varchar(20),
    street varchar(40),
    aptNo int
);

create table "User"(
    user_id serial primary key,
    email varchar(55) unique,
    fullname varchar(40),
    address_id serial references "Address"(address_id)
);

create table "Phone"(
    user_id serial not null references "User"(user_id),
    number varchar(16) primary key
);

insert into "Address"(city, street, aptNo)
values ('Yerevan', '7th Sky', 42);
insert into "Address"(city, street, aptNo)
values ('Yerevan', 'Imagination Ave.', 3);

insert into "User"(email, fullname, address_id) 
values ('mher@movsisyan.info', 'Mher Movsisyan', 1);
insert into "User"(email, fullname, address_id) 
values ('bob@gmail.com', 'Bob Buildovich', 2);
insert into "User"(email, fullname, address_id) 
values ('bubert@gmail.com', 'Bubert Scareman', 2);

insert into "Phone"(user_id, number)
values (1, '+374412023222');
insert into "Phone"(user_id, number)
values (2, '+37477060172');

-- Exercise 4.b
-- Find the users that live in the same city.
select * 
from "User"
where address_id in (
    select address_id
    from (
            select city, count(city)
            from "Address"
            group by city
        ) cityCounts 
    inner join "Address" 
        on "Address".city = cityCounts.city
    where cityCounts.count > 1
);


-- Excercise 4.c
-- Find the users that live in Yerevan.
select * 
from "User"
where "User".address_id in (
    select "Address".address_id
    from "Address"
    where "Address".city = 'Yerevan'
);



