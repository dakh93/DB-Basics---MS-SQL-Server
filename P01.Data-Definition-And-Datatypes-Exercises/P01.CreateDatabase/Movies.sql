CREATE DATABASE Movies


 USE Movies

 CREATE TABLE Directors(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	DirectorName NVARCHAR(100) NOT NULL,
	Notes NVARCHAR(MAX)
 )

 CREATE TABLE Genres(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	GenreName NVARCHAR(100) NOT NULL,
	Notes NVARCHAR(MAX)
 )

 CREATE TABLE Categories(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	CategoryName NVARCHAR(100) NOT NULL,
	Notes NVARCHAR(MAX)
 )

 CREATE TABLE Movies(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Title NVARCHAR(100) NOT NULL,
	DirectorId INT FOREIGN KEY REFERENCES Directors(Id) NOT NULL,
	CopyrightYear INT,
	Length DECIMAL(15,2) NOT NULL,
	GenreId INT FOREIGN KEY REFERENCES Genres(Id) NOT NULL,
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
	Rating INT,
	Notes NVARCHAR(MAX)
 )


 INSERT INTO Directors(DirectorName, Notes)
 VALUES
	('Gosho', NULL),
	('Pesho', 'GIOTERE LUMKA'),
	('Sasho', NULL),
	('Roko', NULL),
	('Giotereto', NULL)

INSERT INTO Genres(GenreName, Notes)
VALUES
	('Horror', 'GIOTERE STRASHEN'),
	('Comedy', 'GIOTERE SMQH'),
	('Adventure', 'GIOTERE IZMISLICA'),
	('Mistery', 'GIOTERE NE ZNAESH KAKVO SE SLUCHVA'),
	('Drama', 'GIOTERE DEPRESIQ')

INSERT INTO Categories(CategoryName, Notes)
VALUES
	('Kids', 'Animaiton for children'),
	('Teenagers', NULL),
	('Adults', 'YOU HAVE TO ASK YOUR MOM'),
	('Old People', NULL),
	('Out of your mind', 'ASK YOURSEFL...')

INSERT INTO Movies(Title, DirectorId,
					 CopyrightYear, Length, 
					 GenreId, CategoryId,
					  Rating, Notes)
VALUES
	('Aligator', 2, '1999', 1.45, 1, 3, 4.5, 'BIA GO' ),
	('Harry Potter', 1, '1999', 2.30, 3, 2, 9.8, 'SUPER' ),
	('Dumb and Dumber', 4, '1997', 2.10, 2, 5, 8.9, 'GIOTERE SMQH' ),
	('Outlaws', 5, '2005', 1.55, 5, 5, 7.5, 'Western movies are good' ),
	('Taxi V', 3, '2018', 1.45, 2, 5, 1.4, 'Cent' )