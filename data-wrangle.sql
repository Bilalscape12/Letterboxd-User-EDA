-- 1. Clean up tables by merging reviews/diary and ratings/watched tables
-- 2. Replace watch_date column from the watched table with the earliest date
-- 3. Remove watch_date column from diary/reviews table and drop extra tables

-- 1.
ALTER TABLE diary
ADD COLUMN review text;

ALTER TABLE watched
ADD COLUMN rating numeric(2, 1);

UPDATE diary
SET review = reviews.review
FROM reviews
WHERE diary.page_link = reviews.page_link;

UPDATE watched
SET rating = ratings.rating
FROM ratings
WHERE watched.page_link = ratings.page_link;

-- 2.
WITH min_dates AS (
  SELECT page_link, MIN(watch_date) AS earliest_date
  FROM (
	SELECT page_link, watch_date FROM reviews
	UNION ALL
	SELECT page_link, watch_date FROM diary
  )
  GROUP BY page_link
)
UPDATE diary
SET watch_date = min_dates.earliest_date
FROM min_dates
WHERE diary.page_link = min_dates.page_link;

WITH min_dates AS (
  SELECT page_link, MIN(watch_date) AS earliest_date
  FROM (
	SELECT page_link, watch_date FROM ratings
	UNION ALL
	SELECT page_link, watch_date FROM watched
  )
  GROUP BY page_link
)
UPDATE watched
SET watch_date = min_dates.earliest_date
FROM min_dates
WHERE watched.page_link = min_dates.page_link;

-- 3.
ALTER TABLE diary
DROP COLUMN watch_date;

DROP TABLE reviews;
DROP TABLE ratings;