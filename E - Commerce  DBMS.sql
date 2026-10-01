create database ecommercedbms;

use ecommercedbms;

CREATE TABLE customer_details (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Gender VARCHAR(10),
    City VARCHAR(50),
    SignupDate DATE
);
select *from customer_details;

CREATE TABLE customer_addresses (
    AddressID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    AddressType VARCHAR(20),
    AddressLine VARCHAR(200),
    City VARCHAR(50),
    State VARCHAR(50),
    Pincode VARCHAR(10),
    FOREIGN KEY (CustomerID) REFERENCES customer_details(CustomerID)
);
select *from customer_addresses;

CREATE TABLE categories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(100) NOT NULL
);
select *from categories;

CREATE TABLE sellers (
    SellerID INT PRIMARY KEY AUTO_INCREMENT,
    SellerName VARCHAR(100) NOT NULL,
    City VARCHAR(50),
    Rating INT,
    JoinedDate DATE
);
select *from sellers;

CREATE TABLE products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(150) NOT NULL,
    CategoryID INT,
    SellerID INT,
    Price INT,
    Quantity INT,
    Brand VARCHAR(50),
    FOREIGN KEY (CategoryID) REFERENCES categories(CategoryID),
    FOREIGN KEY (SellerID) REFERENCES sellers(SellerID)
);
select *from products;

CREATE TABLE orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE,
    Status VARCHAR(20) DEFAULT 'Pending',
    AddressID INT,
    FOREIGN KEY (CustomerID) REFERENCES customer_details(CustomerID),
    FOREIGN KEY (AddressID) REFERENCES customer_addresses(AddressID)
);
select *from orders;

CREATE TABLE order_items (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price INT,
    FOREIGN KEY (OrderID) REFERENCES orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES products(ProductID)
);
select *from order_items;


CREATE TABLE cart (
    CartID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    AddedDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES customer_details(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES products(ProductID)
);
select *from cart;

CREATE TABLE payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    AmountPaid INT,
    PaymentMode VARCHAR(30),
    PaymentStatus VARCHAR(20),
    PaymentDate DATE,
    FOREIGN KEY (OrderID) REFERENCES orders(OrderID)
);
select *from payments;

CREATE TABLE delivery_agents (
    AgentID INT PRIMARY KEY AUTO_INCREMENT,
    AgentName VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Rating INT
);
select *from delivery_agents;

CREATE TABLE shipping (
    ShippingID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    AgentID INT,
    Courier VARCHAR(50),
    TrackingID VARCHAR(50),
    ShippedDate DATE,
    DeliveredDate DATE,
    ShippingStatus VARCHAR(20),
    FOREIGN KEY (OrderID) REFERENCES orders(OrderID),
    FOREIGN KEY (AgentID) REFERENCES delivery_agents(AgentID)
);
select *from shipping;


CREATE TABLE reviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    CustomerID INT,
    Rating INT,
    Comment TEXT,
    ReviewDate DATE,
    FOREIGN KEY (ProductID) REFERENCES products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES customer_details(CustomerID)
);
select *from reviews;

CREATE TABLE coupons (
    CouponID INT PRIMARY KEY AUTO_INCREMENT,
    CouponCode VARCHAR(30) UNIQUE,
    DiscountPercent INT,
    ExpiryDate DATE,
    MinOrderValue INT
);
select *from coupons;

CREATE TABLE returnss (
    ReturnID INT PRIMARY KEY AUTO_INCREMENT,
    OrderItemID INT,
    Reason TEXT,
    ReturnStatus VARCHAR(20),
    RefundAmount INT,
    FOREIGN KEY (OrderItemID) REFERENCES order_items(OrderItemID)
);
select *from returnss;

CREATE TABLE wallet (
    WalletID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT UNIQUE,
    Balance INT DEFAULT 0,
    LastUpdated DATE,
    FOREIGN KEY (CustomerID) REFERENCES customer_details(CustomerID)
);
select *from wallet;

-- Basic Level (20 Questions)

-- 1. List all customer names and their cities from `customer_details`.
select CustomerName, City from  customer_details;

-- 2. Find all customers who are from `Chennai`.
select customername from customer_details where city='chennai';

-- 3. Display all products with a price greater than 5000.
select *from products where price >5000;

-- 4. Show all orders with a `Status` of `Delivered`.
select *from orders where status = 'delivered';

