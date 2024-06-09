---------------------------------------SELECT---------------------------------------
SELECT * FROM movies.country;

SELECT 
    movie_id, budget
FROM
    movie;
---------------------------------------WHERE---------------------------------------
SELECT 
    *
FROM
    MOVIE
WHERE
	budget >= 200000000;
---------------------------------------AND---------------------------------------
SELECT 
    *
FROM
    MOVIE
WHERE
	budget >= 200000000 AND runtime < 100;
---------------------------------------PRECEDENCE---------------------------------------
SELECT 
    *
FROM
    MOVIE
WHERE
	(budget >= 200000000 AND runtime > 100) OR (revenue <= 5000000);
---------------------------------------BETWEEN---------------------------------------
SELECT 
    *
FROM
    MOVIE
WHERE
	(budget >= 200000000) AND (runtime BETWEEN 100 AND 150);
---------------------------------------IN - NOT IN---------------------------------------
SELECT 
    *
FROM
    genre
WHERE
	genre_name = "Adventure"
    OR genre_name = "Drama"
    OR genre_name = "Action";
    
    
SELECT 
    *
FROM
    genre
WHERE
	genre_name IN ("Adventure", "Drama", "Action");



---------------------------------------LIKE---------------------------------------
SELECT 
    title, revenue
FROM
    movies.movie
WHERE
	title LIKE ('AL%');



SELECT 
    title, revenue
FROM
    movies.movie
WHERE
	title LIKE ('AL_');
    
    
    
SELECT 
    title, revenue
FROM
    movies.movie
WHERE
	title LIKE ('_AL_');
    

SELECT 
    title, revenue
FROM
    movies.movie
WHERE
	title LIKE ('%AL');
    
    
    
SELECT 
    title, revenue
FROM
    movies.movie
WHERE
	title LIKE ('%AL%');
    
    
SELECT 
    title, revenue
FROM
    movies.movie
WHERE
	title LIKE ('%AL__');