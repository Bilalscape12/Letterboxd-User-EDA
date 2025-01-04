-- 1. Clean up tables by merging reviews/diary and ratings/watched tables
-- 2. The diary table is missing a foreign key for page_link from the watched table
-- 3. Replace watch_date column from the watched table with the earliest date
-- 4. Remove watch_date column from diary table and drop extra tables

-- 1. Clean up tables by merging reviews/diary and ratings/watched tables
ALTER TABLE diary
ADD COLUMN review text;

ALTER TABLE watched
ADD COLUMN rating numeric(2, 1);

UPDATE diary
SET review = reviews.review
FROM reviews
WHERE diary.username = reviews.username AND diary.page_link = reviews.page_link;

UPDATE watched
SET rating = ratings.rating
FROM ratings
WHERE watched.username = ratings.username AND watched.page_link = ratings.page_link;

-- 2. The diary table is missing a foreign key for page_link from the watched table
ALTER TABLE diary
ADD COLUMN film_link text;

ALTER TABLE diary
ADD CONSTRAINT diary_user_film_fk FOREIGN KEY (username, film_link)
REFERENCES watched (username, page_link) ON DELETE CASCADE;

ALTER TABLE diary
DROP CONSTRAINT diary_username_fkey;

UPDATE diary
SET film_link = watched.page_link
FROM watched
WHERE diary.username = watched.username AND diary.title = watched.title
AND diary.release_year = watched.release_year;

-- TODO: Since the films with the same name and release year can't be distinguished
-- they will need to be manually selected and updated
SELECT username, title, release_year, COUNT(film_link) FROM diary
GROUP BY username, title, release_year
HAVING COUNT(film_link) >= 2;

-- 3. Replace watch_date column from the watched table with the earliest date
WITH min_dates AS (
  SELECT username, page_link, MIN(watch_date) AS earliest_date
  FROM (
	SELECT username, page_link, watch_date FROM ratings
	UNION ALL
	SELECT username, page_link, watch_date FROM watched
  )
  GROUP BY username, page_link
)
UPDATE watched
SET watch_date = min_dates.earliest_date
FROM min_dates
WHERE watched.username = min_dates.username AND watched.page_link = min_dates.page_link;

-- 4. Remove watch_date column from diary table and drop extra tables
ALTER TABLE diary
DROP COLUMN watch_date;

DROP TABLE reviews;
DROP TABLE ratings;