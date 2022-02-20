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

