CREATE DATABASE Relations

USE Relations

/*Problem 1*/
CREATE TABLE Persons (
	PersonID INT NOT NULL IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	Salary DECIMAL(15,2) NOT NULL,
	PassportID INT NOT NULL
)

INSERT INTO Persons(FirstName, Salary, PassportID) VALUES
	('Roberto', 4330.00, 102),
	('Tom', 56100.00, 103),
	('Yana', 60200.00, 101)

CREATE TABLE Passports(
	PassportID INT NOT NULL PRIMARY KEY IDENTITY(101, 1),
	PassportNumber NVARCHAR(50) NOT NULL
)

INSERT INTO Passports(PassportNumber) VALUES
	('N34FG21B'),
	('K65LO4R7'),
	('ZE657QP2')

ALTER TABLE Persons
ADD PRIMARY KEY(PersonID)

ALTER TABLE Persons
ADD FOREIGN KEY(PassportID) REFERENCES Passports(PassportID)

/*Problem 2*/
CREATE TABLE Models(
	ModelID INT IDENTITY(101, 1) NOT NULL,
	Name NVARCHAR(50),
	ManufacturerID INT NOT NULL
	CONSTRAINT PK_ModelID PRIMARY KEY (ModelID)
)


CREATE TABLE Manufacturers(
	ManufacturerID INT IDENTITY NOT NULL,
	Name NVARCHAR(50),
	EstablishedOn DATETIME NOT NULL,
	CONSTRAINT PK_ManufacturerID PRIMARY KEY (ManufacturerID)
)

INSERT INTO Models(Name, ManufacturerID) VALUES
	('X1', 1),
	('i6', 1),
	('Model S', 2),
	('Model X', 2),
	('Model 3', 2),
	('Nova', 3)

INSERT INTO Manufacturers([Name], EstablishedOn) VALUES
	('BMW', '07/03/1916'),
	('Tesla', '01/01/2003'),
	('Tesla', '01/05/1966')

ALTER TABLE Models
ADD FOREIGN KEY(ManufacturerID) REFERENCES Manufacturers(ManufacturerID)

/*Problem 3*/
CREATE TABLE Students(
	StudentID INT IDENTITY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	CONSTRAINT PK_StudentID PRIMARY KEY(StudentID)
)

CREATE TABLE Exams(
	ExamID INT IDENTITY(101, 1) NOT NULL,
	[Name] NVARCHAR(50),
	CONSTRAINT PK_ExamID PRIMARY KEY(ExamID)
)

CREATE TABLE StudentsExams(
	StudentID INT NOT NULL REFERENCES Students(StudentID),
	ExamID INT NOT NULL REFERENCES Exams(ExamID),
	PRIMARY KEY(StudentID, ExamID)
)

INSERT INTO Students([Name]) VALUES
('Mila'),
('Toni'),
('Ron')

INSERT INTO Exams([Name]) VALUES
('SpringMVC'),
('Neo4j'),
('Oracle 11g')

INSERT INTO StudentsExams(StudentID, ExamID) VALUES
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103)

SELECT * FROM StudentsExams

/*Problem 4*/
CREATE TABLE Teachers(
	TeacherID INT IDENTITY(101, 1) NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	ManagerID INT
)

ALTER TABLE Teachers
ADD PRIMARY KEY(TeacherID)

ALTER TABLE Teachers
ADD FOREIGN KEY(ManagerID) REFERENCES Teachers(TeacherID)

INSERT INTO Teachers([Name], ManagerID) VALUES
	('John', NULL),
	('Maya', 106),
	('Silvia', 106),
	('Ted', 105),
	('Mark', 101),
	('Greta', 101)


SELECT Students.Name, Exams.Name
FROM StudentsExams se
INNER JOIN Students ON se.StudentID = Students.StudentID
JOIN Exams ON se.ExamID = Exams.ExamID

SELECT* FROM Students

/*Problem 5*/
CREATE DATABASE Store

USE Store


CREATE TABLE Cities(
	CityID INT NOT NULL IDENTITY,
	[Name] VARCHAR(50) NOT NULL
	CONSTRAINT PK_CityID PRIMARY KEY(CityID)
)

