/*Problem 1*/
USE Bank

CREATE TABLE Logs(
	LogId INT IDENTITY(1, 1) NOT NULL ,
	AccountId INT NOT NULL,
	OldSum DECIMAL(18, 2) NOT NULL,
	NewSum DECIMAL(18, 2) NOT NULL,
	PRIMARY KEY(LogID)
)
GO

CREATE TRIGGER tr_BalanceChangeLogger ON Accounts
FOR UPDATE
AS
BEGIN
	DECLARE @accountId INT = (SELECT Id FROM inserted);
	DECLARE @oldBalance DECIMAL(18, 2) = (SELECT Balance FROM deleted);
	DECLARE @newBalance DECIMAL(18, 2) = (SELECT Balance FROM inserted);

	IF(@newBalance <> @oldBalance)
	BEGIN
		INSERT INTO Logs(AccountId, OldSum, NewSum)
		VALUES(@accountId, @oldBalance, @newBalance)
	END

END

UPDATE Accounts
SET Balance += 50
WHERE Id = 1

/*Problem 2*/
CREATE TABLE NotificationEmails(
	Id INT IDENTITY(1, 1) NOT NULL,
	Recipient INT NOT NULL,
	Subject NVARCHAR(50) NOT NULL,
	Body NVARCHAR(100) NOT NULL,
	PRIMARY KEY(Id)
)

GO
CREATE TRIGGER tr_NotificationEmails ON Accounts
FOR UPDATE
AS
BEGIN
	DECLARE @recipient INT = (SELECT AccountHolderId FROM inserted)
	DECLARE @subject NVARCHAR(50) = 'Balance change for account: ' + CAST(@recipient AS VARCHAR(10));
	DECLARE @oldBalance DECIMAL(18, 2) = (SELECT Balance FROM deleted);
	DECLARE @newBalance DECIMAL(18, 2) = (SELECT Balance FROM inserted);
	DECLARE @body NVARCHAR(100) =
	 'On ' + CAST(GETDATE() AS NVARCHAR(50)) + ' your balance was changed from ' + CAST(@oldBalance AS NVARCHAR(50)) + ' to ' + CAST(@newBalance AS NVARCHAR(50));

	 IF(@newBalance <> @oldBalance)
	 BEGIN
		INSERT INTO NotificationEmails(Recipient, Subject, Body)
		VALUES(@recipient, @subject, @body)
	 END
	 
END

UPDATE Accounts
SET Balance += 50
WHERE Id = 3

GO
/*Problem 3*/
CREATE PROC usp_DepositMoney
	(@AccountId INT, @MoneyAmount DECIMAL(18, 4))
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Accounts
	SET Balance += @MoneyAmount
	WHERE Id = @AccountId

	
	IF(@@ROWCOUNT <> 1)
	BEGIN
		ROLLBACK;
		RAISERROR ('Zero or negative amount inserted.', 16, 1);
		RETURN;
	END

	COMMIT;
END

EXEC usp_DepositMoney 1, 20
GO

/*Problem 4*/
CREATE PROC usp_WithdrawMoney
	(@AccountId INT, @MoneyAmount DECIMAL(18, 4))
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Accounts
	SET Balance -= @MoneyAmount
	WHERE Id = @AccountId

	
	IF(@@ROWCOUNT <> 1)
	BEGIN
		ROLLBACK;
		RAISERROR ('Zero or negative amount inserted.', 16, 1);
		RETURN;
	END

	COMMIT;
END


EXEC usp_WithdrawMoney 1, 20
GO

/*Problem 5*/
CREATE PROC usp_TransferMoney
	(@SenderId INT,
	 @ReceiverId INT, 
	 @Amount DECIMAL(18, 4))
AS
BEGIN
	DECLARE @senderBalance DECIMAL(18, 4) = (SELECT Balance FROM Accounts WHERE Id = @SenderId);

	IF(@senderBalance IS NULL)
	BEGIN
		RAISERROR('Invalid sender account!', 16, 1);
		RETURN;
	END

	DECLARE @receiverBalance DECIMAL(18, 4) = (SELECT Balance FROM Accounts WHERE Id = @ReceiverID);

	IF(@receiverBalance IS NULL)
	BEGIN
		RAISERROR('Invalid receiver account!', 16, 1);
		RETURN;
	END

	IF(@SenderId = @ReceiverId)
	BEGIN 
		RAISERROR('Receiver and sender must be different account! ', 16, 1);
		RETURN;
	END


	IF(@Amount <= 0)
	BEGIN
		RAISERROR('Zero or negative amount inserted!', 16, 1);
		RETURN;
	END

	IF(@senderBalance >= @Amount)
	BEGIN 
		EXEC usp_WithdrawMoney @SenderId, @Amount;
	END
	
	EXEC usp_DepositMoney @ReceiverID, @Amount;
	
END
GO

/*Problem 6*/
USE Diablo

GO
/*Problem 8*/
USE SoftUni

GO
CREATE PROCEDURE usp_AssignProject
					(@employeeId INT, @projectId INT)
AS
BEGIN
	DECLARE @maxProjectsPerEmployee INT = 3;
	DECLARE @employeeProjectsCnt INT;

	BEGIN TRAN
	INSERT INTO EmployeesProjects(EmployeeID, ProjectID)
	VALUES(@employeeId, @projectId)

	SET @employeeProjectsCnt = 
		(SELECT COUNT(*) FROM EmployeesProjects
		 WHERE EmployeeID = @employeeId);

		 IF(@employeeProjectsCnt > @maxProjectsPerEmployee)
		 BEGIN 
			RAISERROR('The employee has too many projects!', 16, 1);
			ROLLBACK;
		 END
		 ELSE 
			COMMIT;
END


/*Problem 9*/
CREATE TABLE Deleted_Employees(
	Id INT NOT NULL IDENTITY(1, 1),
	EmployeeId INT NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	MiddleName NVARCHAR(50),
	JobTitle NVARCHAR(50),
	DepartmentId INT NOT NULL,
	Salary DECIMAL(18, 2) NOT NULL,
	PRIMARY KEY(EmployeeId)

)
GO


CREATE OR ALTER TRIGGER tr_DeletedEmployees ON Employees
FOR DELETE
AS
BEGIN

	
	DECLARE @employeeId INT = (SELECT EmployeeId FROM deleted);
	DECLARE @FirstName NVARCHAR(50) = (SELECT FirstName FROM deleted);
	DECLARE @LastName NVARCHAR(50) = (SELECT LastName FROM deleted);
	DECLARE @MiddleName NVARCHAR(50) = (SELECT MiddleName FROM deleted);
	DECLARE @JobTitle NVARCHAR(50) = (SELECT JobTitle FROM deleted);
	DECLARE @DepartmentId INT = (SELECT DepartmentID FROM deleted);
	DECLARE @Salary DECIMAL(18, 2) = (SELECT Salary FROM deleted);



	INSERT INTO Deleted_Employees(EmployeeId, FirstName, LastName, MiddleName, JobTitle, DepartmentId, Salary)
	VALUES(@employeeId, @FirstName, @LastName, @MiddleName, @JobTitle, @DepartmentId, @Salary)


END





