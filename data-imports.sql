-- run this file for data importing
-- make sure files are in their correct directory before running

-- method to prevent adding duplicate rows
-- create and import data into temp tables
-- then insert non-duplicate rows from temp tables to physical tables
CREATE TEMP TABLE temp_profiles (
  join_date date NOT NULL,
  username text PRIMARY KEY,
  first_name text,
  last_name text,
  email text,
  user_location text,
  website text,
  bio text,
  pronoun text,
  favorite_films text
);

CREATE TEMP TABLE temp_watched (
  username text NOT NULL REFERENCES temp_profiles (username),
  watch_date date NOT NULL,
  title text NOT NULL,
  release_year smallint NOT NULL,
  page_link text PRIMARY KEY
);

CREATE TEMP TABLE temp_watchlist (
  username text NOT NULL REFERENCES temp_profiles (username),
  add_date date NOT NULL,
  title text NOT NULL,
  release_year smallint NOT NULL,
  page_link text PRIMARY KEY
);

CREATE TEMP TABLE temp_reviews (
  username text NOT NULL REFERENCES temp_profiles (username),
  watch_date date,
  title text NOT NULL,
  release_year smallint NOT NULL,
  page_link text PRIMARY KEY,
  rating numeric(2, 1),
  rewatch text,
  review text NOT NULL,
  tags text,
  log_date date
);

CREATE TEMP TABLE temp_ratings (
  username text NOT NULL REFERENCES temp_profiles (username),
  watch_date date NOT NULL,
  title text NOT NULL,
  release_year smallint NOT NULL,
  page_link text PRIMARY KEY,
  rating numeric(2, 1) NOT NULL
);

CREATE TEMP TABLE temp_diary (
  username text NOT NULL REFERENCES temp_profiles (username),
  watch_date date NOT NULL,
  title text NOT NULL,
  release_year smallint NOT NULL,
  page_link text PRIMARY KEY,
  rating numeric(2, 1),
  rewatch text,
  tags text,
  log_date date NOT NULL
);

CREATE TEMP TABLE temp_user_comments (
  username text NOT NULL REFERENCES temp_profiles (username),
  posting_date date NOT NULL,
  page_link text NOT NULL,
  comment_data text NOT NULL
);

CREATE TEMP TABLE temp_liked_films (
  username text NOT NULL REFERENCES temp_profiles (username),
  watch_date date,
  title text NOT NULL,
  release_year smallint NOT NULL,
  page_link text PRIMARY KEY
);

CREATE TEMP TABLE temp_liked_reviews (
  username text NOT NULL REFERENCES temp_profiles (username),
  liked_date date NOT NULL,
  page_link text PRIMARY KEY
);

-- imports for bilal
COPY temp_profiles FROM 'C:/bilal/profile.csv' WITH (FORMAT CSV, HEADER);
COPY temp_watched FROM 'C:/bilal/watched.csv' WITH (FORMAT CSV, HEADER);
COPY temp_watchlist FROM 'C:/bilal/watchlist.csv' WITH (FORMAT CSV, HEADER);
COPY temp_reviews FROM 'C:/bilal/reviews.csv' WITH (FORMAT CSV, HEADER);
COPY temp_ratings FROM 'C:/bilal/ratings.csv' WITH (FORMAT CSV, HEADER);
COPY temp_diary FROM 'C:/bilal/diary.csv' WITH (FORMAT CSV, HEADER);
COPY temp_user_comments FROM 'C:/bilal/comments.csv' WITH (FORMAT CSV, HEADER);
COPY temp_liked_films FROM 'C:/bilal/likes/films.csv' WITH (FORMAT CSV, HEADER);
COPY temp_liked_reviews FROM 'C:/bilal/likes/reviews.csv' WITH (FORMAT CSV, HEADER);

INSERT INTO profiles
SELECT *
FROM temp_profiles
WHERE NOT EXISTS (
  SELECT 1
  FROM profiles
  WHERE profiles.username = temp_profiles.username
);

INSERT INTO watched
SELECT *
FROM temp_watched
WHERE NOT EXISTS (
  SELECT 1
  FROM watched
  WHERE watched.page_link = temp_watched.page_link
);

INSERT INTO watchlist
SELECT *
FROM temp_watchlist
WHERE NOT EXISTS (
  SELECT 1
  FROM watchlist
  WHERE watchlist.page_link = temp_watchlist.page_link
);

INSERT INTO reviews
SELECT *
FROM temp_reviews
WHERE NOT EXISTS (
  SELECT 1
  FROM reviews
  WHERE reviews.page_link = temp_reviews.page_link
);

INSERT INTO ratings
SELECT *
FROM temp_ratings
WHERE NOT EXISTS (
  SELECT 1
  FROM ratings
  WHERE ratings.page_link = temp_ratings.page_link
);

INSERT INTO diary
SELECT *
FROM temp_diary
WHERE NOT EXISTS (
  SELECT 1
  FROM diary
  WHERE diary.page_link = temp_diary.page_link
);

INSERT INTO user_comments
SELECT *
FROM temp_user_comments
WHERE NOT EXISTS (
  SELECT 1
  FROM user_comments
  WHERE user_comments.username = temp_user_comments.username
    AND user_comments.posting_date = temp_user_comments.posting_date
	AND user_comments.page_link = temp_user_comments.page_link
	AND user_comments.comment_data = temp_user_comments.comment_data
);

INSERT INTO liked_films
SELECT *
FROM temp_liked_films
WHERE NOT EXISTS (
  SELECT 1
  FROM liked_films
  WHERE liked_films.page_link = temp_liked_films.page_link
);

INSERT INTO liked_reviews
SELECT *
FROM temp_liked_reviews
WHERE NOT EXISTS (
  SELECT 1
  FROM liked_reviews
  WHERE liked_reviews.page_link = temp_liked_reviews.page_link
);

DROP TABLE temp_watched;
DROP TABLE temp_watchlist;
DROP TABLE temp_reviews;
DROP TABLE temp_ratings;
DROP TABLE temp_diary;
DROP TABLE temp_user_comments;
DROP TABLE temp_liked_films;
DROP TABLE temp_liked_reviews;
DROP TABLE temp_profiles;
