USE [db_Trigger_sql];
GO

CREATE TRIGGER PreventNewSeller
ON Sellers
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @TotalSellers INT;
    SELECT @TotalSellers = COUNT(*) FROM Sellers;

    IF @TotalSellers >= 6
    BEGIN
        RAISERROR ('Додавання нового продавця заборонено. Кількість продавців перевищує максимальну допустиму кількість.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO Sellers (SellerID, FullName, HireDate, Gender, Salary)
        SELECT SellerID, FullName, HireDate, Gender, Salary
        FROM inserted;
    END
END;