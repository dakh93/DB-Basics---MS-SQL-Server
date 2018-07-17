USE SoftUni
GO
/*Problem 1*/
CREATE PROC usp_GetEmployeesSalaryAbove35000 
AS
BEGIN
	SELECT e.FirstName, e.LastName
	FROM Employees AS e
	WHERE e.Salary > 35000
END

EXEC usp_GetEmployeesSalaryAbove35000

GO

/*Problem 2*/
CREATE PROC usp_GetEmployeesSalaryAboveNumber
	 (@MinSalary DECIMAL(18, 4))
AS
BEGIN
	SELECT e.FirstName, e.LastName
	FROM Employees AS e
	WHERE e.Salary >= @MinSalary
END

EXEC usp_GetEmployeesSalaryAboveNumber 48100

GO

/*Problem 3*/
CREATE PROC usp_GetTownsStartingWith 
	(@StartingString VARCHAR(15))
AS
BEGIN
	SELECT t.Name FROM Towns AS t
	WHERE t.Name LIKE @StartingString + '%'
END

EXEC usp_GetTownsStartingWith b

GO

/*Problem 4*/
CREATE PROC usp_GetEmployeesFromTown
	(@TownName VARCHAR(20))
AS
BEGIN
	SELECT e.FirstName, e.LastName
	FROM Employees AS e
	INNER JOIN Addresses AS a ON a.AddressID = e.AddressID
	INNER JOIN Towns AS t ON t.TownID = a.TownID
	WHERE t.Name = @TownName
END

EXEC usp_GetEmployeesFromTown Sofia

GO

/*Problem 5*/
CREATE FUNCTION ufn_GetSalaryLevel
	(@Salary DECIMAL(18,4))
RETURNS NVARCHAR(10)
AS
BEGIN
	DECLARE @SalaryLevel NVARCHAR(10);

	
	
	SET @SalaryLevel = 
	CASE
		WHEN @Salary < 30000 THEN 'Low'
		WHEN @Salary BETWEEN 30000 AND 50000 THEN 'Average'
		WHEN @Salary > 50000 THEN 'High'
	END
	
	 RETURN @SalaryLevel;
END

 GO

SELECT e.Salary,
	   dbo.ufn_GetSalaryLevel(e.Salary)
 FROM Employees AS e

 GO
 /*Problem 6*/
 CREATE PROC usp_EmployeesBySalaryLevel 
	(@LevelOfSalary NVARCHAR(10)) 
 AS
 BEGIN
	SELECT e.FirstName, e.LastName
	FROM Employees AS e
	WHERE dbo.ufn_GetSalaryLevel(e.Salary) = @LevelOfSalary
 END

 GO

 EXEC dbo.usp_EmployeesBySalaryLevel 'Low'

 GO

 /*Problem 7*/
 CREATE FUNCTION ufn_IsWordComprised
	(@setOfLetters NVARCHAR(MAX), @word NVARCHAR(MAX))
RETURNS BIT
AS
BEGIN
	DECLARE @IsComprised BIT = 1;
	DECLARE @cnt INT = 1;
	DECLARE @CurrentLetter CHAR;

	WHILE @cnt <= LEN(@word)
	BEGIN
		
		SET @CurrentLetter = SUBSTRING(@word, @cnt, 1);

		IF (CHARINDEX(@CurrentLetter, @setOfLetters) = 0)
			BEGIN
				SET @IsComprised = 0;
				BREAK;
			END
		
		SET @cnt += 1;
	END
	RETURN @IsComprised;
END

GO

/*Problem 8*/


/*Problem 9*/
USE Bank
GO

CREATE PROC usp_GetHoldersFullName
AS
BEGIN
	SELECT a.FirstName + ' ' + a.LastName AS [Full Name]
	FROM AccountHolders AS a
END

EXEC usp_GetHoldersFullName

GO

/*Problem 10*/
CREATE PROC usp_GetHoldersWithBalanceHigherThan (@Money DECIMAL (18,4))
AS
BEGIN
	WITH CTE_BalanceHigherThanGivenOne (HolderID) AS (
	SELECT a.AccountHolderId FROM Accounts AS a
	GROUP BY a.AccountHolderId
	HAVING SUM(a.Balance) > @Money
	)


	SELECT ah.FirstName AS  [First Name], ah.LastName AS [Last Name]
	FROM CTE_BalanceHigherThanGivenOne AS higherBalance
	INNER JOIN AccountHolders as ah ON ah.Id = higherBalance.HolderID
	ORDER BY ah.LastName, ah.FirstName
	
END
						
GO

/*Problem 11*/
CREATE FUNCTION ufn_CalculateFutureValue 
	(@sum DECIMAL(18, 4),
	 @rate FLOAT,
	 @numberOfYears INT )
RETURNS DECIMAL(18, 4)
AS
BEGIN
	DECLARE @result DECIMAL(18, 4);

	SET @result =  @sum * POWER(1 + @rate, @numberOfYears);


	RETURN @result;
END

GO

/*Problem 12*/
CREATE PROC usp_CalculateFutureValueForAccount
	(@accountId INT, @rate DECIMAL (18, 4)) 
AS
BEGIN
	SELECT @accountId AS [Account Id],
		   ah.FirstName AS [First Name],
		   ah.LastName AS [Last Name],
		   a.Balance AS [Current Balance],
		   dbo.ufn_CalculateFutureValue(a.Balance, @rate, 5) AS [Balance in 5 Years]
	FROM Accounts AS a
	INNER JOIN AccountHolders AS ah ON ah.Id = a.AccountHolderId
	WHERE a.Id = @accountId
END

GO
/*Problem 13*/


SELECT * FROM UsersGames

SELECT * FROM Games


SELECT dbo.ufn_CalculateFutureValue(1000, 0.10, 5)

SELECT * FROM Accounts

SELECT * FROM AccountHolders