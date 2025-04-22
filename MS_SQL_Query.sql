--=========================--
-- 1. Create a Table       --
--=========================--
/*
Check if the table 'Products' does not exist,
then create it with 4 columns: ProductID, ProductName, Price, and Quantity.
*/
IF OBJECT_ID('Products', 'U') IS NULL
BEGIN
    CREATE TABLE Products (
        ProductID INT PRIMARY KEY,           -- Unique identifier for each product
        ProductName VARCHAR(100),            -- Name of the product
        Price DECIMAL(10, 2),                -- Price with 2 decimal places
        Quantity INT                         -- Quantity available in stock
    );
END;
GO

--================--  
-- 2. Insert Data  --  
--================--  
/*
Insert multiple rows into the 'Products' table.
Each row represents one product with its ID, name, price, and quantity.
*/
INSERT INTO Products (ProductID, ProductName, Price, Quantity) VALUES
(1, 'Laptop', 25990.00, 5),
(2, 'Keyboard', 990.00, 10),
(3, 'Mouse', 450.00, 15),
(4, 'Monitor', 4990.00, 3),
(5, 'USB Hub', 350.00, 20),
(6, 'Smartphone', 15990.00, 10),
(7, 'Tablet', 12990.00, 8),
(8, 'Headphones', 1990.00, 12),
(9, 'Webcam', 1500.00, 6),
(10, 'Mouse Pad', 150.00, 25),
(11, 'External HDD', 2990.00, 10),
(12, 'Charger', 450.00, 18),
(13, 'Power Bank', 890.00, 20),
(14, 'Bluetooth Speaker', 1290.00, 14),
(15, 'Camera', 18990.00, 4),
(16, 'Keyboard Case', 990.00, 8),
(17, 'Laptop Bag', 790.00, 30),
(18, 'USB Flash Drive', 150.00, 50),
(19, 'Monitor Stand', 700.00, 15),
(20, 'Docking Station', 2490.00, 7),
(21, 'Mouse Wireless', 550.00, 22),
(22, 'VR Headset', 7990.00, 5),
(23, 'Smartwatch', 2999.00, 6),
(24, 'Wireless Earbuds', 1500.00, 18),
(25, 'Webcam Stand', 250.00, 17),
(26, 'Graphic Tablet', 5490.00, 3),
(27, 'Laptop Cooling Pad', 990.00, 11),
(28, 'Projector', 4999.00, 2),
(29, 'Action Camera', 7999.00, 4),
(30, 'Game Controller', 1490.00, 10),
(31, 'Phone Stand', 350.00, 25),
(32, 'Network Cable', 100.00, 60),
(33, 'Ethernet Switch', 2200.00, 9),
(34, 'Wireless Router', 1500.00, 5),
(35, 'Portable Fan', 550.00, 20),
(36, 'Digital Camera', 18900.00, 2);
GO

--====================--
-- 3. Select Data     --
--====================--
/*
Get all products from the table.
*/
SELECT * FROM Products;

--=======================--
-- 4. Filter with WHERE  --
--=======================--
/*
Retrieve products with price greater than 1000.
*/
SELECT * FROM Products
WHERE Price > 1000;

--=====================--
-- 5. ORDER BY Sorting --
--=====================--
/*
Sort products by price in descending order.
*/
SELECT * FROM Products
ORDER BY Price DESC;

--=====================--
-- 6. LIKE Matching    --
--=====================--
/*
Find products whose names start with the letter 'M'.
*/
SELECT * FROM Products
WHERE ProductName LIKE 'M%';

--=====================--
-- 7. BETWEEN Range    --
--=====================--
/*
Find products priced between 400 and 5000.
*/
SELECT * FROM Products
WHERE Price BETWEEN 400 AND 5000;

--=====================--
-- 8. IN List Matching --
--=====================--
/*
Find products with specific ProductIDs.
*/
SELECT * FROM Products
WHERE ProductID IN (1, 3, 5);

--=====================--
-- 9. UPDATE Data      --
--=====================--
/*
Update the price of the product with ProductID = 1.
*/
UPDATE Products
SET Price = 24900.00
WHERE ProductID = 1;

--=====================--
-- 10. DELETE Data     --
--=====================--
/*
Delete the product with ProductID = 5.
*/
DELETE FROM Products
WHERE ProductID = 5;

--=============================--
-- 11. Aggregate with COUNT    --
--=============================--
/*
Count how many products are in the table.
*/
SELECT COUNT(*) AS TotalProducts FROM Products;

--=============================--
-- 12. Sumarize with SUM      --
--=============================--
/*
Calculate the total inventory value.
*/
SELECT SUM(Price * Quantity) AS TotalInventoryValue
FROM Products;

--=========================--
-- 13. GROUP BY + HAVING   --
--=========================--
/*
Group products by Quantity and only show groups with more than 1 item.
*/
SELECT Quantity, COUNT(*) AS CountPerQuantity
FROM Products
GROUP BY Quantity
HAVING COUNT(*) > 1;

