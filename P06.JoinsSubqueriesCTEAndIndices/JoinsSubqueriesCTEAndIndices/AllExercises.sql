/*Problem 1*/
USE SoftUni
SELECT TOP 5 e.EmployeeID, e.JobTitle, a.AddressID, a.AddressText
FROM Employees AS e
INNER JOIN Addresses AS a ON e.AddressID = a.AddressID
ORDER BY e.AddressID ASC

/*Problem 2*/
SELECT TOP 50 e.FirstName, e.LastName,
	   t.[Name], a.AddressText
FROM Employees AS e
INNER JOIN Addresses AS a ON e.AddressID = a.AddressID
INNER JOIN Towns AS t ON t.TownID = a.TownID
ORDER BY e.FirstName ASC, e.LastName ASC

/*Problem 3*/
SELECT e.EmployeeID, e.FirstName,
	   e.LastName, d.[Name]
FROM Employees AS e
INNER JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentID = 3

/*Problem 4*/
SELECT TOP 5 e.EmployeeID, e.FirstName,
	   e.Salary, d.[Name]
FROM Employees e
INNER JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE e.Salary > 15000
ORDER  BY e.DepartmentID ASC

/*Problem 5*/
SELECT TOP 3 e.EmployeeID, e.FirstName
FROM Employees e
WHERE e.EmployeeID NOT IN (
	SELECT DISTINCT ep.EmployeeID
	FROM EmployeesProjects ep
)
ORDER BY e.EmployeeID ASC 

/*Problem 6*/
SELECT e.FirstName, e.LastName,
	   e.HireDate, d.[Name]
FROM Employees e
INNER JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE e.HireDate > '1/1/1999' AND
	  e.DepartmentID = 3 OR e.DepartmentID = 10
ORDER BY e.HireDate

/*Problem 7*/
SELECT TOP 5 e.EmployeeID, e.FirstName,
	   p.[Name]
FROM Employees e
INNER JOIN EmployeesProjects ep ON ep.EmployeeID = e.EmployeeID
INNER JOIN Projects p ON p.ProjectID = ep.ProjectID
WHERE p.StartDate > '08/13/2002' AND
	  p.EndDate IS NULL
ORDER BY e.EmployeeID ASC

/*Problem 8*/
SELECT e.EmployeeID, e.FirstName,
CASE
	WHEN e.EmployeeID = 24 AND 
	     p.StartDate > '2004' THEN NULL
	ELSE p.[Name]
END AS [ProjectName]
FROM Employees e
INNER JOIN EmployeesProjects ep ON ep.EmployeeID = e.EmployeeID
INNER JOIN Projects p ON p.ProjectID = ep.ProjectID
WHERE e.EmployeeID = 24

/*Problem 9*/
SELECT e.EmployeeID, e.FirstName, e.ManagerID, ep.FirstName as [ManagerName]
FROM Employees e
INNER JOIN Employees ep ON e.ManagerID = ep.EmployeeID 
WHERE e.ManagerID = 3 OR e.ManagerID = 7
ORDER BY e.EmployeeID ASC

/*Problem 10*/
SELECT TOP 50 e.EmployeeID, 
		e.FirstName + ' ' + e.LastName as [EmployeeName],
	    ep.FirstName + ' ' + ep.LastName as [ManagerName], 
		d.Name as [DepartmentName]
FROM Employees e
INNER JOIN Employees ep ON e.ManagerID = ep.EmployeeID
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
ORDER BY e.EmployeeID ASC

/*Problem 11*/
SELECT TOP 1 AVG(e.Salary) as [MinAverageSalary]
FROM Employees e
GROUP BY e.DepartmentID
ORDER BY MinAverageSalary

/*Problem 12*/
USE Geography

SELECT mc.CountryCode, m.MountainRange, p.PeakName, p.Elevation
FROM Peaks p
INNER JOIN MountainsCountries mc ON p.MountainId = mc.MountainId
INNER JOIN Mountains m ON p.MountainId = m.Id
WHERE mc.CountryCode = 'BG' AND
	  p.Elevation > 2835
ORDER BY p.Elevation DESC

/*Problem 13*/
SELECT mc.CountryCode, COUNT(r.MountainRange) as [MountainRanges]
FROM MountainsCountries mc
INNER JOIN Mountains r ON mc.MountainId = r.Id
GROUP BY mc.CountryCode
HAVING mc.CountryCode = 'BG' OR
		mc.CountryCode = 'RU' OR
		mc.CountryCode = 'US'

/*Problem 14*/
SELECT TOP 5 c.CountryName, r.RiverName
FROM Countries AS c
INNER JOIN Continents AS cont ON cont.ContinentCode = c.ContinentCode
LEFT JOIN CountriesRivers cr ON c.CountryCode = cr.CountryCode 
LEFT JOIN Rivers r ON cr.RiverId = r.Id
WHERE cont.ContinentName = 'Africa'
ORDER BY c.CountryName ASC

/*Problem 15*/


/*Problem 16*/
SELECT COUNT(c.CountryCode) as CountryCode
FROM Countries as c
LEFT JOIN MountainsCountries AS m ON m.CountryCode = c.CountryCode
WHERE m.CountryCode IS NULL

/*Problem 17*/
SELECT TOP 5 c.CountryName, 
			 MAX(p.Elevation) as [HighestPeakElevation],
			 MAX(r.Length)  as [LongestRiverLength]
FROM Countries AS c
LEFT JOIN MountainsCountries AS m ON m.CountryCode = c.CountryCode
LEFT JOIN Peaks AS p ON p.MountainId = m.MountainId
LEFT JOIN CountriesRivers AS cr ON cr.CountryCode = c.CountryCode
LEFT JOIN Rivers AS r ON r.Id = cr.RiverId
GROUP BY c.CountryName
ORDER BY HighestPeakElevation DESC, LongestRiverLength DESC, c.CountryName






SELECT * FROM Peaks

SELECT * FROM MountainsCountries
SELECT * FROM Countries

SELECT * FROM Mountains

SELECT * FROM CountriesRivers
SELECT * FROM Rivers




