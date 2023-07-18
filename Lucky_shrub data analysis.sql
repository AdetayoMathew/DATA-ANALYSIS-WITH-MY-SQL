CREATE DATABASE IF NOT EXISTS Lucky_Shrub;
CREATE TABLE Clients (ClientID VARCHAR(10), FullName VARCHAR(100), ContactNumber INT, AddressID INT);   
CREATE TABLE Orders (OrderID INT NOT NULL PRIMARY KEY, ClientID VARCHAR(10),  ProductID VARCHAR(10),  Quantity   INT, Cost DECIMAL(6,2), Date DATE); 
CREATE TABLE Products (ProductID VARCHAR(10), ProductName VARCHAR(100), BuyPrice DECIMAL(6,2), SellPrice DECIMAL(6,2), NumberOfItems INT); 
CREATE TABLE Addresses(AddressID INT PRIMARY KEY, Street VARCHAR(255), County VARCHAR(100)); 
INSERT INTO Clients(ClientID, FullName, ContactNumber, AddressID) VALUES 
("Cl1", "Takashi Ito", 351786345, 1), 
("Cl2", "Jane Murphy", 351567243, 2), 
("Cl3", "Laurina Delgado", 351342597, 3), 
("Cl4", "Benjamin Clauss", 351342509, 4), 
("Cl5", "Altay Ayhan", 351208983, 5), 
("Cl6", "Greta Galkina", 351298755, 6); 

INSERT INTO Orders (OrderID, ClientID, ProductID , Quantity, Cost, Date) VALUES 
(1, "Cl1", "P1", 10, 500, "2020-09-01" ), 
(2, "Cl2", "P2", 5, 100, "2020-09-05"), 
(3, "Cl3", "P3", 20, 800, "2020-09-03"), 
(4, "Cl4", "P4", 15, 150, "2020-09-07"), 
(5, "Cl3", "P3", 10, 450, "2020-09-08"), 
(6, "Cl2", "P2", 5, 800, "2020-09-09"), 
(7, "Cl1", "P4", 22, 1200, "2020-09-10"), 
(8, "Cl3", "P1", 15, 150, "2020-09-10"), 
(9, "Cl1", "P1", 10, 500, "2020-09-12"), 
(10, "Cl2", "P2", 5, 100, "2020-09-13"), 
(11, "Cl4", "P5", 5, 100, "2020-09-15"),
(12, "Cl1", "P1", 10, 500, "2022-09-01"), 
(13, "Cl2", "P2", 5, 100, "2022-09-05"), 
(14, "Cl3", "P3", 20, 800, "2022-09-03"), 
(15, "Cl4", "P4", 15, 150, "2022-09-07"), 
(16, "Cl3", "P3", 10, 450, "2022-09-08"), 
(17, "Cl2", "P2", 5, 800, "2022-09-09"), 
(18, "Cl1", "P4", 22, 1200, "2022-09-10"), 
(19, "Cl3", "P1", 15, 150, "2022-09-10"), 
(20, "Cl1", "P1", 10, 500, "2022-09-12"), 
(21, "Cl2", "P2", 5, 100, "2022-09-13"),  
(22, "Cl2", "P1", 10, 500, "2021-09-01"), 
(23, "Cl2", "P2", 5, 100, "2021-09-05"), 
(24, "Cl3", "P3", 20, 800, "2021-09-03"), 
(25, "Cl4", "P4", 15, 150, "2021-09-07"), 
(26, "Cl1", "P3", 10, 450, "2021-09-08"), 
(27, "Cl2", "P1", 20, 1000, "2022-09-01"), 
(28, "Cl2", "P2", 10, 200, "2022-09-05"), 
(29, "Cl3", "P3", 20, 800, "2021-09-03"), 
(30, "Cl1", "P1", 10, 500, "2022-09-01"); 

