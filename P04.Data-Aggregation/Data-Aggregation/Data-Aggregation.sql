USE Gringotts
/*Problem 1*/
SELECT COUNT(*) FROM WizzardDeposits

/*Problem 2*/
SELECT MAX(MagicWandSize) as [LongestMagicWand] FROM WizzardDeposits

/*Problem 3*/
SELECT DepositGroup, MAX(MagicWandSize) as [LongestMagicWand] 
FROM WizzardDeposits
GROUP BY DepositGroup

/*Problem 4*/
SELECT TOP 2 DepositGroup
FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY  AVG(MagicWandSize) ASC

/*Problem 5*/
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
GROUP BY DepositGroup

/*Problem 6*/
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup

/*Problem 7*/
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup
HAVING SUM(DepositAmount) < 150000
ORDER BY TotalSum DESC

/*Problem 8*/
SELECT DepositGroup,
	   MagicWandCreator, 
	   MIN(DepositCharge) AS [MinDepositCharge]
FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator
ORDER BY MagicWandCreator ASC, DepositGroup ASC

/*Problem 9*/
USE Gringotts

SELECT w.AgeGroup, COUNT(w.AgeGroup) AS [WizardCount] FROM
( SELECT 
	CASE 
	WHEN Age BETWEEN 0 AND 10 THEN  '[0-10]'
	WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
	WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
	WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
	WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
	WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
	ELSE '[61+]'
END AS [AgeGroup]
FROM WizzardDeposits) AS w
GROUP BY w.AgeGroup

/*Problem 10*/
SELECT DISTINCT LEFT(w.FirstName, 1) AS [FirstLetter]  
FROM WizzardDeposits AS w
WHERE w.DepositGroup = 'Troll Chest'
ORDER BY FirstLetter

/*Problem 11*/

SELECT w.DepositGroup, 
	   w.IsDepositExpired, 
	   AVG(w.DepositInterest) AS [AverageInterest]
FROM WizzardDeposits AS w
WHERE w.DepositStartDate > '01-01-1985'
GROUP BY w.DepositGroup, w.IsDepositExpired
ORDER BY w.DepositGroup DESC, w.IsDepositExpired

/*Problem 12*/
DECLARE @cnt INT = 1;
DECLARE @diff DECIMAL(15,2);

SELECT DepositAmount, ROW_NUMBER() OVER(ORDER BY DepositAmount)
FROM WizzardDeposits

/*Problem 13*/
USE SoftUni

SELECT d.DepartmentID , SUM(d.Salary) AS [TotalSalary]
FROM Employees as d
GROUP BY d.DepartmentID
ORDER BY DepartmentID

/*Problem 14*/

SELECT e.DepartmentId,
	   MIN(e.Salary) AS [MinimumSalary]
FROM Employees AS e
WHERE e.DepartmentID = 2 OR
	  e.DepartmentID = 5 OR
	  e.DepartmentID = 7 AND
	  e.HireDate > '01-01-2000'
GROUP BY e.DepartmentID

/*Problem 15*/
SELECT *
INTO FilteredSalaryTable
FROM Employees AS e
WHERE e.Salary > 30000 
DELETE FROM FilteredSalaryTable
WHERE ManagerId = 42
UPDATE FilteredSalaryTable
SET Salary += 5000
WHERE DepartmentID = 1;
SELECT DepartmentId,
	   AVG(f.Salary)
FROM FilteredSalaryTable AS f
GROUP BY f.DepartmentID

/*Problem 16*/
SELECT e.DepartmentID,
	   MAX(e.Salary) AS [MaxSalary]
FROM Employees AS e
WHERE e.Salary < 30000 OR e.Salary > 70000
GROUP BY e.DepartmentID

/*Problem 17*/
SELECT COUNT(e.Salary) AS [Count] FROM Employees AS e
WHERE e.ManagerID IS NULL

/*Problem 18*/
SELECT TOP 5 e.DepartmentID,
	   e.Salary AS [ThirdHighestSalary]
FROM Employees AS e
GROUP BY e.DepartmentID, e.Salary


SELECT TOP 10 Salary FROM Employees
ORDER BY Salary DESC



/*Problem 19*/
USE SoftUni

SELECT TOP 10 FirstName,
	   LastName,
	   DepartmentId
FROM Employees AS e
WHERE e.Salary > (SELECT AVG(Salary) 
				  FROM Employees as ea
				  GROUP BY ea.DepartmentID
				  HAVING ea.DepartmentID = e.DepartmentID)




