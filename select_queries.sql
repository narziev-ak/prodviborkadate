-- Задание 2: SELECT-запросы

-- 1. Название и продолжительность самого длительного трека.
SELECT title, duration
FROM tracks
ORDER BY duration DESC
LIMIT 1;

-- 2. Название треков, продолжительность которых не менее 3,5 минут (210 секунд).
SELECT title
FROM tracks
WHERE duration >= 210;

-- 3. Названия сборников, вышедших в период с 2018 по 2020 год включительно.
SELECT name
FROM compilations
WHERE release_year BETWEEN 2018 AND 2020;

-- 4. Исполнители, чьё имя состоит из одного слова.
SELECT name
FROM artists
WHERE name NOT LIKE '% %';

-- 5. Название треков, которые содержат слово «мой» или «my».
SELECT title
FROM tracks
WHERE title
ILIKE 'my %'
   OR title ILIKE '% my'
   OR title ILIKE '% my %'
   OR title ILIKE 'my'
   OR title ILIKE 'мой %'
   OR title ILIKE '% мой'
   OR title ILIKE '% мой %'
   OR title ILIKE 'мой';


-- Задание 3: SELECT-запросы

-- 1. Количество исполнителей в каждом жанре.
SELECT g.name AS genre, COUNT(ag.artist_id) AS artist_count
FROM genres g
    LEFT JOIN artist_genres ag ON g.id = ag.genre_id
GROUP BY g.name;

-- 2. Количество треков, вошедших в альбомы 2019–2020 годов.
SELECT COUNT(t.id) AS track_count
FROM tracks t
    JOIN albums a ON t.album_id = a.id
WHERE a.release_year BETWEEN 2019 AND 2020;

-- 3. Средняя продолжительность треков по каждому альбому.
SELECT a.title AS album, AVG(t.duration) AS avg_duration
FROM albums a
    JOIN tracks t ON a.id = t.album_id
GROUP BY a.title;

-- 4. Все исполнители, которые не выпустили альбомы в 2020 году.
SELECT name
FROM artists
WHERE id NOT IN (
    SELECT DISTINCT artist_id
FROM album_artists aa
    JOIN albums a ON aa.album_id = a.id
WHERE a.release_year = 2020
);

-- 5. Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).
-- Пример с исполнителем "Queen" (id = 1)
SELECT c.name
FROM compilations c
    JOIN compilation_tracks cp ON c.id = cp.compilation_id
    JOIN tracks t ON cp.track_id = t.id
    JOIN album_artists aa ON t.album_id = aa.album_id
WHERE aa.artist_id = 1;


-- Задание 4 (необязательное): SELECT-запросы

-- 1. Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
SELECT DISTINCT a.title AS album
FROM albums a
    JOIN album_artists aa ON a.id = aa.album_id
    JOIN artist_genres ag ON aa.artist_id = ag.artist_id
GROUP BY a.title, aa.artist_id
HAVING COUNT(DISTINCT ag.genre_id) > 1;

-- 2. Наименования треков, которые не входят в сборники.
SELECT t.title
FROM tracks t
WHERE t.id NOT IN (
    SELECT DISTINCT track_id
FROM compilation_tracks
);

-- 3. Исполнитель или исполнители, написавшие самый короткий по продолжительности трек.
SELECT DISTINCT ar.name AS artist
FROM artists ar
    JOIN album_artists aa ON ar.id = aa.artist_id
    JOIN tracks t ON aa.album_id = t.album_id
WHERE t.duration = (
    SELECT MIN(duration)
FROM tracks
);

-- 4. Названия альбомов, содержащих наименьшее количество треков.
SELECT a.title AS album, COUNT(t.id) AS track_count
FROM albums a
    LEFT JOIN tracks t ON a.id = t.album_id
GROUP BY a.title
HAVING COUNT(t.id) = (
    SELECT MIN(track_count)
FROM (
        SELECT COUNT(*) AS track_count
    FROM tracks
    GROUP BY album_id
    ) AS subquery
);
