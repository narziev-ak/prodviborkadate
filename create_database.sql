-- Создание таблиц


-- Жанры
CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Исполнители
CREATE TABLE artists (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Альбомы
CREATE TABLE albums (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INTEGER NOT NULL
);

-- Треки
CREATE TABLE tracks (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    duration INTEGER NOT NULL,  -- длительность в секундах
    album_id INTEGER NOT NULL REFERENCES albums(id) ON DELETE CASCADE
);

-- Сборники (новое)
CREATE TABLE compilations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    release_year INTEGER NOT NULL
);

-- ============================================
-- Связующие таблицы (многие-ко-многим)
-- ============================================

-- Связь исполнителей и жанров (многие-ко-многим)
CREATE TABLE artist_genres (
    artist_id INTEGER NOT NULL REFERENCES artists(id) ON DELETE CASCADE,
    genre_id INTEGER NOT NULL REFERENCES genres(id) ON DELETE CASCADE,
    PRIMARY KEY (artist_id, genre_id)
);

-- Связь альбомов и исполнителей (многие-ко-многим)
CREATE TABLE album_artists (
    album_id INTEGER NOT NULL REFERENCES albums(id) ON DELETE CASCADE,
    artist_id INTEGER NOT NULL REFERENCES artists(id) ON DELETE CASCADE,
    PRIMARY KEY (album_id, artist_id)
);

-- Связь сборников и треков (многие-ко-многим)
CREATE TABLE compilation_tracks (
    compilation_id INTEGER NOT NULL REFERENCES compilations(id) ON DELETE CASCADE,
    track_id INTEGER NOT NULL REFERENCES tracks(id) ON DELETE CASCADE,
    track_number INTEGER NOT NULL,  -- порядок трека в сборнике
    PRIMARY KEY (compilation_id, track_id)
);

-- ============================================
-- Создание индексов для оптимизации запросов
-- ============================================

CREATE INDEX idx_tracks_album_id ON tracks(album_id);
CREATE INDEX idx_artist_genres_artist ON artist_genres(artist_id);
CREATE INDEX idx_artist_genres_genre ON artist_genres(genre_id);
CREATE INDEX idx_album_artists_album ON album_artists(album_id);
CREATE INDEX idx_album_artists_artist ON album_artists(artist_id);
CREATE INDEX idx_compilation_tracks_compilation ON compilation_tracks(compilation_id);
CREATE INDEX idx_compilation_tracks_track ON compilation_tracks(track_id);
