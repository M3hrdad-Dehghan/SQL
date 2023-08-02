/* 1-Show the customers who are living in a specific country in a dynamic way.*/
DECLARE @CountryName NVARCHAR(100) = 'United States'

SELECT 
	CA.CustomerID, 
	A.AddressLine1, 
	A.City,
	A.CountryRegion
FROM 
	[SalesLT].[CustomerAddress] CA
JOIN 
	[SalesLT].[Address] A
	ON 
		A.AddressID = CA.AddressID
WHERE 
	A.CountryRegion = @CountryName
	
/* 2-The total sales cost just for the company names begin with B and Bikes or Pedals for their product category */
SELECT 
	sum(SOH.TotalDue) AS 'Total Sales'
FROM 
	[SalesLT].[SalesOrderHeader] SOH
JOIN
	[SalesLT].[SalesOrderDetail] SOD ON SOH.[SalesOrderID] = SOD.[SalesOrderID]
JOIN 
	[SalesLT].[Product] P ON SOD.[ProductID] = P.[ProductID]
JOIN 
	[SalesLT].[ProductCategory] PC ON P.[ProductCategoryID] = PC.[ProductCategoryID]
JOIN 
	[SalesLT].[Customer] C ON C.CustomerID = SOH.CustomerID
WHERE 
	(C.CompanyName LIKE 'B%') AND ((PC.Name LIKE 'Bike') OR (PC.Name LIKE 'Pedals'))


/* 3-Which salesperson made the highest total sales */
SELECT TOP 1 
	C.SalesPerson, SOH.TotalDue
FROM 
	[SalesLT].[Customer] C
JOIN 
	[SalesLT].[SalesOrderHeader] SOH
		ON SOH.CustomerID = C.CustomerID
ORDER BY 
	SOH.TotalDue DESC;	

	
/*4-Which product model has the most products associated with it? */
SELECT 
	PM.Name AS 'Model', 
	COUNT(P.Name) AS 'Product'
FROM 
	[SalesLT].[ProductModel] PM
JOIN 
	[SalesLT].[Product] P
		ON P.ProductModelID = PM.ProductModelID
GROUP BY 
	PM.Name
ORDER BY
	COUNT(P.Name) DESC;
	

/* 5-Find all products with a price classification. based on dynamic price */
declare @MinPrice INT = 80000
declare @MaxPrice INT = 100000

SELECT p.ProductID , pc.Name, p.Name,  soh.TotalDue,
case
	when soh.TotalDue < @MinPrice then 'Cheap'
	when soh.TotalDue between @MinPrice + 1 and @MaxPrice then 'Medium'
	else 'Expensive'
end as Class
FROM [SalesLT].[Product] p
JOIN [SalesLT].[ProductCategory] pc ON p.ProductCategoryID = pc.ProductCategoryID
JOIN [SalesLT].[SalesOrderDetail] sod ON p.ProductID = sod.ProductID
JOIN [SalesLT].[SalesOrderHeader] soh ON soh.[SalesOrderID] = sod.[SalesOrderID]

