drop table youtube_user, youtube_video;

create table youtube_user (
    email varchar(50) primary key,
    fullname varchar(50) default 'empty',
    registeredOn date default CURRENT_DATE
);

insert into youtube_user (email, fullname) 
values ('mher2@movsisyan.info', 'Mher2 Movsisyan');

create table youtube_video (
    url varchar(30),
    title varchar(30),
    uploader_id VARCHAR(50) REFERENCES youtube_user(email),
    numbers_watched int 
);

insert into youtube_video values 
('tttt', 'rick roll', 'mher2@movsisyan.info');