-- 5. List all distinct cities present in the `sellers` table.
select distinct city from sellers;

-- 6. Find all products belonging to the brand `Samsung`.
select *from products where brand= 'samsung';

-- 7. Display customer names and emails, sorted alphabetically by name.
select customername, email from customer_details order by 1 asc;

-- 8. Show the top 10 most expensive products (`ProductName`, `Price`).
select productname, price from products order by price desc limit 10;

-- 9. Count the total number of customers in `customer_details`.
select count(customerid) from customer_details;

-- 10. Find all coupons with a `DiscountPercent` greater than 30.
select *from coupons where discountpercent >30;

-- 11. List all orders placed in the year 2025.
select *from orders where year(orderdate) =2025;

-- 12. Show all reviews with a `Rating` of 5.
select *from reviews where rating =5;

-- 13. Find all delivery agents from `Mumbai` with a rating of 4 or above.
select *from delivery_agents where city ='mumbai' and rating >=4;

-- 14. Display all sellers who joined after `2022-01-01`.
select *from sellers where joineddate > '2022-01-01';

-- 15. List all products with `Quantity` less than 10 (low stock).
select *from products where quantity <10;

-- 16. Show all payments made using `UPI`.
select *from payments where paymentmode = 'upi';

-- 17. Find all customers whose name starts with the letter `S`.
select customername from customer_details where customername like "s%";

-- 18. Display the total number of products in the `products` table.
select count(*) totalproduct from products;

-- 19. List all order items  `Quantity` is greater than 3.
select *from order_items where quantity >3;

-- 20. Show all customer addresses with `AddressType` as `Home`.
select * from customer_addresses where addresstype ='home';

-- Intermediate Level (12 Questions)

-- 1. Find the total number of orders placed by each customer (`CustomerID`, order count).
select CustomerID, count(*) as order_count from orders group by CustomerID;

-- 2. Display each seller's name along with the number of products they sell.
select s.sellername, count(p.productid) as Product_count from Sellers as s
left join Products as p on s.sellerid = p.sellerid
group by s.sellerid, s.sellername;

-- 3. Calculate the average rating for each product from the `reviews` table.
select productid, avg(rating) from reviews group by productid;

-- 4. Find the total revenue generated (`SUM(Price * Quantity)`) from `order_items`.
select sum(price * quantity) from order_items;

-- 5. List the top 5 customers who have spent the most, using `payments`.
select c.customerid, c.customername, sum(p.amount) as totalspent from payments as p
join orders as o on p.orderid = o.orderid
join customers as c on o.customerid = c.customerid
group by c.customerid, c.customername order by totalspent desc limit 5;

-- 6. Show category-wise product count and average price, from `products` joined with `categories`.
select c.categoryname, count(p.productid) as productcount, avg(p.price) as averageprice from products as p
join categories as c on p.categoryid = c.categoryid
group by c.categoryid, c.categoryname;

-- 7. Find customers who have never placed an order (use `LEFT JOIN` / `NOT IN`).
select customerid, customername from customer_details
where customerid not in (select customerid from orders);

-- 8. Display order details along with customer name and shipping status (join `orders`, `customer_details`, `shipping`).
select o.*, c.customername, s.shippingstatus from orders as o
join customer_details as c on o.customerid = c.customerid
join shipping as s on o.orderid = s.orderid;

-- 9. Find the number of orders handled by each delivery agent.
select d.agentname, count(s.orderid) as ordercount from delivery_agents as d
join shipping as s on d.agentid = s.agentid
group by d.agentid, d.agentname;

-- 10. List products that have never received a review.
select p.productid, p.productname from products as p
left join reviews as r on p.productid = r.productid
where r.productid is null;

-- 11. Show the month-wise order count for the year 2025.
select monthname(orderdate) as month, count(*) as ordercount from orders
where year(orderdate) = 2025
group by month(orderdate), monthname(orderdate)
order by month(orderdate);

-- 12. Find the most used payment mode and its total transaction count.
select paymentmode, count(*) as transaction_count from payments
group by paymentmode
order by transaction_count desc
limit 1;

-- Advanced Level (10 Questions)

-- 1. Using a window function, rank customers by their total spending (highest to lowest).
SELECT
    c.CustomerID,
    c.CustomerName,
    SUM(p.AmountPaid) AS TotalSpend,
    RANK() OVER (ORDER BY SUM(p.AmountPaid) DESC) AS SpendRank
