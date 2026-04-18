-- ============================================
-- Create Database
-- ============================================
CREATE DATABASE OnlineBookstore;

-- Connect to database (PostgreSQL)
\c OnlineBookstore;

-- ============================================
-- Drop Tables (Correct Order)
-- ============================================
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Books;

-- ============================================
-- Create Tables
-- ============================================

CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(100)
);

CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

-- ============================================
-- Import Data (Fixed Paths)
-- ============================================

COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock) 
FROM 'D:/Skill Development/SQL By Satish Dhawale (Postgre)/Books.csv' 
CSV HEADER;

COPY Customers(Customer_ID, Name, Email, Phone, City, Country) 
FROM 'D:/Skill Development/SQL By Satish Dhawale (Postgre)/Customer.csv' 
CSV HEADER;

COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount) 
FROM 'D:/Certificate/Orders.csv' 
CSV HEADER;

-- ============================================
-- Basic Queries
-- ============================================

SELECT * FROM Books WHERE Genre = 'Fiction';

SELECT * FROM Books WHERE Published_Year > 1950;

SELECT * FROM Customers WHERE Country = 'Canada';

SELECT * FROM Orders
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

SELECT SUM(Stock) AS Total_Stock FROM Books;

SELECT * FROM Books ORDER BY Price DESC LIMIT 1;

SELECT * FROM Orders WHERE Quantity > 1;

SELECT * FROM Orders WHERE Total_Amount > 20;

SELECT DISTINCT Genre FROM Books;

SELECT * FROM Books ORDER BY Stock LIMIT 1;

SELECT SUM(Total_Amount) AS Revenue FROM Orders;

-- ============================================
-- Advanced Queries
-- ============================================

-- Books sold per genre
SELECT b.Genre, SUM(o.Quantity) AS Total_Book_Sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Genre;

-- Avg price of Fantasy books
SELECT AVG(Price) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy';

-- Customers with >=2 orders
SELECT o.Customer_ID, c.Name, COUNT(o.Order_ID) AS Order_Count
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY o.Customer_ID, c.Name
HAVING COUNT(o.Order_ID) >= 2;

-- Most frequently ordered book
SELECT o.Book_ID, b.Title, COUNT(*) AS Order_Count
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY o.Book_ID, b.Title
ORDER BY Order_Count DESC
LIMIT 1;

-- Top 3 expensive Fantasy books
SELECT *
FROM Books
WHERE Genre = 'Fantasy'
ORDER BY Price DESC
LIMIT 3;

-- Books sold by author
SELECT b.Author, SUM(o.Quantity) AS Total_Sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Author;

-- Cities with high spending customers
SELECT DISTINCT c.City
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
WHERE o.Total_Amount > 30;

-- Top spending customer
SELECT c.Customer_ID, c.Name, SUM(o.Total_Amount) AS Total_Spent
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Total_Spent DESC
LIMIT 1;

-- ============================================
-- FINAL FIXED QUERY (IMPORTANT)
-- ============================================

SELECT 
    b.Book_ID, 
    b.Title, 
    b.Stock, 
    COALESCE(SUM(o.Quantity), 0) AS Ordered_Quantity,
    b.Stock - COALESCE(SUM(o.Quantity), 0) AS Remaining_Quantity
FROM Books b
LEFT JOIN Orders o 
    ON b.Book_ID = o.Book_ID
GROUP BY 
    b.Book_ID, b.Title, b.Stock
ORDER BY 
    b.Book_ID;