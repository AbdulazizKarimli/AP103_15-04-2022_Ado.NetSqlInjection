CREATE DATABASE PizzaMizza	

USE PizzaMizza

CREATE TABLE Sliders(
	Id INT PRIMARY KEY IDENTITY,
	[Image] NVARCHAR(255) NOT NULL,
	IsDeleted BIT DEFAULT 'false'
)

CREATE TABLE DeletedSliders (
	Id INT,
	[Image] NVARCHAR(255) NOT NULL,
)

CREATE TABLE Pizzas(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL UNIQUE,
	IsVegeterian BIT DEFAULT 'false',
	IsHalal BIT DEFAULT 'false',
	IsSpicy BIT DEFAULT 'false'
)

CREATE TABLE Sizes(
	Id INT PRIMARY KEY IDENTITY,
	Size NVARCHAR(100) NOT NULL
)

CREATE TABLE PizzasSizes(
	Id INT PRIMARY KEY IDENTITY,
	PizzaId INT FOREIGN KEY REFERENCES Pizzas(Id),
	SizeId INT FOREIGN KEY REFERENCES Sizes(Id),
	Price DECIMAL(18,2)
)

CREATE TABLE Ingredients(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(100) NOT NULL UNIQUE
)

CREATE TABLE PizzaIngredients(
	Id INT PRIMARY KEY IDENTITY,
	PizzaId INT FOREIGN KEY REFERENCES Pizzas(Id),
	IngredientId INT FOREIGN KEY REFERENCES Ingredients(Id)
)

CREATE TRIGGER RemoveSlider
ON Sliders
AFTER DELETE
AS
BEGIN
	DECLARE @Id INT, @Image NVARCHAR(100)
	SELECT @Id=Id, @Image=[Image] FROM deleted
	INSERT INTO DeletedSliders
	VALUES (@Id, @Image)
END

DELETE FROM Sliders
WHERE Id = 3