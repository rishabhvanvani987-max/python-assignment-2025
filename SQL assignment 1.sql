/* Question 1 : Explain the fundamental differences between DDL, DML, and DQL 

commands in SQL. Provide one example for each type of command. 

Answer - 
DDL commands are used to define, modify, or delete the structure of database objects, such as tables, schemas, and indexes.

CREATE TABLE Student (
StudentID INT PRIMARY KEY,
Name VARCHAR(50),
Age INT);

DML commands are used to insert, update, or delete data stored inside database tables.

CREATE TABLE Student (
INSERT INTO Student (StudentID, Name, Age)
VALUES (1, 'Alice', 20);

DQL commands are used to retrieve data from the database.

SELECT Name, Age
FROM Student
WHERE Age > 18;

Question 2 : What is the purpose of SQL constraints? Name and describe three common types 
of constraints, providing a simple scenario where each would be useful. 

Answer -
1. PRIMARY KEY
Purpose: Uniquely identifies each record in a table
Scenario: Student ID in a student table must be unique

2. NOT NULL
Purpose: Ensures a column cannot have empty values
Scenario: Email must always be provided for a user

3. FOREIGN KEY
Purpose: Maintains relationship between tables
Scenario: Orders must belong to a valid customer

Question 3 :  Explain the difference between LIMIT and OFFSET clauses in SQL. How 
would you use them together to retrieve the third page of results, assuming each page 
has 10 records? 

Answer - 

LIMIT: A clause used to restrict the maximum number of rows returned by a query.
OFFSET: A clause used to skip a specified number of rows before starting to return results.

SELECT *
FROM table_name
LIMIT 10 OFFSET 20;

Question 4 : What is a Common Table Expression (CTE) in SQL, and what are its main 
benefits? Provide a simple SQL example demonstrating its usage. 

Answer -
A Common Table Expression (CTE) is a temporary named result set defined using the WITH 
clause that can be referenced within a SQL query.

Main Benefits of a CTE
- Improves query readability
- Makes complex queries easier to understand and maintain
- Allows reuse of query logic
- Useful for breaking down complex queries

WITH HighSalaryEmployees AS (
    SELECT employee_id, name, salary
    FROM employees
    WHERE salary > 50000
)
SELECT name, salary
FROM HighSalaryEmployees;

Question 5 : Describe the concept of SQL Normalization and its primary goals. Briefly 
explain the first three normal forms (1NF, 2NF, 3NF). 

Answer -- 
Normalization is the process of organizing data in a database to reduce redundancy and improve data integrity.

Primary Goals:
- Eliminate duplicate data
- Ensure data consistency
- Make the database easier to maintain

First Normal Form (1NF)
- Each column contains atomic (indivisible) values
- No repeating groups or multivalued attributes
Example:
Instead of storing multiple phone numbers in one column, store one phone number per row.

2. Second Normal Form (2NF)
- Table is in 1NF
- All non-key columns depend on the entire primary key
Example:
Order details table separates product information into a product table.

3️ Third Normal Form (3NF)
- Table is in 2NF
- No transitive dependency (non-key attributes depend only on the primary key)
Example:
Store customer city in a separate table instead of repeating it in customer records. */

/*Question 6 :  Create a database named ECommerceDB and perform the following 
tasks: 

1. Create the following tables with appropriate data types and constraints: 

● Categories 
○ CategoryID (INT, PRIMARY KEY) 
○ CategoryName (VARCHAR(50), NOT NULL, UNIQUE) 

● Products 
○ ProductID (INT, PRIMARY KEY) 
○ ProductName (VARCHAR(100), NOT NULL, UNIQUE) 
○ CategoryID (INT, FOREIGN KEY → Categories) 
○ Price (DECIMAL(10,2), NOT NULL) 
○ StockQuantity (INT) 

● Customers 
○ CustomerID (INT, PRIMARY KEY) 
○ CustomerName (VARCHAR(100), NOT NULL) 
○ Email (VARCHAR(100), UNIQUE) 
○ JoinDate (DATE) 

● Orders 
○ OrderID (INT, PRIMARY KEY) 
○ CustomerID (INT, FOREIGN KEY → Customers) 
○ OrderDate (DATE, NOT NULL) 
○ TotalAmount (DECIMAL(10,2)) 

2. Insert the following records into each table  */

create database ECommerceDB;

use ECommerceDB;

create table Categories
(CategoryID int primary key, CategoryName Varchar(50) Not null unique);

create table Products
(ProductID int primary key, ProductName varchar(100) not null unique,
CategoryID int references Categories(CategoryID),
Price Decimal(10,2) not null,
StockQuantity int);

create table Customers
(CustomerID int primary key,
CustomerName varchar(100) not null,
Email varchar(100) unique,
JoinDate date);

create table Orders
(OrderID int primary key,
CustomerID int references customers(CustomerID),
OrderDate date not null,
TotalAmount decimal(10,2));

use ecommercedb;
insert into Categories (CategoryID, CategoryName) values
(1, "Electronics"),
(2, "Books"),
(3, "Home Goods"),
(4, "Apparel");