FROM payments p
JOIN orders o ON p.OrderID = o.OrderID
JOIN customer_details c ON o.CustomerID = c.CustomerID
WHERE p.PaymentStatus = 'Success'
GROUP BY c.CustomerID, c.CustomerName
ORDER BY SpendRank;

-- 2. Find the running total of daily revenue using a window function (`SUM() OVER`).
SELECT
    o.OrderDate,
    SUM(oi.Quantity * oi.Price) AS DailyRevenue,
    SUM(SUM(oi.Quantity * oi.Price)) OVER (ORDER BY o.OrderDate) AS RunningTotal
FROM orders o
JOIN order_items oi ON o.OrderID = oi.OrderID
GROUP BY o.OrderDate
ORDER BY o.OrderDate;

-- 3. Write a query using a CTE to find the top 3 best-selling products by quantity sold.
WITH ProductSales AS (
    SELECT
        ProductID,
        SUM(Quantity) AS TotalSold
    FROM order_items
    GROUP BY ProductID
)
SELECT
    p.ProductName,
    p.Brand,
    ps.TotalSold
FROM ProductSales ps
JOIN products p ON ps.ProductID = p.ProductID
ORDER BY ps.TotalSold DESC
LIMIT 3;

-- 4. Find customers who placed more than one order on the same day (self-join or `GROUP BY` with `HAVING COUNT`).
SELECT CustomerID, OrderDate, COUNT(*) AS OrdersOnDay
FROM orders
GROUP BY CustomerID, OrderDate
HAVING COUNT(*) > 1;

-- 5. Using a correlated subquery, find products priced above the average price of their own category.
SELECT p.ProductName, p.CategoryID, p.Price
FROM products p
WHERE p.Price > (
    SELECT AVG(p2.Price) FROM products p2 WHERE p2.CategoryID = p.CategoryID
);

-- 6. Find the second highest priced product in each category (without using `LIMIT`, use `DENSE_RANK()`).
SELECT * FROM (
    SELECT ProductName, CategoryID, Price,
           DENSE_RANK() OVER (PARTITION BY CategoryID ORDER BY Price DESC) AS rnk
    FROM products
) t WHERE rnk = 2;

-- 7. Calculate the month-over-month growth in total order value using window functions.
WITH Monthly AS (
    SELECT DATE_FORMAT(o.OrderDate, '%Y-%m') AS Month,
           SUM(oi.Quantity * oi.Price) AS Revenue
    FROM orders o JOIN order_items oi ON o.OrderID = oi.OrderID
    GROUP BY Month
)
SELECT Month, Revenue,
       Revenue - LAG(Revenue) OVER (ORDER BY Month) AS MoM_Growth
FROM Monthly;

-- 8. Find customers whose total order value is above the average order value of all customers (subquery in `HAVING`).
SELECT o.CustomerID, SUM(p.AmountPaid) AS TotalSpend
FROM payments p JOIN orders o ON p.OrderID = o.OrderID
GROUP BY o.CustomerID
HAVING SUM(p.AmountPaid) > (
    SELECT AVG(CustomerTotal) FROM (
        SELECT SUM(p2.AmountPaid) AS CustomerTotal
        FROM payments p2 JOIN orders o2 ON p2.OrderID = o2.OrderID
        GROUP BY o2.CustomerID
    ) x
);

-- 9. Write a query to find the delivery agent with the highest on-time delivery rate (`DeliveredDate - ShippedDate` within 3 days).
SELECT AgentID,
       SUM(CASE WHEN DATEDIFF(DeliveredDate, ShippedDate) <= 3 THEN 1 ELSE 0 END) / COUNT(*) AS OnTimeRate
FROM shipping
GROUP BY AgentID
ORDER BY OnTimeRate DESC LIMIT 1;

-- 10. Using a CTE and window function, find each seller's best-selling product (highest total quantity sold).
WITH SellerProductSales AS (
    SELECT p.SellerID, p.ProductID, p.ProductName, SUM(oi.Quantity) AS TotalQty,
           RANK() OVER (PARTITION BY p.SellerID ORDER BY SUM(oi.Quantity) DESC) AS rnk
    FROM products p JOIN order_items oi ON p.ProductID = oi.ProductID
    GROUP BY p.SellerID, p.ProductID
)
SELECT SellerID, ProductName, TotalQty FROM SellerProductSales WHERE rnk = 1;
