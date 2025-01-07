-- All diary entries where the watch date is before the log date
SELECT w.username, w.title, watch_date, log_date
FROM diary d
JOIN watched w
	ON d.username = w.username AND d.film_link = w.page_link
WHERE w.watch_date < d.log_date;

-- The total number of different films in the database
SELECT COUNT(DISTINCT page_link)
FROM watched;

-- For every film in the database, the number of people who have watched it in descending order
SELECT title, release_year, COUNT(*)
FROM watched
GROUP BY page_link, title, release_year
ORDER BY 3 DESC;

-- All diary entries ordered from earliest to latest
SELECT *
FROM diary
ORDER BY log_date;

-- All watched films that are missing a rating
SELECT *
FROM watched
WHERE rating IS NULL;

-- The total number of watched films for each user in ascending order
SELECT username, COUNT(*) AS "Number of Watched Films"
FROM watched
GROUP BY username
ORDER BY 2;

-- The number of films watched in a single day in descending order
SELECT username, log_date, COUNT(*) AS "Number of Watched Films"
FROM diary
GROUP BY username, log_date
ORDER BY 3 DESC;

-- The average film rating for each user in descending order
SELECT username, ROUND(AVG(rating), 1) AS "Average Film Rating"
FROM watched
GROUP BY username
ORDER BY 2 DESC;

-- The number of films seen for each user with a rating of 4.5 stars or above in descending order
SELECT username, COUNT(*) AS "Number of Films Rated 4.5 Stars or Above"
FROM watched
WHERE rating >= 4.5
GROUP BY username
ORDER BY 2 DESC;

-- The number of rewatched films for each user in descending order
SELECT username, COUNT(*) AS "Number of Rewatched Films"
FROM diary
WHERE rewatch = 'Yes'
GROUP BY username
ORDER BY 2 DESC;

-- The number of rewatched films and average rating for each user
SELECT username, COUNT(*) AS "Number of Rewatched Films", ROUND(AVG(rating), 1) AS "Average Rating"
FROM diary
WHERE rewatch = 'Yes'
GROUP BY username
ORDER BY 2;

-- The number and average rating of films logged in 2024 for each user
SELECT username, COUNT(*) AS "Number of Logged Films in 2024", ROUND(AVG(rating), 1) AS "Average Rating"
FROM diary
WHERE EXTRACT(YEAR FROM log_date) = 2024
GROUP BY username
ORDER BY 2;

-- The number of average rating of films watched in 2024 for each user
SELECT username, COUNT(*) AS "Number of Watched Films in 2024", ROUND(AVG(rating), 1) AS "Average Rating"
FROM watched
WHERE EXTRACT(YEAR FROM watch_date) = 2024
GROUP BY username
ORDER BY 2;

-- Most liked films and their average rating in descending order
SELECT liked_films.title, liked_films.release_year, COUNT(*), ROUND(AVG(rating), 1)
FROM liked_films
JOIN watched w
	ON liked_films.page_link = w.page_link AND liked_films.username = w.username
GROUP BY liked_films.page_link, liked_films.title, liked_films.release_year
HAVING COUNT(liked_films.page_link) >= 2
ORDER BY 4 DESC;

-- Films that have appeared the most in watchlists, likes, and diary entries
SELECT title, release_year, COUNT(*) AS "Occurrences"
FROM (
	SELECT username, page_link, title, release_year
	FROM watchlist wl
	UNION ALL
	SELECT username, page_link, title, release_year
	FROM liked_films
	UNION ALL
	SELECT username, film_link, title, release_year
	FROM diary)
GROUP BY page_link, title, release_year
ORDER BY 3 DESC;

-- average rating of films in each decade starting from 1960
WITH yearly_cte AS (
	SELECT username, release_year, AVG(rating) AS avg_year
	FROM watched
	GROUP BY username, release_year
)
SELECT username, 
CASE
	WHEN release_year >= 1960 AND release_year <= 1969
	THEN 1960
	WHEN release_year >= 1970 AND release_year <= 1979
	THEN 1970
	WHEN release_year >= 1980 AND release_year <= 1989
	THEN 1980
	WHEN release_year >= 1990 AND release_year <= 1999
	THEN 1990
	WHEN release_year >= 2000 AND release_year <= 2009
	THEN 2000
	WHEN release_year >= 2010 AND release_year <= 2019
	THEN 2010
	WHEN release_year >= 2020 AND release_year <= 2029
	THEN 2020
END AS "Decade", ROUND(AVG(avg_year), 1) AS "Average Rating"
FROM yearly_cte
WHERE release_year >= 1960
GROUP BY username, 2
ORDER BY 2;

-- Films watched by logging date for each user
SELECT username, log_date, COUNT(*) AS "Logged Films"
FROM diary
GROUP BY username, log_date
ORDER BY 1, 2;

-- Films watched in every release year for each user
SELECT username, release_year, COUNT(*) AS "Logged Films"
FROM diary
GROUP BY username, release_year
ORDER BY 3, 2, 1;