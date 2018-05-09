/*Problem 1*/
USE SoftUni

SELECT FirstName, LastName FROM Employees
WHERE FirstName LIKE 'SA%'

/*Problem 2*/
SELECT FirstName, LastName FROM Employees
WHERE LastName LIKE '%ei%'

/*Problem 3*/
SELECT FirstName FROM Employees
WHERE DepartmentID = 3 OR 
	  DepartmentID = 10 AND
	  HireDate BETWEEN  '1995' AND '2005'

/*Problem 4*/
SELECT FirstName, LastName FROM Employees
WHERE JobTitle NOT LIKE '%engineer%'

/*Problem 5*/
SELECT [Name] FROM Towns
WHERE LEN([Name]) = 5 OR LEN([Name]) = 6
ORDER BY [Name] ASC

/*Problem 6*/
SELECT * FROM Towns
WHERE [Name] LIKE 'M%' OR
	  [Name] LIKE 'K%' OR
	  [Name] LIKE 'B%' OR
	  [Name] LIKE 'E%'
ORDER BY [Name] ASC

/*Problem 7*/
SELECT * FROM Towns
WHERE [Name] NOT LIKE 'R%' AND
	  [Name] NOT LIKE 'D%' AND
	  [Name] NOT LIKE 'B%'
ORDER BY [Name] ASC

/*Problem 8*/
GO
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName FROM Employees
WHERE HireDate >= '2001'

/*Problem 9*/
SELECT FirstName, LastName FROM Employees
WHERE LEN(LastName) = 5

/*Problem 10*/
USE Geography

SELECT CountryName, IsoCode FROM Countries
WHERE LEN(CountryName) - LEN(REPLACE(CountryName,'a','')) >= 3
ORDER BY IsoCode

/*Problem 11*/

SELECT PeakName, RiverName,
	    LOWER(CONCAT(PeakName, RIGHT(RiverName, LEN(RiverName) - 1))) AS Mix 
FROM Peaks, Rivers
WHERE RIGHT(PeakName, 1) = LEFT(RiverName, 1)
ORDER BY Mix ASC

/*Problem 12*/
USE Diablo

SELECT TOP 50 [Name], CONVERT(CHAR(10),[Start], 126) AS [Start] FROM Games
WHERE DATEPART(YEAR, [Start]) = '2011' OR
	  DATEPART(YEAR, [Start]) = '2012' 
ORDER BY [Start], [Name]

/*Problem 13*/
SELECT Username, 
	    SUBSTRING(Email, CHARINDEX('@', Email) + 1, 100)
		 AS [Email Provider]
FROM Users
ORDER BY [Email Provider] ASC, Username ASC

/*Problem 14*/
SELECT Username, IpAddress FROM Users
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username

/*Problem 15*/

SELECT g.[Name],
	CASE 
	   WHEN DATEPART(HOUR, g.Start) >= 0 AND DATEPART(HOUR, g.Start) < 12
			THEN 'Morning' 
	   WHEN DATEPART(HOUR, g.Start) >= 12 AND DATEPART(HOUR, g.Start) < 18
			THEN 'Afternoon'
	   WHEN DATEPART(HOUR, g.Start) >= 18 AND DATEPART(HOUR, g.Start) < 24
	   THEN 'Evening'
	END AS [Part of the Day],
	CASE
		WHEN g.Duration <= 3
			THEN 'Extra Short'
		WHEN g.Duration > 3 AND g.Duration <= 6
			THEN 'Short'
		WHEN g.Duration > 6
			THEN 'Long'
		WHEN g.Duration IS NULL
			THEN 'Extra Long'
	END AS Duration
FROM Games AS g
ORDER BY g.Name ASC, Duration ASC, [Part of the Day] ASC
 
/*Problem 16*/
USE ORDERS

SELECT ProductName,
	   OrderDate, 
	   DATEADD(DAY, 3, OrderDate) AS [Pay Due],
	   DATEADD(MONTH, 1, OrderDate) AS [Deliver Due]
FROM Orders


