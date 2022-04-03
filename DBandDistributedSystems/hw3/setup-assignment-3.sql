create table youtube_user
(
    id       integer      not null
        constraint youtube_user_pkey
            primary key,
    email    varchar(100) not null,
    password char(32)     not null
);


INSERT INTO public.youtube_user (id, email, password)
VALUES (1, 'user_1@test.com', 'cdc0d6e63aa8e41c89689f54970bb35f');
INSERT INTO public.youtube_user (id, email, password)
VALUES (2, 'user_2@test.com', 'd81f9c1be2e08964bf9f24b15f0e4900');
INSERT INTO public.youtube_user (id, email, password)
VALUES (3, 'user_3@test.com', '3cec07e9ba5f5bb252d13f5f431e4bbb');
INSERT INTO public.youtube_user (id, email, password)
VALUES (4, 'user_4@test.com', '24681928425f5a9133504de568f5f6df');
INSERT INTO public.youtube_user (id, email, password)
VALUES (5, 'user_5@test.com', '3a835d3215755c435ef4fe9965a3f2a0');
INSERT INTO public.youtube_user (id, email, password)
VALUES (6, 'user_6@test.com', '8d6dc35e506fc23349dd10ee68dabb64');
INSERT INTO public.youtube_user (id, email, password)
VALUES (7, 'user_7@test.com', 'a8baa56554f96369ab93e4f3bb068c22');
INSERT INTO public.youtube_user (id, email, password)
VALUES (8, 'user_8@test.com', '08419be897405321542838d77f855226');
INSERT INTO public.youtube_user (id, email, password)
VALUES (9, 'user_9@test.com', 'd947bf06a885db0d477d707121934ff8');
INSERT INTO public.youtube_user (id, email, password)
VALUES (10, 'user_10@test.com', '7b13b2203029ed80337f27127a9f1d28');

create table youtube_video
(
    id          integer      not null
        constraint youtube_video_pkey
            primary key,
    video_url   varchar(100) not null
        constraint youtube_video_video_url_key
            unique,
    title       varchar(500),
    uploader_id integer      not null
        constraint youtube_video_uploader_id_fkey
            references youtube_user,
    upload_time timestamp default now(),
    duration    integer   default ceil((random() * (60)::double precision))
);

INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (1, 'http://youtube.com/v?=c4ca4238a0b923820dcc509a6f75849b', 'Title 73af1', 3, '2022-03-29 05:32:46.039905',
        51);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (2, 'http://youtube.com/v?=c81e728d9d4c2f636f067f89cc14862c', 'Title ba222', 5, '2022-03-29 05:32:46.039905',
        18);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (3, 'http://youtube.com/v?=eccbc87e4b5ce2fe28308fd9f2a7baf3', 'Title 45bc6', 6, '2022-03-29 05:32:46.039905', 2);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (4, 'http://youtube.com/v?=a87ff679a2f3e71d9181a67b7542122c', 'Title 91809', 1, '2022-03-29 05:32:46.039905',
        16);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (5, 'http://youtube.com/v?=e4da3b7fbbce2345d7772b0674a318d5', 'Title d0f9e', 2, '2022-03-29 05:32:46.039905', 9);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (6, 'http://youtube.com/v?=1679091c5a880faf6fb5e6087eb1b2dc', 'Title 6432a', 3, '2022-03-29 05:32:46.039905', 9);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (7, 'http://youtube.com/v?=8f14e45fceea167a5a36dedd4bea2543', 'Title 6f6e1', 9, '2022-03-29 05:32:46.039905',
        20);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (8, 'http://youtube.com/v?=c9f0f895fb98ab9159f51fd0297e236d', 'Title 7e7d3', 2, '2022-03-29 05:32:46.039905',
        21);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (9, 'http://youtube.com/v?=45c48cce2e2d7fbdea1afc51c7c6ad26', 'Title ae07e', 2, '2022-03-29 05:32:46.039905',
        26);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (10, 'http://youtube.com/v?=d3d9446802a44259755d38e6d163e820', 'Title 8daf2', 8, '2022-03-29 05:32:46.039905',
        17);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (11, 'http://youtube.com/v?=6512bd43d9caa6e02c990b0a82652dca', 'Title d1b60', 10, '2022-03-29 05:32:46.039905',
        9);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (12, 'http://youtube.com/v?=c20ad4d76fe97759aa27a0c99bff6710', 'Title 90aca', 5, '2022-03-29 05:32:46.039905',
        28);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (13, 'http://youtube.com/v?=c51ce410c124a10e0db5e4b97fc2af39', 'Title 006ce', 10, '2022-03-29 05:32:46.039905',
        44);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (14, 'http://youtube.com/v?=aab3238922bcc25a6f606eb525ffdc56', 'Title d2f2a', 9, '2022-03-29 05:32:46.039905',
        19);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (15, 'http://youtube.com/v?=9bf31c7ff062936a96d3c8bd1f8f2ff3', 'Title 3c85c', 2, '2022-03-29 05:32:46.039905',
        15);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (16, 'http://youtube.com/v?=c74d97b01eae257e44aa9d5bade97baf', 'Title d789d', 4, '2022-03-29 05:32:46.039905',
        28);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (17, 'http://youtube.com/v?=70efdf2ec9b086079795c442636b55fb', 'Title a3ce4', 4, '2022-03-29 05:32:46.039905',
        11);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (18, 'http://youtube.com/v?=6f4922f45568161a8cdf4ad2299f6d23', 'Title 14138', 2, '2022-03-29 05:32:46.039905',
        22);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (19, 'http://youtube.com/v?=1f0e3dad99908345f7439f8ffabdffc4', 'Title cc0c8', 6, '2022-03-29 05:32:46.039905',
        15);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (20, 'http://youtube.com/v?=98f13708210194c475687be6106a3b84', 'Title e91ee', 9, '2022-03-29 05:32:46.039905',
        60);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (21, 'http://youtube.com/v?=3c59dc048e8850243be8079a5c74d079', 'Title 69455', 8, '2022-03-29 05:32:46.039905',
        33);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (22, 'http://youtube.com/v?=b6d767d2f8ed5d21a44b0e5886680cb9', 'Title 6ad07', 7, '2022-03-29 05:32:46.039905',
        41);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (23, 'http://youtube.com/v?=37693cfc748049e45d87b8c7d8b9aacd', 'Title 58fea', 5, '2022-03-29 05:32:46.039905',
        25);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (24, 'http://youtube.com/v?=1ff1de774005f8da13f42943881c655f', 'Title a5e47', 2, '2022-03-29 05:32:46.039905',
        48);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (25, 'http://youtube.com/v?=8e296a067a37563370ded05f5a3bf3ec', 'Title c641c', 3, '2022-03-29 05:32:46.039905',
        11);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (26, 'http://youtube.com/v?=4e732ced3463d06de0ca9a15b6153677', 'Title 55542', 6, '2022-03-29 05:32:46.039905',
        19);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (27, 'http://youtube.com/v?=02e74f10e0327ad868d138f2b4fdd6f0', 'Title 19a61', 4, '2022-03-29 05:32:46.039905',
        26);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (28, 'http://youtube.com/v?=33e75ff09dd601bbe69f351039152189', 'Title 8c911', 8, '2022-03-29 05:32:46.039905',
        26);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (29, 'http://youtube.com/v?=6ea9ab1baa0efb9e19094440c317e21b', 'Title d3b60', 1, '2022-03-29 05:32:46.039905',
        6);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (30, 'http://youtube.com/v?=34173cb38f07f89ddbebc2ac9128303f', 'Title 1255e', 10, '2022-03-29 05:32:46.039905',
        1);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (31, 'http://youtube.com/v?=c16a5320fa475530d9583c34fd356ef5', 'Title 873cb', 10, '2022-03-29 05:32:46.039905',
        2);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (32, 'http://youtube.com/v?=6364d3f0f495b6ab9dcf8d3b5c6e0b01', 'Title 25dd1', 7, '2022-03-29 05:32:46.039905',
        56);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (33, 'http://youtube.com/v?=182be0c5cdcd5072bb1864cdee4d3d6e', 'Title 2b084', 2, '2022-03-29 05:32:46.039905',
        19);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (34, 'http://youtube.com/v?=e369853df766fa44e1ed0ff613f563bd', 'Title 66591', 3, '2022-03-29 05:32:46.039905',
        4);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (35, 'http://youtube.com/v?=1c383cd30b7c298ab50293adfecb7b18', 'Title 83081', 10, '2022-03-29 05:32:46.039905',
        12);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (36, 'http://youtube.com/v?=19ca14e7ea6328a42e0eb13d585e4c22', 'Title 2189b', 6, '2022-03-29 05:32:46.039905',
        27);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (37, 'http://youtube.com/v?=a5bfc9e07964f8dddeb95fc584cd965d', 'Title 26df4', 3, '2022-03-29 05:32:46.039905',
        13);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (38, 'http://youtube.com/v?=a5771bce93e200c36f7cd9dfd0e5deaa', 'Title 7ccad', 4, '2022-03-29 05:32:46.039905',
        32);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (39, 'http://youtube.com/v?=d67d8ab4f4c10bf22aa353e27879133c', 'Title 2ad33', 10, '2022-03-29 05:32:46.039905',
        48);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (40, 'http://youtube.com/v?=d645920e395fedad7bbbed0eca3fe2e0', 'Title a73cf', 2, '2022-03-29 05:32:46.039905',
        38);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (41, 'http://youtube.com/v?=3416a75f4cea9109507cacd8e2f2aefc', 'Title 67a3f', 4, '2022-03-29 05:32:46.039905',
        48);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (42, 'http://youtube.com/v?=a1d0c6e83f027327d8461063f4ac58a6', 'Title 37047', 5, '2022-03-29 05:32:46.039905',
        57);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (43, 'http://youtube.com/v?=17e62166fc8586dfa4d1bc0e1742c08b', 'Title fe997', 9, '2022-03-29 05:32:46.039905',
        6);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (44, 'http://youtube.com/v?=f7177163c833dff4b38fc8d2872f1ec6', 'Title 0d116', 1, '2022-03-29 05:32:46.039905',
        32);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (45, 'http://youtube.com/v?=6c8349cc7260ae62e3b1396831a8398f', 'Title 8e792', 8, '2022-03-29 05:32:46.039905',
        15);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (46, 'http://youtube.com/v?=d9d4f495e875a2e075a1a4a6e1b9770f', 'Title b1491', 1, '2022-03-29 05:32:46.039905',
        20);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (47, 'http://youtube.com/v?=67c6a1e7ce56d3d6fa748ab6d9af3fd7', 'Title 23cc8', 3, '2022-03-29 05:32:46.039905',
        60);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (48, 'http://youtube.com/v?=642e92efb79421734881b53e1e1b18b6', 'Title f62fd', 1, '2022-03-29 05:32:46.039905',
        26);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (49, 'http://youtube.com/v?=f457c545a9ded88f18ecee47145a72c0', 'Title 991b1', 6, '2022-03-29 05:32:46.039905',
        42);
