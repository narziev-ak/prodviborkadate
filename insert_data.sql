-- Задание 1: Заполнение базы данных

-- ============================================
-- Жанры (не менее 3)
-- ============================================
INSERT INTO genres
    (name)
VALUES
    ('Рок'),
    ('Поп'),
    ('Джаз'),
    ('Электроника');

-- ============================================
-- Исполнители (не менее 4)
-- ============================================
INSERT INTO artists
    (name)
VALUES
    ('Queen'),
    ('Michael Jackson'),
    ('Miles Davis'),
    ('Daft Punk'),
    ('The Beatles');

-- ============================================
-- Альбомы (не менее 3)
-- ============================================
INSERT INTO albums
    (title, release_year)
VALUES
    ('A Night at the Opera', 1975),
    ('Thriller', 1982),
    ('Kind of Blue', 1959),
    ('Random Access Memories', 2013),
    ('Abbey Road', 2020);

-- ============================================
-- Треки (не менее 6)
INSERT INTO tracks
    (title, duration, album_id)
VALUES
    ('Bohemian Rhapsody', 354, 1),
    -- 5:54
    ('Another One Bites the Dust', 215, 1),
    -- 3:35
    ('Billie Jean', 294, 2),
    -- 4:54
    ('Thriller', 357, 2),
    -- 5:57
    ('So What', 562, 3),
    -- 9:22
    ('Blue in Green', 337, 3),
    -- 5:37
    ('Get Lucky', 248, 4),
    -- 4:08
    ('Instant Crush', 337, 4),
    -- 5:37
    ('Come Together', 259, 5),
    -- 4:19
    ('Something', 182, 5),
    -- 3:02 (самый короткий для задания 4.3)
    ('My Heart Will Go On', 280, 2);
-- 4:40 (содержит слово "My" для задания 2.5)

-- ============================================
-- Сборники (не менее 4)
-- ============================================
INSERT INTO compilations
    (name, release_year)
VALUES
    ('Greatest Hits', 2018),
    ('The Essential Collection', 2019),
    ('Jazz Classics', 2020),
    ('My Favourite Songs', 2021),
    ('Best of 2020s', 2022);

-- ============================================
-- Связь исполнителей с жанрами (artist_genres)
-- ============================================
INSERT INTO artist_genres
    (artist_id, genre_id)
VALUES
    (1, 1),
    -- Queen -> Рок
    (2, 2),
    -- Michael Jackson -> Поп
    (3, 3),
    -- Miles Davis -> Джаз
    (4, 4),
    -- Daft Punk -> Электроника
    (5, 1),
    -- The Beatles -> Рок
    (2, 1);
-- Michael Jackson -> Рок (мульти-жанровый)

-- ============================================
-- Связь альбомов и исполнителей (album_artists)
-- ============================================
INSERT INTO album_artists
    (album_id, artist_id)
VALUES
    (1, 1),
    -- A Night at the Opera -> Queen
    (2, 2),
    -- Thriller -> Michael Jackson
    (3, 3),
    -- Kind of Blue -> Miles Davis
    (4, 4),
    -- Random Access Memories -> Daft Punk
    (5, 5),
    -- Abbey Road -> The Beatles
    (1, 5),
    -- A Night at the Opera -> The Beatles (совместный альбом - Рок)
    (2, 1);
-- Thriller -> Queen (совместный альбом - Рок и Поп)

-- ============================================
-- Связь сборников и треков (compilation_tracks)
-- ============================================
INSERT INTO compilation_tracks
    (compilation_id, track_id, track_number)
VALUES
    -- Greatest Hits (2018)
    (1, 1, 1),
    (1, 3, 2),
    (1, 5, 3),

    -- The Essential Collection (2019)
    (2, 2, 1),
    (2, 4, 2),
    (2, 7, 3),

    -- Jazz Classics (2020)
    (3, 5, 1),
    (3, 6, 2),

    -- My Favourite Songs (2021)
    (4, 1, 1),
    (4, 3, 2),
    (4, 8, 3),
    (4, 10, 4),
    (4, 12, 5),
    -- My Heart Will Go On (track_id = 12)

    -- Best of 2020s (2022)
    (5, 9, 1),
    (5, 10, 2);