INSERT INTO Addresses (AddressID, Street, County) VALUES 
(1, ",291 Oak Wood Avenue", "Graham County"), 
(2, "724 Greenway Drive", "Pinal County"), 
(3, "102 Sycamore Lane", "Santa Cruz County"), 
(4, "125 Roselawn Close", "Gila County"), 
(5, "831 Beechwood Terrace", "Cochise County"),
(6, "755 Palm Tree Hills", "Mohave County"), 
(7, "751 Waterfall Hills", "Tucson County") , 
(8, "878 Riverside Lane", "Tucson County") , 
(9, "908 Seaview Hills", "Tucson County"), 
(10, "243 Waterview Terrace", "Tucson County"), 
(11, "148 Riverview Lane", "Tucson County"),  
(12, "178 Seaview Avenue", "Tucson County");

INSERT INTO Products (ProductID, ProductName, BuyPrice, SellPrice, NumberOfItems) VALUES 
("P1", "Artificial grass bags ", 40, 50, 100), 
("P2", "Wood panels", 15, 20, 250), 
("P3", "Patio slates",  35, 40, 60), 
("P4", "Sycamore trees ", 7, 10, 50), 
("P5", "Trees and Shrubs", 35, 50, 75), 
("P6", "Water fountain", 65, 80, 15); 

ALTER TABLE orders
CHANGE COLUMN  Date ordersDate date;


# A query that returns the total quantity of all products with the ID of P4 sold in the years 2020, 2021 and 2022. 
with 
 Total_Quantity AS (
  SELECT ProductID, sum(Quantity) AS TotalQuantity
  FROM orders
  WHERE ProductID = 'P4' AND YEAR(ordersDate) IN (2020, 2021, 2022)
)
SELECT *
FROM Total_Quantity;


#ucky Shrub need information on all their clients and the orders that they placed in the years 2022 and 2021. See if you can help them by extracting the required information from each of the following tables:

# Clients table: The client id and contact number for each client who placed an order

# Addresses table: The street and county for each client’s address

# Orders table: The order id, cost and date of each client’s order.

# Products table: The name of each product ordered.

select clients.ClientID,clients.ContactNumber,
addresses.County,addresses.Street,
orders.OrderID,orders.Cost,orders.ordersDate,
products.ProductName from orders
inner join clients on clients.ClientID = orders.ClientID
inner join addresses on addresses.AddressID = clients.AddressID
inner join products on products.ProductID = orders.ProductID
;

SELECT
    clients.ClientID,
    clients.ContactNumber,
    addresses.County,
    addresses.Street,
    orders.OrderID,
    orders.Cost,
    orders.ordersDate,
    products.ProductName
FROM
    orders
LEFT JOIN
    clients ON clients.ClientID = orders.ClientID
LEFT JOIN
    addresses ON addresses.AddressID = clients.AddressID
LEFT JOIN
    products ON products.ProductID = orders.ProductID
UNION
SELECT
    clients.ClientID,
    clients.ContactNumber,
    addresses.County,
    addresses.Street,
    orders.OrderID,
    orders.Cost,
    orders.ordersDate,
    products.ProductName
FROM
    orders
RIGHT JOIN
    clients ON clients.ClientID = orders.ClientID
RIGHT JOIN
    addresses ON addresses.AddressID = clients.AddressID
RIGHT JOIN
    products ON products.ProductID = orders.ProductID
    where year(ordersDate) between 2020 and 2022;
    
select * from products;

# create a function to Input a ProductID and a year from which they can capture data;

DELIMITER //

CREATE FUNCTION FindSoldQuantity(ProductID VARCHAR(10), ordersDate INT)
RETURNS INT
deterministic
BEGIN
    DECLARE total_quantity_sold INT;
    SELECT SUM(Quantity) INTO total_quantity_sold
    FROM orders
    WHERE ProductID = ProductID AND YEAR(ordersDate) = ordersDate;
    

    
    RETURN total_quantity_sold;
END //

DELIMITER ;

select FindSoldQuantity("p3",2021);


