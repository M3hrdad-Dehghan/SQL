use movies;

#1. How much did movies cost per minute?
SELECT title, budget, runtime, ROUND(budget / runtime, 2) AS “Budget_Per_Minute” 
FROM movie;

#2.	What is the top-5 movies in terms of budget?
SELECT title, budget
FROM movie
ORDER BY budget desc
LIMIT 5;

#3.	In terms of release date, how old is every single movie? Show the top-10 Youngest movies.
SELECT release_date, title, (YEAR(CURDATE()) - YEAR(release_date)) as Age 
FROM movie
ORDER BY Age asc
LIMIT 10;

#4.	In which years did the producer make a movie? regardless of the number of movies.
SELECT DISTINCT year(release_date)
FROM movie
order by year(release_date) desc;

#5.	Which movies cost less than 50,000 and what were their genres? Just top-10
SELECT movie.title, movie.budget, genre.genre_name
FROM movie 
JOIN movie_genres ON movie.movie_id = movie_genres.movie_id
JOIN genre ON movie_genres.genre_id = genre.genre_id
WHERE movie.budget < 50000 
ORDER BY movie.budget DESC
limit 10;

# 6.which director did make the most popular movie in English and French language?
SELECT language.language_name, person.person_name, COUNT(*) as movie_count, MAX(movie.popularity) as max_popularity
FROM movie
join movie_crew on movie.movie_id = movie_crew.movie_id
join person on movie_crew.person_id = person.person_id
join movie_languages on movie.movie_id = movie_languages.movie_id
join language on movie_languages.language_id = language.language_id
GROUP BY language.language_name, person.person_name
having language.language_name IN ('English','Latin') 
limit 1;

#7.	Make a list of actors(actress) who played after the year 2010.
select person.person_name, movie.title, movie_crew.job 
from movie
join movie_crew on movie.movie_id = movie_crew.movie_id
join person on movie_crew.person_id = person.person_id
where movie_crew.job = "Characters" and release_date > "2010-01-01"
GROUP BY person.person_id, movie.title, movie_crew.job;

#8.	How many horror movies did their budget exceed the average budget of all movies?
select movie.title, movie.budget, movie_genres.genre_id, genre.genre_name
from movie
join movie_genres on movie.movie_id = movie_genres.movie_id
join genre on genre.genre_id = movie_genres.genre_id
where genre.genre_name = 'Horror' and movie.budget > (SELECT AVG(movie.budget) FROM movie);


# 9.	What is the bottom-10 popular movies, and which company made them?
SELECT movie.title, SUM(movie.popularity) as sum_popularity, production_company.company_name
FROM movie
JOIN movie_company ON movie.movie_id = movie_company.movie_id
JOIN production_company ON movie_company.company_id = production_company.company_id
GROUP BY movie.title, production_company.company_name
ORDER BY sum_popularity asc
LIMIT 10;

#10.	Which movie companies invested the budget between 150K to 200K and for which movie?
SELECT movie.title, movie.budget, production_company.company_name
FROM movie 
JOIN movie_company ON movie.movie_id = movie_company.movie_id
JOIN production_company ON movie_company.company_id = production_company.company_id
WHERE movie.budget BETWEEN 150000 AND 200000 
ORDER BY budget DESC
limit 1;