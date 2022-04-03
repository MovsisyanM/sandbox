drop table if exists user_watched_video;

create table user_watched_video(
    id serial primary key,
    user_id int not null,
    video_id int not null,
    foreign key (user_id) references youtube_user(id),
    foreign key (video_id) references youtube_video(id)
);

insert into user_watched_video (user_id, video_id)
values (1, 1), (1, 2), (2, 1);

create or replace view Num_of_videos as (
    select email,
        count(video_url) as uploaded_videos
    from youtube_user
    left join youtube_video
        on youtube_user.id = youtube_video.uploader_id
    group by email);


create or replace view Num_of_watchers as (
    select distinct email, count(video_id) as watchers
    from youtube_user
    left join user_watched_video
        on youtube_user.id = user_watched_video.user_id
    group by email);


create or replace view User_Stats as (
    select num_of_videos.email, 
        uploaded_videos, 
        watchers
    from num_of_videos
    join num_of_watchers
        on num_of_videos.email = num_of_watchers.email);