-- initial creation of schema
-- may need to add more tables for orphaned, deleted, liked, and list items
CREATE TABLE profile (
  join_date date,
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

CREATE TABLE watched (
  username text REFERENCES profile (username),
  watch_date date,
  title text,
  release_year smallint,
  page_link text
);

CREATE TABLE watchlist (
  username text REFERENCES profile (username),
  watch_date date,
  title text,
  release_year smallint,
  page_link text
);

CREATE TABLE reviews (
  username text REFERENCES profile (username),
  watch_date date,
  title text,
  release_year smallint,
  page_link text,
  rating numeric(2, 1),
  rewatch text,
  review text,
  tags text,
  log_date date
);

CREATE TABLE ratings (
  username text REFERENCES profile (username),
  watch_date date,
  title text,
  release_year smallint,
  page_link text,
  rating numeric(2, 1)
);

CREATE TABLE diary (
  username text REFERENCES profile (username),
  watch_date date,
  title text,
  release_year smallint,
  page_link text,
  rating numeric(2, 1),
  rewatch text,
  tags text,
  log_date date
);

CREATE TABLE user_comments (
  username text REFERENCES profile (username),
  posting_date date,
  page_link text,
  comment_data text
);

CREATE TABLE liked_films (
  watch_date date,
  title text,
  release_year smallint,
  page_link text
);

CREATE TABLE liked_reviews (
  liked_date date,
  page_link text
);

-- imports for bilal
-- need to repeat for each individual user
COPY profile
FROM 'C:/bilal/profile.csv'
WITH (FORMAT CSV, HEADER);

COPY watched
FROM 'C:/bilal/watched.csv'
WITH (FORMAT CSV, HEADER);

COPY watchlist
FROM 'C:/bilal/watchlist.csv'
WITH (FORMAT CSV, HEADER);

COPY reviews
FROM 'C:/bilal/reviews.csv'
WITH (FORMAT CSV, HEADER);

COPY ratings
FROM 'C:/bilal/ratings.csv'
WITH (FORMAT CSV, HEADER);

COPY diary
FROM 'C:/bilal/diary.csv'
WITH (FORMAT CSV, HEADER);

COPY user_comments
FROM 'C:/bilal/comments.csv'
WITH (FORMAT CSV, HEADER);

COPY liked_films
FROM 'C:/bilal/likes/films.csv'
WITH (FORMAT CSV, HEADER);

COPY liked_reviews
FROM 'C:/bilal/likes/reviews.csv'
WITH (FORMAT CSV, HEADER);