USE [db_Trigger_sql];
GO

CREATE TRIGGER RecordSaleHistory
ON Sales
AFTER INSERT
AS
BEGIN
    INSERT INTO SaleHistory (ProductID, SalePrice, Quantity, SaleDate, EmployeeID, CustomerID)
    SELECT ProductID, SalePrice, Quantity, SaleDate, EmployeeID, CustomerID
    FROM inserted;
END;
GO

CREATE TRIGGER MoveToArchive
ON Sales
AFTER UPDATE
AS
BEGIN
    INSERT INTO Archive (ProductID, SalePrice, Quantity, SaleDate, EmployeeID, CustomerID)
    SELECT ProductID, SalePrice, Quantity, SaleDate, EmployeeID, CustomerID
    FROM deleted
    WHERE NOT EXISTS (SELECT * FROM Products WHERE Products.ProductID = deleted.ProductID);
END;
GO

CREATE TRIGGER CheckExistingCustomer
ON Customers
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM Customers INNER JOIN inserted ON Customers.FullName = inserted.FullName OR Customers.Email = inserted.Email)
    BEGIN
        RAISERROR ('Клієнт з таким ім\ям або email вже існує.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO Customers (FullName, Email, Phone, Gender, OrderHistory, DiscountRate, Subscribed)
        SELECT FullName, Email, Phone, Gender, OrderHistory, DiscountRate, Subscribed FROM inserted;
    END
END;
GO

CREATE TRIGGER PreventCustomerDeletion
ON Customers
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR ('Видалення клієнтів заборонено.', 16, 1);
    ROLLBACK TRANSACTION;
END;
GO

CREATE TRIGGER PreventEmployeeDeletion
ON Employees
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM deleted WHERE HireDate < '2015-01-01')
    BEGIN
        RAISERROR ('Видалення працівників, прийнятих на роботу до 2015 року, заборонено.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        DELETE FROM Employees WHERE EmployeeID IN (SELECT EmployeeID FROM deleted);
    END
END;
GO

CREATE TRIGGER SetDiscount
ON Sales
AFTER INSERT
AS
BEGIN
    UPDATE Customers
    SET DiscountRate = 15
    WHERE CustomerID IN (
        SELECT CustomerID
        FROM inserted i
        INNER JOIN Customers c ON i.CustomerID = c.CustomerID
        GROUP BY CustomerID
        HAVING SUM(SalePrice * Quantity) > 50000
    );
END;
GO

CREATE TRIGGER PreventManufacturerAddition
ON Products
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE Manufacturer = 'Спорт, сонце та штанга')
    BEGIN
        RAISERROR ('Додавання товару фірми "Спорт, сонце та штанга" заборонено.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO Products (Name, Type, Quantity, Cost, Manufacturer, SellingPrice)
        SELECT Name, Type, Quantity, Cost, Manufacturer, SellingPrice FROM inserted;
    END
END;
GO

CREATE TRIGGER RecordLastUnit
ON Products
AFTER UPDATE
AS
BEGIN
    INSERT INTO LastUnit (ProductID, Quantity)
    SELECT ProductID, Quantity
    FROM inserted
    WHERE Quantity = 1;
END;
GO