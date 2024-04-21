USE [db_Trigger_sql];
GO

CREATE TRIGGER CheckAndUpdateStock
ON Products
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM Products p INNER JOIN inserted i ON p.ProductID = i.ProductID)
    BEGIN
        UPDATE Products
        SET Quantity = Quantity + i.Quantity
        FROM Products p
        INNER JOIN inserted i ON p.ProductID = i.ProductID;
    END
    ELSE
    BEGIN
        INSERT INTO Products (ProductID, Name, Type, Quantity, Cost, Manufacturer, SellingPrice)
        SELECT ProductID, Name, Type, Quantity, Cost, Manufacturer, SellingPrice
        FROM inserted;
    END
END;