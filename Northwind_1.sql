SELECT * FROM Products

--1.
SELECT ProductName FROM Products

--2.
SELECT ProductID, ProductName, UnitPrice FROM Products

--3.
SELECT * FROM Products

--4.
SELECT ProductName FROM Products ORDER BY ProductName ASC

--5.
SELECT ProductName, UnitPrice FROM Products ORDER BY UnitPrice ASC, ProductName ASC

--6.
SELECT ProductID, ProductName, UnitPrice FROM Products ORDER BY ProductName ASC, UnitPrice ASC

--7.
SELECT ProductID, UnitPrice, ProductName FROM Products ORDER BY UnitPrice DESC

--8.
SELECT ProductID, UnitPrice, ProductName FROM Products ORDER BY UnitPrice DESC, ProductName ASC

--9.
SELECT ProductName, UnitPrice FROM Products WHERE UnitPrice = 2.5

--10.
SELECT ProductName, UnitPrice FROM Products WHERE UnitPrice <5

--11.
SELECT ProductName, UnitPrice FROM Products WHERE UnitPrice >= 10

--12.
SELECT SupplierID, ProductName FROM Products WHERE SupplierID = 4

--13.
SELECT ProductName FROM Products WHERE ProductName not like ('Chang')

--14.
