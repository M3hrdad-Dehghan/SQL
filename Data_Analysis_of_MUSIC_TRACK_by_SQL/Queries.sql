
--Which tracks belong to the most popular genre in the dataset?

WITH GenrePopularity AS (
    -- Step 1: Calculate average popularity for each genre
    SELECT 
        [Genres], 
        AVG([Popularity]) AS AvgPopularity
    FROM [dbo].[Tracks]
    GROUP BY [Genres]
)

-- Step 2: Get tracks from the most popular genre
SELECT 
    [Track Name], 
    [Popularity], 
    [Genres]
FROM [dbo].[Tracks]
WHERE [Genres] = (
    SELECT TOP 1 [Genres]
    FROM GenrePopularity
    ORDER BY AvgPopularity DESC
)

------------------------------------------------------------
--How many tracks were released in each year, and what is their average popularity?
SELECT 
	YEAR(CAST([Release Date] AS DATE)) AS 'YearOfRelease', 
	COUNT([Track ID]) AS 'Number of Tracks', 
	AVG([Popularity]) AS 'Average Popularity'
FROM 
	[dbo].[Tracks]
GROUP BY
	YEAR(CAST([Release Date] AS DATE))
ORDER BY
	AVG([Popularity]) DESC


----------------------------------------
--Which track has the lowest dancecibility among those genres which have the energy greater than 0.7?

WITH GenreEnergyHigh AS (
	SELECT [Genres] , AVG([Energy]) AS 'Average Energy'
	FROM [dbo].[Tracks]
	WHERE [Energy] > 0.7
	GROUP BY [Genres]
)


SELECT TOP 1 [Track Name] , [Genres] , [Danceability]
FROM [dbo].[Tracks]
WHERE [Genres] IN (
	SELECT [Genres]
	FROM GenreEnergyHigh
)
ORDER BY [Danceability] ASC

