USE [db_Trigger_sql];
GO

INSERT INTO Products (Name, Type, Quantity, Cost, Manufacturer, SellingPrice)
VALUES ('���������� ���', '���������� ��������', 50, 10.00, 'Nike', 25.00),
       ('����� �������', '���������� ��������', 30, 20.00, 'Wilson', 50.00),
       ('������ ������', '����', 40, 30.00, 'Adidas', 80.00);
GO

INSERT INTO Sales (ProductID, SalePrice, Quantity, SaleDate, EmployeeID, CustomerID)
VALUES (1, 25.00, 2, '2024-04-20', 1, NULL),
       (2, 50.00, 1, '2024-04-20', 2, 1),
       (3, 80.00, 1, '2024-04-21', 1, 2);
GO

INSERT INTO Employees (FullName, Position, HireDate, Gender, Salary)
VALUES ('�������� ����� ��������', '���������-�����������', '2020-01-10', '�������', 30000.00),
       ('�������� ����� ³�������', '�������� � �������', '2019-05-15', 'Ƴ����', 35000.00);
GO

INSERT INTO Customers (FullName, Email, Phone, Gender, OrderHistory, DiscountRate, Subscribed)
VALUES ('��������� ������', 'vasyakovalenko@example.com', '+1234567890', '�������', '����� �1234', 5.00, 1),
       ('����� ����', 'annapetrenko@example.com', '+0987654321', 'Ƴ����', '����� �5678', 10.00, 0);
GO