INSERT INTO public.youtube_video (id, video_url, title, uploader_id, upload_time, duration)
VALUES (50, 'http://youtube.com/v?=c0c7c76d30bd3dcaefc96f40275bdc0a', 'Title 6ebc3', 2, '2022-03-29 05:32:46.039905',
        14);

create table user_like_video
(
    user_id  integer   not null
        constraint user_like_video_user_id_fkey
            references youtube_user,
    video_id integer   not null
        constraint user_like_video_video_id_fkey
            references youtube_video,
    liked_at timestamp not null,
    constraint user_like_video_pkey
        primary key (user_id, video_id)
);


INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (1, 1, '2022-03-29 05:19:00.107297');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (1, 2, '2022-03-20 15:54:00.000000');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (10, 2, '2022-03-21 09:21:00.000000');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (1, 3, '2022-03-20 16:54:00.000000');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (9, 2, '2022-03-21 10:20:00.000000');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (7, 1, '2022-03-29 05:20:16.973565');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (7, 8, '2022-03-29 05:20:27.197072');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (6, 3, '2022-03-29 05:20:33.845904');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (4, 2, '2022-03-29 05:21:49.009804');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (1, 7, '2022-03-29 05:21:51.255841');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (2, 8, '2022-03-29 05:21:52.300073');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (4, 5, '2022-03-29 05:21:55.633558');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (2, 7, '2022-03-29 05:21:56.507697');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (1, 4, '2022-03-29 05:21:57.744445');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (10, 5, '2022-03-29 05:21:58.777181');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (9, 5, '2022-03-29 05:21:59.734560');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (8, 5, '2022-03-29 05:22:00.791404');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (4, 13, '2022-03-29 05:22:05.746107');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (9, 7, '2022-03-29 05:22:06.421023');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (4, 15, '2022-03-29 05:22:07.046895');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (3, 33, '2022-03-29 05:22:07.674520');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (6, 37, '2022-03-29 05:22:08.282919');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (8, 26, '2022-03-29 05:22:08.824572');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (5, 42, '2022-03-29 05:22:09.333404');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (4, 43, '2022-03-29 05:22:09.835462');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (10, 11, '2022-03-29 05:22:10.355634');
INSERT INTO public.user_like_video (user_id, video_id, liked_at)
VALUES (10, 14, '2022-03-29 05:22:10.897304');

