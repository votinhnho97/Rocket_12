USE AdventureWorks;

/*
	EXERCISE 1: SUBQUERY
*/
-- Question 1:
SELECT `Name`
FROM `Product`
WHERE ProductSubcategoryID = (SELECT ProductSubcategoryID FROM ProductSubcategory WHERE `Name` = 'Saddles');
-- Question 2:
SELECT `Name`
FROM `Product`
WHERE ProductSubcategoryID IN (SELECT ProductSubcategoryID FROM ProductSubcategory WHERE `Name` LIKE 'Bo%')
ORDER BY `Name` DESC;
-- Question 3:
SELECT `Name`
FROM `Product`
WHERE 
	ProductSubcategoryID = (SELECT ProductSubcategoryID FROM ProductSubcategory WHERE `Name` = 'Touring Bikes')
AND ListPrice = 
	(SELECT min(ListPrice)
	FROM `Product`
	WHERE ProductSubcategoryID = (SELECT ProductSubcategoryID FROM ProductSubcategory WHERE `Name` = 'Touring Bikes'));

/*
	EXERCISE 2: JOIN
*/
-- Question 1:
SELECT cr.`Name`, sp.`Name`
FROM `CountryRegion` cr
INNER JOIN `StateProvince` sp ON cr.CountryRegionCode = sp.CountryRegionCode;

-- Question 2
SELECT cr.`Name`, sp.`Name`
FROM `CountryRegion` cr
INNER JOIN `StateProvince` sp ON cr.CountryRegionCode = sp.CountryRegionCode
WHERE cr.`Name` IN ('Germany', 'Canada');

-- Question 3
-- SalesOrderHeader >> SalesPersonID
-- SalesPerson >> SalesPersonID 
-- SalesOrderID, OrderDate, SalesPersonID, BusinessEntityID, Bonus, SalesYTD
SELECT soh.SalesOrderID, soh.OrderDate, soh.SalesPersonID, sp.SalesPersonID, sp.Bonus, sp.SalesYTD
FROM `SalesOrderHeader` soh
JOIN `SalesPerson` sp ON soh.SalesPersonID = sp.SalesPersonID;

-- Question 4
SELECT soh.SalesOrderID, soh.OrderDate, e.Title, sp.Bonus, sp.SalesYTD
FROM `SalesOrderHeader` soh
JOIN `SalesPerson` sp ON soh.SalesPersonID = sp.SalesPersonID 
JOIN `Employee` e ON soh.SalesPersonID = e.EmployeeID;