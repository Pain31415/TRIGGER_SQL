USE [db_Trigger_sql];
GO

CREATE TRIGGER MoveToEmployeeArchive
ON Employees
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO EmployeeArchive (EmployeeID, FullName, Position, HireDate, Gender, Salary)
    SELECT EmployeeID, FullName, Position, HireDate, Gender, Salary
    FROM deleted;
END;