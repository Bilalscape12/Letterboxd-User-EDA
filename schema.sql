-- dropping and creation of tables
-- may need to add more tables for orphaned, deleted, liked, and list items
DROP TABLE IF EXISTS diary;
DROP TABLE IF EXISTS watched;
DROP TABLE IF EXISTS watchlist;
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS user_comments;
DROP TABLE IF EXISTS liked_films;
DROP TABLE IF EXISTS liked_reviews;
DROP TABLE IF EXISTS profiles;

CREATE TABLE profiles (
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

CREATE TABLE watched (
  username text NOT NULL REFERENCES profiles (username),
  watch_date date NOT NULL,
  title text NOT NULL,
  release_year smallint,
  page_link text NOT NULL,
  PRIMARY KEY (username, page_link)
);

CREATE TABLE watchlist (
  username text NOT NULL REFERENCES profiles (username),
  add_date date NOT NULL,
  title text NOT NULL,
  release_year smallint,
  page_link text NOT NULL,
  PRIMARY KEY (username, page_link)
);

CREATE TABLE reviews (
  username text NOT NULL REFERENCES profiles (username),
  watch_date date,
  title text NOT NULL,
  release_year smallint,
  page_link text NOT NULL,
  rating numeric(2, 1),
  rewatch text,
  review text NOT NULL,
  tags text,
  log_date date,
  PRIMARY KEY (username, page_link)
);

CREATE TABLE ratings (
  username text NOT NULL REFERENCES profiles (username),
  watch_date date NOT NULL,
  title text NOT NULL,
  release_year smallint,
  page_link text NOT NULL,
  rating numeric(2, 1) NOT NULL,
  PRIMARY KEY (username, page_link)
);

CREATE TABLE diary (
  username text NOT NULL REFERENCES profiles (username),
  watch_date date NOT NULL,
  title text NOT NULL,
  release_year smallint,
  page_link text NOT NULL,
  rating numeric(2, 1),
  rewatch text,
  tags text,
  log_date date NOT NULL,
  PRIMARY KEY (username, page_link)
);

CREATE TABLE user_comments (
  username text NOT NULL REFERENCES profiles (username),
  posting_date date NOT NULL,
  page_link text NOT NULL,
  comment_data text NOT NULL
);

CREATE TABLE liked_films (
  username text NOT NULL REFERENCES profiles (username),
  watch_date date,
  title text NOT NULL,
  release_year smallint,
  page_link text NOT NULL,
  PRIMARY KEY (username, page_link)
);

CREATE TABLE liked_reviews (
  username text NOT NULL REFERENCES profiles (username),
  liked_date date NOT NULL,
  page_link text NOT NULL,
  PRIMARY KEY (username, page_link)
);