use AdventureWorks2012;

/*Example of GROUP BY*/
/* List number of orders, Average of TotalDues, and the Maximum of Totaldues of All the online orders and offline orders*/
SELECT OnlineOrderFlag,
	   Count(SalesOrderID) AS Number_of_Orders,
	   AVG(TotalDue) AS Avg_Due,
	   MAX(TotalDue) AS Max_Due 
FROM Sales.SalesOrderHeader
GROUP BY OnlineOrderFlag;

/*Example of Having*/
/* List number of orders, total sales amount of every day and every territory before 2007. Only list those where total sales amount exceeds 5000.*/
SELECT TerritoryID, 
	   OrderDate,
	   Count(SalesOrderID) AS Number_of_Orders,
	   SUM(TotalDue) AS Total_Amount
FROM Sales.SalesOrderHeader
WHERE OrderDate < '2007-01-01'
GROUP BY TerritoryID, OrderDate
HAVING SUM(TotalDue) > 5000
ORDER BY SUM(TotalDue) DESC

/*Example Using INNER JOIN*/

SELECT s.SalesOrderID,
	   s.SalesOrderDetailID,
	   s.OrderQty,
	   s.ProductID,
	   p.Name
FROM sales.SalesOrderDetail AS s INNER JOIN 
production.product AS p
ON s.ProductID=p.ProductID;

/*Example of an Inner Join Without "INNER JOIN" Key Words*/
SELECT s.SalesOrderID,
	   s.SalesOrderDetailID,
	   s.OrderQty,
	   s.ProductID,
	   p.Name
FROM sales.SalesOrderDetail AS s,
production.product AS p
WHERE s.ProductID=p.ProductID;

/*Sequential Joins*/
/*List store names and their city, state and country/region names*/
SELECT S.Name AS Store_Name, 
	   PA.City, 
	   SP.Name AS State, 
	   CR.Name AS CountryRegion
FROM Sales.store AS S 
	Join Person.BusinessEntityAddress AS A
	ON a.BusinessEntityID=s.BusinessEntityID
	join person.Address AS PA
	ON A.AddressID =pa.AddressID
	join Person.StateProvince AS SP
	ON SP.StateProvinceID = PA.stateProvinceID
	join Person.CountryRegion AS CR
	ON CR.CountryRegionCode = SP.CountryRegionCode
Order by s.Name;


/*Example of OUTER JOIN*/
/*List SalesOrderID, SalesOrderDetailID, all the ProductIDs and product Names - including those products that have never been sold before.*/
SELECT s.SalesOrderID,
	s.SalesOrderDetailID,
	p.ProductID,
	p.Name
FROM Sales.SalesOrderDetail AS s
RIGHT OUTER JOIN Production.Product AS p
on s.ProductID = p.ProductID

/*Example of a SubQuery*/
/*How much does each territory contribute to the total sales amount?*/

SELECT TerritoryID, 
	Sum(TotalDue) AS Total_Due,
	100*sum(totalDue)/
		(
			SELECT Sum(totaldue)
			FROM Sales.SalesOrderHeader
		) 
		AS Pct_total_due		
FROM Sales.SalesOrderHeader
GROUP BY TerritoryID
ORDER BY TerritoryID;
