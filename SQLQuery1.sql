CREATE DATABASE [db_Trigger_sql];
GO
USE [db_Trigger_sql];
GO
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Type NVARCHAR(50) NOT NULL,
    Quantity INT NOT NULL,
    Cost MONEY NOT NULL,
    Manufacturer NVARCHAR(100) NOT NULL,
    SellingPrice MONEY NOT NULL
);
GO

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    SalePrice MONEY NOT NULL,
    Quantity INT NOT NULL,
    SaleDate DATE NOT NULL,
    EmployeeID INT NOT NULL,
    CustomerID INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
GO

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Position NVARCHAR(50) NOT NULL,
    HireDate DATE NOT NULL,
    Gender NVARCHAR(10) NOT NULL,
    Salary MONEY NOT NULL
);
GO

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    Gender NVARCHAR(10) NOT NULL,
    OrderHistory NVARCHAR(MAX),
    DiscountRate DECIMAL(5,2),
    Subscribed BIT
);
GO