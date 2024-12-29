-- #1-Identify High-Spending Customers and Their Provinces
--Find customers who made transactions of $500 or more, and retrieve their names, customer categories, and province names. Exclude transactions made in provinces that start with 'C'

SELECT C.[CustomerName], CT.[CustomerCatName], P.[ProvinceName], SUM(T.[TransactionAmount]) AS 'Total Transaction'
FROM [dbo].[dimCustomer] C
JOIN [dbo].[fctTransaction] T ON T.[CustomerID] = C.[CustomerID]
JOIN [dbo].[dimCustomerCat] CT ON CT.[CustomerCatID] = C.[CustomerCatID]
JOIN [dbo].[dimCity] CY ON CY.[CityID] = C.[CityID]
JOIN [dbo].[dimProvince] P ON P.[ProvinceID] = CY.[ProvinceID]
GROUP BY C.[CustomerName], CT.[CustomerCatName], P.[ProvinceName]
HAVING (SUM(T.[TransactionAmount]) > 500) AND (P.[ProvinceName] NOT LIKE 'C%')


----------------------------------------------------------
 --2. Daily Spending by Customer Category
--Calculate the total transaction amount for each customer category, grouped by weekday. Display the weekday name, customer category, and total transaction amount

SELECT SUM(T.[TransactionAmount]) AS 'Total Sale', CT.[CustomerCatName], DATENAME(WEEKDAY , T.[TransactionDate]) AS 'Weekday'
FROM [dbo].[fctTransaction] T
JOIN [dbo].[dimCustomer] C ON C.[CustomerID] = T.[CustomerID]
JOIN [dbo].[dimCustomerCat] CT ON CT.[CustomerCatID] = C.[CustomerCatID]
GROUP BY CT.[CustomerCatName], DATENAME(WEEKDAY , T.[TransactionDate])
ORDER BY CT.[CustomerCatName]






----------------
 3. Inactive Customers by Year
Identify customers who did not make any transactions in 2023 and retrieve their names and city names. Exclude cities that starts with the letters "O, S, T".



CREATE VIEW [dbo].[vw_CustomerNotHavingTransaction2023] AS
SELECT T.[TransactionAmount], C.[CustomerName], CY.[CityName], DATENAME(YEAR,T.[TransactionDate]) AS 'Year'
FROM [dbo].[fctTransaction] T
JOIN [dbo].[dimCustomer] C ON C.[CustomerID] = T.[CustomerID]
JOIN [dbo].[dimCity] CY ON CY.[CityID] = C.[CityID]
WHERE (DATENAME(YEAR,T.[TransactionDate]) <> 2023) AND (CY.[CityName] NOT LIKE '[O,S,T]%')

SELECT *[CustomerName] FROM [dbo].[vw_CustomerNotHavingTransaction2023]