CREATE TABLE Customers(
	CustomerID INT IDENTITY NOT NULL,
	[Name] VARCHAR(50) NOT NULL,
	Birthday DATE NOT NULL,
	CityID INT NOT NULL,
	CONSTRAINT FK_CustomerCity FOREIGN KEY (CityID) 
	REFERENCES Cities(CityID),
	CONSTRAINT PK_CustomerID PRIMARY KEY(CustomerID)
)
CREATE TABLE ItemTypes(
	ItemTypeID INT IDENTITY NOT NULL,
	[Name] VARCHAR(50) NOT NULL,
	CONSTRAINT PK_ItemTypeID PRIMARY KEY(ItemTypeID)
)
CREATE TABLE Items(
	ItemID INT IDENTITY NOT NULL,
	[Name] VARCHAR(50) NOT NULL,
	ItemTypeID INT NOT NULL,
	CONSTRAINT PK_ItemID PRIMARY KEY(ItemID),
	CONSTRAINT FK_ItemTypeID FOREIGN KEY(ItemTypeID)
	REFERENCES ItemTypes(ItemTypeID)
)
CREATE TABLE Orders(
	OrderID INT NOT NULL IDENTITY,
	CustomerID INT NOT NULL,
	CONSTRAINT FK_CustomerID FOREIGN KEY (CustomerID) 
	REFERENCES Customers(CustomerID),
	CONSTRAINT PK_OrderID PRIMARY KEY(OrderID)
)

CREATE TABLE OrderItems(
	OrderID INT NOT NULL,
	ItemID INT NOT NULL,
	CONSTRAINT PK_OrderItems PRIMARY KEY(OrderID, ItemID),
	CONSTRAINT FK_ItemID FOREIGN KEY(ItemID)
	REFERENCES Items(ItemID),
	CONSTRAINT FK_OrderItems_OrderID
	FOREIGN KEY(OrderID)
	REFERENCES Orders(OrderID)
)


/*Problem 6*/
CREATE DATABASE University

USE University

CREATE TABLE Majors(
	MajorID INT IDENTITY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL

	CONSTRAINT PK_Majors_MajorID 
	PRIMARY KEY(MajorID)
)

CREATE TABLE Students(
	StudentID INT IDENTITY NOT NULL,
	StudentNumber INT NOT NULL,
	StudentName NVARCHAR(50) NOT NULL,
	MajorID INT NOT NULL,

	CONSTRAINT PK_Students_StudentID 
	PRIMARY KEY(StudentID),
	
	CONSTRAINT FK_Students_MajorID
	FOREIGN KEY(MajorID) REFERENCES Majors(MajorID)
)

CREATE TABLE Payments(
	PaymentID INT IDENTITY NOT NULL,
	PaymentDate DATETIME NOT NULL,
	PaymentAmount DECIMAL NOT NULL,
	StudentID INT NOT NULL,

	CONSTRAINT PK_Payments_PaymentID 
	PRIMARY KEY(PaymentID),

	CONSTRAINT FK_Payments_StudentID
	FOREIGN KEY(StudentID) REFERENCES Students(StudentID)
)

CREATE TABLE Subjects(
	SubjectID INT IDENTITY NOT NULL,
	SubjectName NVARCHAR(50) NOT NULL,

	CONSTRAINT PK_Subjects_SubjectID
	PRIMARY KEY(SubjectID)
)

CREATE TABLE Agenda(
	StudentID INT NOT NULL,
	SubjectID INT NOT NULL,

	CONSTRAINT PK_Agenda_SubjectID_StudentID
	PRIMARY KEY(StudentID, SubjectID),

	CONSTRAINT FK_Agenda_SubjectID
	FOREIGN KEY(SubjectID) REFERENCES Subjects(SubjectID),

	CONSTRAINT FK_Agenda_StudentID
	FOREIGN KEY(StudentID) REFERENCES Students(StudentID)
)

/*Problem 9*/
USE Geography

SELECT * FROM Peaks

SELECT * FROM Mountains

SELECT m.MountainRange, p.PeakName, p.Elevation
FROM Mountains AS m
INNER JOIN Peaks AS p ON m.Id = p.MountainId
WHERE m.MountainRange = 'Rila'
ORDER BY p.Elevation DESC
