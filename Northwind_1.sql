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
SELECT ProductName, UnitPrice FROM Products WHERE UnitPrice BETWEEN 10 AND 20

--15.
SELECT ProductName, UnitPrice FROM Products WHERE ProductName >= 'Chang' AND ProductName <= 'Longlife Tofu'

--16.
SELECT SupplierID, ProductName, UnitPrice FROM Products WHERE SupplierID = 8 AND UnitPrice <40

--17.
SELECT SupplierID, ProductName, UnitPrice FROM Products WHERE SupplierID = 8 OR SupplierID = 10

--18.
SELECT SupplierID, ProductName, UnitPrice FROM Products WHERE (SupplierID = 8 OR SupplierID= 10) AND UnitPrice >= 20

--19.
SELECT SupplierID, ProductName, UnitPrice FROM Products WHERE SupplierID = 8 OR SupplierID = 10 ORDER BY ProductName ASC

--20.
SELECT SupplierID, ProductName FROM Products WHERE NOT(SupplierID = 8)

--21.
SELECT ProductName FROM Products WHERE ProductName like 'R%' 

--22.
SELECT ProductName FROM Products WHERE ProductName like '%chef%'

--23.
SELECT ProductName FROM Products WHERE ProductName like '[sS]%'

--24.
SELECT ProductName FROM Products WHERE ProductName like 'Tof_'

--25.
SELECT ProductName FROM Products WHERE ProductName like '_kur_'