--==========================--
-- 14. Create Orders Table   --
--==========================--
/*
Check if the table 'Orders' does not exist,
then create it with 5 columns: OrderID, ProductID, OrderDate, Quantity, and TotalAmount.
*/
IF OBJECT_ID('Orders', 'U') IS NULL
BEGIN
    CREATE TABLE Orders (
        OrderID INT PRIMARY KEY,               -- Unique identifier for each order
        ProductID INT,                         -- Foreign key referencing ProductID from Products table
        OrderDate DATETIME,                    -- The date when the order was placed
        Quantity INT,                          -- Quantity of the product ordered
        TotalAmount DECIMAL(10, 2),            -- Total price for the order (Quantity * Price)
        FOREIGN KEY (ProductID) REFERENCES Products(ProductID)  -- Foreign key constraint linking to Products table
    );
END;
GO

--==========================--
-- 15. Insert Data into Orders Table --
--==========================--
/*
Insert sample data into the 'Orders' table,
which contains information about orders such as OrderID, ProductID, OrderDate, Quantity, and TotalAmount.
*/
INSERT INTO Orders (OrderID, ProductID, OrderDate, Quantity, TotalAmount) VALUES
(1, 1, '2025-04-22', 2, 51980.00),      -- Order 1: 2 Laptops
(2, 2, '2025-04-22', 3, 2970.00),       -- Order 2: 3 Keyboards
(3, 3, '2025-04-22', 1, 450.00),        -- Order 3: 1 Mouse
(4, 4, '2025-04-22', 1, 4990.00),       -- Order 4: 1 Monitor
(5, 5, '2025-04-22', 5, 1750.00);       -- Order 5: 5 USB Hubs
GO

--==========================--
-- 16. Select Data from Orders and Products --
--==========================--
/*
Select detailed order information by joining the 'Orders' table with the 'Products' table.
This will retrieve the product name, order quantity, total amount, and order date.
*/
SELECT Orders.OrderID, Products.ProductName, Orders.Quantity, Orders.TotalAmount, Orders.OrderDate
FROM Orders
INNER JOIN Products
    ON Orders.ProductID = Products.ProductID
ORDER BY Orders.OrderDate;
GO

--==========================--
-- 17. LEFT JOIN Orders with Products --
--==========================--
/*
Retrieve all orders and include product details if available.
If a product is missing (e.g., deleted or unmatched), its details will be shown as NULL.
LEFT JOIN returns all rows from the left table (Orders) even if there is no match in the right table (Products).
*/
SELECT Orders.OrderID, Products.ProductName, Orders.Quantity, Orders.TotalAmount, Orders.OrderDate
FROM Orders
LEFT JOIN Products
    ON Orders.ProductID = Products.ProductID
ORDER BY Orders.OrderDate;
GO

--==========================--
-- 18. RIGHT JOIN Orders with Products --
--==========================--
/*
Retrieve all products and include order details if available.
If a product has never been ordered, the order-related fields will be shown as NULL.
RIGHT JOIN returns all rows from the right table (Products) even if there is no match in the left table (Orders).
*/
SELECT Orders.OrderID, Products.ProductName, Orders.Quantity, Orders.TotalAmount, Orders.OrderDate
FROM Orders
RIGHT JOIN Products
    ON Orders.ProductID = Products.ProductID
ORDER BY Products.ProductID;
GO

--==========================--
-- 19. FULL JOIN Orders with Products --
--==========================--
/*
Retrieve all orders and all products, showing matches when possible.
If a product or order has no corresponding match, missing data will be shown as NULL.
FULL JOIN combines the results of both LEFT JOIN and RIGHT JOIN.
*/
SELECT Orders.OrderID, Products.ProductName, Orders.Quantity, Orders.TotalAmount, Orders.OrderDate
FROM Orders
FULL JOIN Products
    ON Orders.ProductID = Products.ProductID
ORDER BY COALESCE(Orders.OrderID, Products.ProductID);
GO

--=============================--
-- 20. Create a View for Order Details --
--=============================--
/*
Create a view named 'View_OrderDetails' that combines order information with product names and prices.
This makes it easy to reuse the same SELECT query without rewriting JOINs.
*/
CREATE VIEW View_OrderDetails AS
SELECT 
    Orders.OrderID,
    Products.ProductName,
    Orders.Quantity,
    Products.Price,
    Orders.TotalAmount,
    Orders.OrderDate
FROM Orders
INNER JOIN Products
    ON Orders.ProductID = Products.ProductID;
GO

--=============================--
-- 21. Select from View_OrderDetails --
--=============================--
/*
Query the 'View_OrderDetails' view just like a regular table.
This shows the result of the JOIN without writing the JOIN every time.
*/
SELECT * FROM View_OrderDetails
ORDER BY OrderDate DESC;
GO

--=============================--
-- 22. Create Procedure to View Orders --
--=============================--
/*
Create a stored procedure named 'sp_ShowAllOrders' that selects all orders
along with product details from the View_OrderDetails view.
*/
CREATE PROCEDURE sp_ShowAllOrders
AS
BEGIN
    SELECT * FROM View_OrderDetails
    ORDER BY OrderDate DESC;
END;
GO


--=============================--
-- 23. Procedure with ProductID Filter --
--=============================--
/*
Create a stored procedure to show orders by specific ProductID.
*/
CREATE PROCEDURE sp_ShowOrdersByProductID
    @ProductID INT
AS
BEGIN
    SELECT * 
    FROM View_OrderDetails
    WHERE ProductID = @ProductID
    ORDER BY OrderDate DESC;
END;
GO

-- Execute example:
EXEC sp_ShowOrdersByProductID @ProductID = 2;
GO
