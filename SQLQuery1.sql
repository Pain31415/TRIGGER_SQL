USE [db_Trigger_sql];
GO

INSERT INTO Products (Name, Type, Quantity, Cost, Manufacturer, SellingPrice)
VALUES ('Футбольний мяч', 'Спортивний інвентар', 50, 10.00, 'Nike', 25.00),
       ('Тенісні ракетки', 'Спортивний інвентар', 30, 20.00, 'Wilson', 50.00),
       ('Бігова куртка', 'Одяг', 40, 30.00, 'Adidas', 80.00);
GO

INSERT INTO Sales (ProductID, SalePrice, Quantity, SaleDate, EmployeeID, CustomerID)
VALUES (1, 25.00, 2, '2024-04-20', 1, NULL),
       (2, 50.00, 1, '2024-04-20', 2, 1),
       (3, 80.00, 1, '2024-04-21', 1, 2);
GO

INSERT INTO Employees (FullName, Position, HireDate, Gender, Salary)
VALUES ('Іваненко Петро Петрович', 'Продавець-консультант', '2020-01-10', 'Чоловіча', 30000.00),
       ('Петренко Олена Вікторівна', 'Менеджер з продажу', '2019-05-15', 'Жіноча', 35000.00);
GO

INSERT INTO Customers (FullName, Email, Phone, Gender, OrderHistory, DiscountRate, Subscribed)
VALUES ('Коваленко Василь', 'vasyakovalenko@example.com', '+1234567890', 'Чоловіча', 'Заказ №1234', 5.00, 1),
       ('Петрів Анна', 'annapetrenko@example.com', '+0987654321', 'Жіноча', 'Заказ №5678', 10.00, 0);
GO