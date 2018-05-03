CREATE DATABASE Hotel

USE Hotel

CREATE TABLE Employees(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Title NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(100)
)

INSERT INTO Employees(FirstName, LastName, Title, Notes) VALUES
	('Gosho', 'Borachev', 'BORAVI', NULL),
	('Pesho', 'Baluka', 'NE ZNAE KVO STAA', NULL),
	('Gergi', 'Bonchev', 'BONI', NULL)

CREATE TABLE Customers(
	AccountNumber INT PRIMARY KEY IDENTITY NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	PhoneNumber INT,
	EmergencyName NVARCHAR(50) NOT NULL,
	EmergencyNumber INT NOT NULL,
	Notes NVARCHAR(100) 
)

INSERT INTO Customers(FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes) VALUES
	('Delina', 'Boracheva', 0888888888, 'Daniel', 0888888889, NULL),
	('Daniel', 'Buxev', 0883888888, 'Angel', 0888888829, NULL),
	('Angel', 'Buxev', 0888588888, 'Daniel', 0888688889, NULL)

/* RoomStatus may have to be primary key and type: BIT*/
CREATE TABLE RoomStatus(
	RoomStatus INT PRIMARY KEY IDENTITY NOT NULL,
	Notes NVARCHAR(100)
)

INSERT INTO RoomStatus(Notes) VALUES
	(NULL),
	(NULL),
	(NULL)

CREATE TABLE RoomTypes(
	RoomType INT PRIMARY KEY IDENTITY NOT NULL,
	Notes NVARCHAR(100)
)

INSERT INTO RoomTypes(Notes) VALUES
	(NULL),
	(NULL),
	(NULL)

CREATE TABLE BedTypes(
	BedType INT PRIMARY KEY IDENTITY NOT NULL,
	Notes NVARCHAR(100)
)

INSERT INTO BedTypes(Notes) VALUES
	(NULL),
	(NULL),
	(NULL)

CREATE TABLE Rooms(
	RoomNumber INT PRIMARY KEY IDENTITY NOT NULL,
	RoomType INT FOREIGN KEY REFERENCES RoomTypes(RoomType) NOT NULL,
	BedType INT FOREIGN KEY REFERENCES BedTypes(BedType) NOT NULL,
	Rate DECIMAL(15, 2) NOT NULL,
	RoomStatus INT FOREIGN KEY REFERENCES RoomStatus(RoomStatus) NOT NULL,
	Notes NVARCHAR(50)
)

INSERT INTO Rooms(RoomType, BedType, Rate, RoomStatus, Notes) VALUES
	(1, 1, 25.23, 1, NULL),
	(2, 2, 23.23, 2, NULL),
	(2, 2, 45.23, 2, NULL)

CREATE TABLE Payments(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
	PaymentDate DATETIME NOT NULL,
	AccountNumber INT NOT NULL,
	FirstDateOccupied DATETIME NOT NULL,
	LastDateOccupied DATETIME NOT NULL,
	TotalDays INT NOT NULL,
	AmountCharged DECIMAL(15, 2) NOT NULL,
	TaxRate DECIMAL(15, 2) NOT NULL,
	TaxAmount DECIMAL(15, 2) NOT NULL,
	PaymentTotal DECIMAL(15, 2) NOT NULL,
	Notes NVARCHAR(100)
)

INSERT INTO Payments(EmployeeId, PaymentDate, AccountNumber,
					 FirstDateOccupied, LastDateOccupied, TotalDays,
					 AmountCharged, TaxRate, TaxAmount,
					 PaymentTotal, Notes) VALUES
	(1, '2018-01-12', 123456, '2018-01-13', '2018-01-19', 6, 325.25, 2.5, 500.30, 825.55, NULL),
	(2, '2017-01-12', 123456, '2017-01-13', '2017-01-19', 6, 425.25, 3.5, 600.30, 925.55, NULL),
	(3, '2016-01-12', 123456, '2016-01-13', '2016-01-19', 6, 525.25, 4.5, 700.30, 1025.55, NULL)

CREATE TABLE Occupancies(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	DateOccupied DATETIME NOT NULL,
	/*IT MAY NEED TO SET FOREIGN KEY TO CUSTOMERS=>ACCOUNT NUMBER*/
	AccountNumber INT FOREIGN KEY REFERENCES Customers(AccountNumber) NOT NULL,
	RoomNumber INT FOREIGN KEY REFERENCES Rooms(RoomNumber) NOT NULL,
	RateApplied DECIMAL(15, 2) NOT NULL,
	PhoneCharge DECIMAL(15, 2) NOT NULL,
	Notes NVARCHAR(50)
)

INSERT INTO Occupancies(EmployeeId, DateOccupied, AccountNumber,
						RoomNumber, RateApplied, PhoneCharge, Notes) VALUES
	(1, '2018-01-13', 1, 1, 1.5, 35.90, NULL),
	(2, '2017-01-13', 2, 2, 2.5, 45.90, NULL),
	(3, '2016-01-13', 3, 3, 3.5, 55.90, NULL)

UPDATE Payments
SET TaxRate -= TaxRate * 0.03;

SELECT TaxRate FROM Payments


TRUNCATE TABLE Occupancies