insert into Products (ProductID, ProductName, CategoryID, Price, StockQuantity) values
(101, "Laptop Pro", 1, 1200.00, 50),
(102, "SQL Handbook", 2, 45.50, 200),
(103, "Smart Speaker", 1, 99.99, 150),
(104, "Coffee Maker", 3, 75.00, 80),
(105, "Novel: The Great SQL", 2, 25.00, 120),
(106, "Wireless Earbuds", 1, 150.00, 100),
(107, "Blender X", 3, 120.00, 60),
(108, "T-Shirt Casual", 4, 20.00, 300);

insert into customers (CustomerID, CustomerName, Email, JoinDate) values
(1, "Alice Wonderland", "alice@example.com", '2023-01-10'),
(2, "Bob the Builder", "bob@example.com", '2022-11-25'),
(3, "Charlie Chaplin", "charlie@example.com", '2023-03-01'),
(4, "Diana Prince", "diana@example.com", '2021-04-26');

insert into orders (OrderID, CustomerID, OrderDate, TotalAmount) values
(1001, 1, '2023-04-26', 1245.50),
(1002, 2, '2023-10-12', 99.99),
(1003, 1, '2023-07-01', 145.00),
(1004, 3, '2023-02-14', 150.00),
(1005, 2, '2023-09-24', 120.00),
(1006, 1, '2023-06-19', 20.00);


/*Question 7 : Generate a report showing CustomerName, Email, and the 
TotalNumberofOrders for each customer. Include customers who have not placed 
any orders, in which case their TotalNumberofOrders should be 0. Order the results 
by CustomerName. */

select CustomerName, 
Email, 
count(OrderID) as TotalNumberofOrders
from customers c left join orders o
on c.customerid = o.customerid
group by c.customerid;


/* Question 8 : Retrieve Product Information with Category: Write a SQL query to 
display the ProductName, Price, StockQuantity, and CategoryName for all 
products. Order the results by CategoryName and then ProductName alphabetically. */

select ProductName, Price, StockQuantity, CategoryName
from Products p inner join Categories c
on p.CategoryID = c.CategoryID
order by CategoryName, ProductName;


/*Question 9 : Write a SQL query that uses a Common Table Expression (CTE) and a 
Window Function (specifically ROW_NUMBER() or RANK()) to display the 
CategoryName, ProductName, and Price for the top 2 most expensive products in 
each CategoryName. */

With RankedProduct as 
(SELECT
c.CategoryName,
p.ProductName,
p.Price,
ROW_NUMBER() OVER (
PARTITION BY c.CategoryName ORDER BY p.Price DESC) AS rn
FROM products p
JOIN categories c
ON p.CategoryID = c.CategoryID)
select CategoryName, ProductName, Price
from RankedProduct 
where rn <=2;


/* Question 10 : You are hired as a data analyst by Sakila Video Rentals, a global movie 
rental company. The management team is looking to improve decision-making by 
analyzing existing customer, rental, and inventory data. 
Using the Sakila database, answer the following business questions to support key strategic 
initiatives. 

Tasks & Questions: 

10.1. Identify the top 5 customers based on the total amount they’ve spent. Include customer 
name, email, and total amount spent. */

use sakila;

With Total_payment as 
(select customer_id, sum(amount) as Total_amount from payment
group by customer_id)
select concat(first_name, " ", last_name) as name, email, Total_amount
from customer c left join Total_payment t
on c.customer_id = t.customer_id
order by total_amount desc
limit 5;

/* 10.2. Which 3 movie categories have the highest rental counts? Display the category name 
and number of times movies from that category were rented. */

select * from inventory;

SELECT 
    c.name AS CategoryName,
    COUNT(r.rental_id) AS RentalCount
FROM category c
JOIN film_category fc
    ON c.category_id = fc.category_id
JOIN inventory i
    ON fc.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
GROUP BY c.category_id, c.name
ORDER BY RentalCount DESC
LIMIT 3;

/* 10.3. Calculate how many films are available at each store and how many of those have 
never been rented. */

SELECT 
s.store_id,
COUNT(i.inventory_id) AS TotalFilms,
SUM(CASE WHEN r.rental_id IS NULL THEN 1 ELSE 0 END) AS NeverRented
FROM store s
JOIN inventory i
ON s.store_id = i.store_id
LEFT JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY s.store_id;


/* 10.4. Show the total revenue per month for the year 2023 to analyze business seasonality. */

SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS Month,
    SUM(amount) AS TotalRevenue
FROM payment
WHERE YEAR(payment_date) = 2023
GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY Month;


/* 10.5. Identify customers who have rented more than 10 times in the last 6 months. */

SELECT 
c.customer_id,
c.first_name,
c.last_name,
COUNT(r.rental_id) AS TotalRentals
FROM customer c
JOIN rental r
ON c.customer_id = r.customer_id
WHERE r.rental_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(r.rental_id) > 10
ORDER BY TotalRentals DESC;

