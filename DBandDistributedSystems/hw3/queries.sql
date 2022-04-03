-- a
select email, video_url, string_agg(category_name, ', ') as categories
from youtube_user 
join youtube_video 
    on youtube_user.id = youtube_video.uploader_id
join video_in_category 
    on youtube_video.id = video_in_category.video_id
join categories 
    on video_in_category.category_id = categories.category_id
where email = 'user_1@test.com'
group by email, video_url;


-- b
select id 
from youtube_video 
where id in (
    select video_id 
    from video_in_category 
    where category_id = 4
) and id in (
    select video_id 
    from video_in_category 
    where category_id = 5
);

-- c
select email, count(video_url) as num_videos
from youtube_user
join youtube_video
    on youtube_user.id = youtube_video.uploader_id
join video_in_category
    on youtube_video.id = video_in_category.video_id
join categories
    on video_in_category.category_id = categories.category_id
where video_in_category.category_id = 3
group by email
order by num_videos desc
limit 1;


-- d

-- adding a user that has no videos
insert into youtube_user (id, email, password)
values (11, 'bob@test.com', MD5('bob'));

select email, count(video_url) as num_videos
from youtube_user
left join youtube_video
    on youtube_user.id = youtube_video.uploader_id
group by email;
 

-- e
select categories.category_name, count(video_in_category.category_id) as num_videos
from video_in_category
join categories on video_in_category.category_id = categories.category_id
group by categories.category_name
order by num_videos desc
limit 1;