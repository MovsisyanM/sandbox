CREATE TABLE youtube_user(
	id INTEGER PRIMARY KEY,
	email VARCHAR(100) NOT NULL,
	password CHAR(32) NOT NULL
);


--
-- User passwords should not be stored in plain text. We will use md5 hashing algorithm.
-- md5("123") -->202cb962ac59075b964b07152d234b70 
-- md5("123456") -->e10adc3949ba59abbe56e057f20f883e 
-- Generating random md5 hash values


SELECT MD5(CEIL(RANDOM() * 1000)::text);

--

INSERT INTO youtube_user
VALUES (
		1,
		'user_1@test.com',
		MD5(CEIL(RANDOM() * 1000)::text)
	),
	(
		2,
		'user_2@test.com',
		MD5(CEIL(RANDOM() * 1000)::text)
	);


SELECT generate_series(1, 10) AS user_id,
	'hello';

SELECT generate_series(1, 10) AS id,
	CONCAT('user_', generate_series(1, 10), '@test.com') AS email,
	MD5(CEIL(RANDOM() * 1000)::text) AS password;

SELECT CONCAT('user_', generate_series(1, 10), '@test.com') AS email;

-- INSERT INTO youtube_user VALUES ( (), (), (), ... )
-- Delete previous data


TRUNCATE youtube_user;


INSERT INTO youtube_user
VALUES (
		generate_series(1, 10),
		CONCAT('user_', generate_series(1, 10), '@test.com'),
		MD5(CEIL(RANDOM() * 1000)::text)
	);


-- 

-- ASSIGNMENT STARTS HERE

-- 1. Create the relational table for Videos and populate 
-- it with random video data.

CREATE TABLE youtube_video(
	id INTEGER PRIMARY KEY,
	url VARCHAR(100) UNIQUE NOT NULL,
	title VARCHAR(100)
);

truncate youtube_video;

INSERT INTO youtube_video
VALUES (
		generate_series(1, 100),
		MD5(FLOOR(RANDOM() * 10000000)::text),
		CONCAT(
			'Top ',
			generate_series(1, 100),
			' anime moments.'
		)
);


select *
from youtube_video;

-- 2. Create the many-to-many table for "likes" 
-- relationship and populate it with random data as well.
-- Upload your solution SQL file.

drop table if exists likes;

CREATE TABLE likes (
	user_id INT references youtube_user(id),
	video_id INT references youtube_video(id),
	time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	primary key (user_id, video_id)
);

insert into likes
values (CEIL(RANDOM() * 10), FLOOR(RANDOM() * 10));


-- Sample output from likes table
--
-- "user_id","video_id","time"
-- 5,9,"2022-03-27 18:09:05.805522"
-- 1,1,"2022-03-27 18:09:10.357835"
-- 9,5,"2022-03-27 18:09:11.979223"
-- 1,8,"2022-03-27 18:09:15.308671"
-- 5,4,"2022-03-27 18:09:16.869247"
-- 8,9,"2022-03-27 18:09:17.951456"
-- 8,3,"2022-03-27 18:09:19.264062"
-- 1,5,"2022-03-27 18:09:22.420659"
-- 6,5,"2022-03-27 18:09:25.241773"
-- 2,2,"2022-03-27 18:09:28.044291"
-- 8,8,"2022-03-27 18:09:31.891217"
-- 5,6,"2022-03-27 18:09:33.857056"
-- 7,3,"2022-03-27 18:09:35.283913"
-- 9,3,"2022-03-27 18:09:36.754872"