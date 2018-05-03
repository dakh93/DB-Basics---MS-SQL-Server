CREATE DATABASE CarRental


USE CarRental

CREATE TABLE Categories(
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	CategoryName NVARCHAR(50) NOT NULL,
	DailyRate DECIMAL(15,2) NOT NULL,
	WeeklyRate DECIMAL (15,2) NOT NULL,
	MonthlyRate DECIMAL (15,2) NOT NULL,
	WeekendRate DECIMAL(15,2) NOT NULL
)

INSERT INTO Categories(CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate) VALUES
	('SPORT', 5.2, 37, 20, 44),
	('Casual', 1.2, 17, 10, 24),
	('FUN', 10.2, 57.2, 30.1, 80.3)

CREATE TABLE Cars(
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	/* Plate number may have to be NVARCHAR */
	PlateNumber INT NOT NULL,
	Manufacturer NVARCHAR(50) NOT NULL,
	Model NVARCHAR(50) NOT NULL,
	CarYear INT NOT NULL,
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
	Doors INT NOT NULL,
	Picture VARBINARY,
	Condition NVARCHAR(50) NOT NULL,
	Available BIT NOT NULL
)

INSERT INTO Cars(PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available) VALUES
	(18854, 'Honda Motors', 'Honda Prelude', 1997, 2, 2, NULL, 'New', 'True'),
	(12341, 'Honda Motors', 'Honda Civic', 2003, 1, 5, NULL, 'New', 'False'),
	(99999, 'Honda Motors', 'Honda NSX', 1993, 3, 2, NULL, 'New', 'True')

CREATE TABLE Employees(
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Title NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(50)
)

INSERT INTO Employees(FirstName, LastName, Title, Notes) VALUES
	('Bai', 'Ivan', 'IT Specialist', NULL),
	('Bai', 'HUI', 'PUSSIELIST', 'TAPANI GI VSICHKITE...CELIQ VUTRE SUH'),
	('SIR STENLEY', 'ROIS', 'PUSSSY VETERAN', 'DA Q BOLI DA PLACHE, I DA TURSI MAIKA SI...')

CREATE TABLE Customers(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	/* MAY HAVE TO BE INTEGER*/
	DriverLicenceNumber NVARCHAR(10) NOT NULL,
	FullName NVARCHAR(50) NOT NULL,
	[Address] NVARCHAR(50) NOT NULL,
	City NVARCHAR(50) NOT NULL,
	ZipCode NVARCHAR(20),
	Notes NVARCHAR(100)
)

INSERT INTO Customers(DriverLicenceNumber, FullName, [Address], City, ZipCode, Notes) VALUES
	('12345', 'Bai Hristo', 'Stara planina 31', 'Haskovo', NULL, NULL),
	('453', 'Bai GIOTURE', 'NA MAIKA TI PRIRODATA 27', 'Haskovo', NULL, NULL),
	('0001', 'Bai HUI', 'Rakovska 31', 'Haskovo', NULL, NULL)

CREATE TABLE RentalOrders(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	CustomerId INT FOREIGN KEY REFERENCES Customers(Id) NOT NULL,
	CarId INT FOREIGN KEY REFERENCES Cars(Id) NOT NULL,
	TankLevel DECIMAL(15, 2) NOT NULL,
	KilometrageStart DECIMAL (15, 2) NOT NULL,
	KilometrageEnd DECIMAL (15, 2) NOT NULL,
	TotalKilometrage DECIMAL(15, 2) NOT NULL,
	StartDate DATETIME NOT NULL,
	EndDate DATETIME NOT NULL,
	TotalDays INT NOT NULL,
	RateApplied DECIMAL (15, 2) NOT NULL,
	TaxRate DECIMAL (15, 2) NOT NULL,
	OrderStatus BIT NOT NULL,
	Notes NVARCHAR(100)
)

INSERT INTO RentalOrders(EmployeeId, CustomerId, CarId, 
						TankLevel, KilometrageStart, KilometrageEnd,
						TotalKilometrage, StartDate, EndDate,
						TotalDays, RateApplied, TaxRate,
						OrderStatus, Notes) VALUES
	(1, 1, 1, 45.50, 120000, 130000, 10000, '2001-2-24', '2001-2-28', 7, 25.0, 35.0, 'True', NULL),
	(2, 2, 2, 45.50, 120000, 130000, 10000, '2001-3-20', '2001-2-27', 7, 15.0, 75.0, 'True', NULL),
	(3, 1, 2, 45.50, 120000, 130000, 10000, '2001-4-2', '2001-4-29', 22, 65.0, 32.0, 'True', NULL)

