/* que 1*/
SELECT CustomerID, CompanyName, Address FROM Customers
WHERE City='Paris' OR City='London'

---Q1.2
SELECT *
FROM Products p
WHERE p.QuantityPerUnit LIKE '%bottle%'

---Q1.2
SELECT p.ProductID AS "Product ID",
    p.ProductName AS "Product Name",
    s.CompanyName AS "Company Name",
    s.Country AS "Country"
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID 
WHERE p.QuantityPerUnit LIKE '%bottle%'

/* Que 1.4 */
SELECT c.CategoryName AS "Category",
    COUNT(*) AS "Number of products in Category"
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName
ORDER BY COUNT(*) DESC

/* Que 1.5 */

SELECT CONCAT(e.TitleOfCourtesy,' ',e.FirstName,' ',e.LastName) AS "Employee",
    e.City AS "City of Residence"
FROM Employees e
WHERE e.Country = 'UK'



/* Que 1.6 Removing multiple teritories for employees */
SELECT r.RegionDescription, ROUND(SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)),2) total_sales 
FROM  [Order Details] od
INNER JOIN Orders o ON o.OrderID = od.OrderID
INNER JOIN EmployeeTerritories et ON et.EmployeeID = o.EmployeeID
INNER JOIN Territories t ON t.TerritoryID = et.TerritoryID
INNER JOIN Region r ON r.RegionID = t.RegionID
GROUP  BY r.RegionDescription
HAVING ROUND(SUM(od.Quantity * od.UnitPrice),2) >1000000

--- Que 1.7
SELECT COUNT(OrderID) AS "Orders", o.ShipCountry AS "Ship Country"
FROM Orders o
WHERE ShipCountry IN ('UK', 'USA')
AND o.Freight > 100
GROUP BY o.ShipCountry


--- Que 1.8
USE Northwind


SELECT (od.UnitPrice*od.Quantity*od.Discount) AS "Biggest_amount_of_discount", od.OrderID
FROM [Order Details] od 
WHERE od.UnitPrice*od.Discount*od.Quantity = (SELECT MAX(orr.UnitPrice*orr.Discount*orr.Quantity) FROM [Order Details] orr)
ORDER BY Biggest_amount_of_discount DESC


---EX2
CREATE DATABASE sidhant_db
USE sidhant_db
CREATE TABLE Spartans_table
(
    Title VARCHAR(20),
    firstName VARCHAR(20),
    lastName VARCHAR(20),
    universityAttended VARCHAR(20),
    courseTaken VARCHAR(20),
    markAchieved INT,
    tieGame VARCHAR(20),

)

SELECT * FROM Spartans_table --SELECT everything from a table
INSERT INTO
Spartans_table(Title, firstName, lastName, universityAttended, courseTaken, markAchieved, tieGame)
VALUES
('Mr.', 'Josh', 'Weeden', 'Oxford', 'All of them', '80', 'Blue-STRONG'),
('Mr.', 'Nathan', 'Johnston', 'Susex', 'IDK', '100', 'STRONG'),
('Mr.', 'Asakar', 'Hussain', 'Middlesex', 'CS','100', 'BOW-TIE'),
('Mr.' , 'Sidhant', 'Khosla', 'Brunel', 'Business','100' , 'FANCY')
---
USE Northwind

---Q 3.1
SELECT CONCAT(e.TitleOfCourtesy, e.FirstName, ' ' ,e.LastName) AS "Employee Name",CONCAT(id.TitleOfCourtesy, id.FirstName, ' ' ,id.LastName) AS 'Report To'
FROM Employees e
LEFT JOIN Employees id
ON id.EmployeeID=e.ReportsTo

----
USE Northwind
-- Q3.2
SELECT ROUND(SUM((1-od.Discount)*od.Quantity * od.UnitPrice),2) AS "sales", s.CompanyName
FROM Orders o
INNER JOIN [Order Details] od 
ON od.OrderID = o.OrderID
INNER JOIN Products p 
ON p.ProductID = od.ProductID
INNER JOIN Suppliers s 
ON s.SupplierID = p.SupplierID
GROUP BY s.CompanyName
HAVING ROUND(SUM((1-od.Discount)*od.Quantity * od.UnitPrice),2) > 10000.00
ORDER BY sales DESC

-- Q3.3

SELECT TOP 10 c.CompanyName AS "Company Name",
    ROUND(SUM(od.Quantity*(od.UnitPrice-od.UnitPrice*od.Discount)),2) AS "Total Value Of Orders Shipped"
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate)=(SELECT MAX(YEAR(oo.OrderDate)) FROM Orders oo)
GROUP BY c.CompanyName
ORDER BY "Total value of orders shipped" DESC


--- Q3.4
USE Northwind



SELECT AVG(CAST(DATEDIFF(d, o.OrderDate, o.ShippedDate) AS Decimal(4,2))) AS "Average Ship time", FORMAT(o.OrderDate, 'MMM,yyyy') AS Dates
FROM Orders o
GROUP BY FORMAT(o.OrderDate, 'MMM,yyyy')
ORDER BY YEAR(FORMAT(o.OrderDate, 'MMM,yyyy')), MONTH(FORMAT(o.OrderDate, 'MMM,yyyy'))

SELECT *
FROM Orders











/* https://social.msdn.microsoft.com/Forums/en-US/c29c94ad-f4ed-4ad2-b376-05b88cf70a80/list-sales-totals-for-all-sales-regions-via-the-territories-table-using-4-joins-with-a-sales-total?forum=sqlgetstarted*/