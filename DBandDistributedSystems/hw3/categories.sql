drop table if exists categories, video_in_category cascade;

create table categories(
    category_id int primary key,
    category_name varchar(20) not null
);

create table video_in_category(
    video_id int not null,
    category_id int not null,
    foreign key (video_id) references youtube_video(id),
    foreign key (category_id) references categories(category_id),
    primary key (video_id, category_id)
);

insert into categories (category_id, category_name)
values (1, 'Education'),
       (2, 'Entertainment'),
       (3, 'Nature'),
       (4, 'Pet'),
       (5, 'Cat'),
       (6, 'Technology');

insert into video_in_category (video_id, category_id)
values (generate_series(1, 50), ceil(random() * 4));

-- run it the second time to have videos with multiple categories
insert into video_in_category (video_id, category_id)
values (generate_series(1, 20), 5);