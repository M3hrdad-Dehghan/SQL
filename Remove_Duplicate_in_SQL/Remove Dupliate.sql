USE [WLE]

-- See all data ------------------------------------------------------------------------------------
SELECT *
FROM [dbo].[SampleTable];


-- 1.Concatinate "Country" & "Year" ----------------------------------------------------------------
SELECT	
	[Country], 
	[YEAR], 
	CONCAT([Country], [Year]) AS "Country_Year"
FROM	
	[dbo].[SampleTable];


-- 2.Count Number of Country_Year ------------------------------------------------------------------
SELECT 
	CONCAT([Country], [Year]) AS "Country_Year", 
	COUNT(CONCAT([Country], [Year])) AS "#Country_Year"
FROM 
	[dbo].[SampleTable]
GROUP BY 
	CONCAT([Country], [Year]);



-- 3.Filter on Number of Country_Year more than 1 -------------------------------------------------
SELECT 
	CONCAT([Country], [Year]) AS "Country_Year", 
	COUNT(CONCAT([Country], [Year])) AS "#Country_Year"
FROM 
	[dbo].[SampleTable]
GROUP BY 
	CONCAT([Country], [Year])
HAVING
	COUNT(CONCAT([Country], [Year])) > 1;
	
	
-- 4.Find Duplicate IDs -------------------------------------------------------------
WITH CTE_Partition AS (
	SELECT 
		[Row_ID],
		CONCAT([Country], [Year]) "Concatinated",
		ROW_NUMBER() OVER( PARTITION BY CONCAT([Country], [Year]) ORDER BY CONCAT([Country], [Year])) AS "Row_Num"
	FROM
		[dbo].[SampleTable]
)


--SELECT *
--FROM CTE_Partition
--WHERE Row_Num > 1;


-- 5.Remove Duplicate IDs -------------------------------------------------------------
DELETE FROM [dbo].[SampleTable]
WHERE [Row_ID] IN (
    SELECT [Row_ID]
    FROM CTE_Partition
    WHERE Row_Num > 1
);