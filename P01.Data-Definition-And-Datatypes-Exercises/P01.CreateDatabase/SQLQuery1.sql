CREATE DATABASE Minions

USE Minions

CREATE TABLE Minions(
	Id INT PRIMARY KEY,
	Name NVARCHAR(25) NOT NULL,
	Age INT,
)



CREATE TABLE Towns(
	Id INT PRIMARY KEY,
	Name NVARCHAR(25) NOT NULL,
)


ALTER TABLE Minions
ADD TownId INT
FOREIGN KEY (TownId) REFERENCES Towns(Id)

INSERT INTO Towns(Id, Name)
VALUES(1, 'Sofia'),
		(2, 'Plovdiv'),
		(3, 'Varna')

INSERT INTO Minions(Id, Name, Age, TownId) 
VALUES(1, 'Kevin', 22, 1), 
(2, 'Bob', 15, 3), 
(3, 'Steward', NULL, 2)

TRUNCATE TABLE Minions

DROP TABLE IF EXISTS Minions, Towns


CREATE TABLE People(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(200) NOT NULL,
	Picture VARBINARY CHECK(DATALENGTH(Picture) <= 2 * 1024 * 1024),
	Height DECIMAL(15, 2),
	Weight DECIMAL(5, 2),
	Gender CHAR(1) CHECK(Gender IN ('m', 'f')) NOT NULL,
	Birthdate DATE NOT NULL,
	Biography NVARCHAR(MAX)
)

INSERT INTO People(Name, Picture, Height, Weight, Gender, Birthdate, Biography)
VALUES
	('Gosho', NULL, 1.60, 60.0, 'm', '04-01-1993', NULL),
	('Pesho', NULL, 1.65, 65.25, 'm', '07-11-1993',NULL),
	('Mimi', NULL, 1.23, 68.12, 'f', '1993-12-31', NULL),
	('Conka', NULL, 1.70, 40.11, 'f', '03-10-1993', NULL),
	('Georgi', NULL, 1.80, 84.00, 'm', '04-04-1993',NULL)

TRUNCATE TABLE People

DROP TABLE Users
CREATE TABLE Users(
	Id INT IDENTITY(1,1) NOT NULL,
	Username NVARCHAR(30) UNIQUE NOT NULL,
	Password NVARCHAR(26) NOT NULL,
	ProfilePicture VARBINARY CHECK(DATALENGTH(ProfilePicture) <= 9 * 1024),
	LastLoginTime DATETIME,
	IsDeleted BIT NOT NULL
	CONSTRAINT PK_Users PRIMARY KEY (Id)
)

INSERT INTO Users(Username, Password, ProfilePicture, IsDeleted)
VALUES
	('dakh', '12345', NULL, 'FALSE'),
	('kaka', '12345', NULL, 'FALSE'),
	('shishkebaka', '12345', NULL, 'FALSE'),
	('bahmaamu', '12345', NULL, 'FALSE'),
	('giotere', '12345', NULL, 'FALSE')

ALTER TABLE Users
DROP CONSTRAINT PK_Users

ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id, Username);

ALTER TABLE Users
ADD CONSTRAINT CK_Password  CHECK(DATALENGTH(Password) > 5)

ALTER TABLE Users
ADD CONSTRAINT DEF_LastLogin  DEFAULT GETDATE() FOR LastLoginTime

ALTER TABLE Users
DROP CONSTRAINT PK_Users

ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id)

ALTER TABLE Users
ADD CONSTRAINT MIN_Username_Length CHECK(LEN(Username) >= 3)