# SQL-Project-On-Book-Order
This SQL project analyzes book inventory and order data using joins and aggregation. It calculates total ordered quantity and remaining stock for each book, handling NULL values with COALESCE. The project demonstrates practical use of LEFT JOIN, GROUP BY, and data analysis for business insights.

📚 SQL Project – Book Order Analysis
📌 Overview

This project focuses on analyzing book inventory and customer order data using SQL. It simulates a real-world bookstore scenario where inventory management and order tracking are essential for business efficiency. The goal is to extract meaningful insights such as total books ordered, available stock, and overall sales performance.

🎯 Objectives
Analyze book order and inventory data
Calculate total ordered quantity for each book
Determine remaining stock after fulfilling orders
Handle missing (NULL) values effectively
Generate structured reports for business insights
🗂️ Dataset Description

The project includes two main datasets:

Books Table → Contains book details like Book_ID, Title, Author, Price, and Stock
Orders Table → Contains order details like Order_ID, Book_ID, Quantity Ordered
⚙️ Key SQL Concepts Used
LEFT JOIN → Combine books and orders data to ensure all books are included, even if not ordered
GROUP BY → Aggregate data by book
SUM() → Calculate total ordered quantity
COALESCE() → Replace NULL values with 0 for accurate calculations
Aliases → Improve readability of query outputs
📊 Core Analysis Performed
Total quantity ordered per book

Remaining stock calculation:

Remaining Stock = Total Stock - Total Ordered Quantity
Identification of books with no orders
Clean and structured output for reporting
💡 Key Insights
Helps identify high-demand books
Detects low or zero stock items
Highlights books that are not selling
Supports inventory and sales decision-making
▶️ How to Use
Open your SQL environment (MySQL / PostgreSQL / SQL Server)
Run the SQL script file
Execute queries to view results
Modify queries to explore additional insights
🛠️ Tools & Technologies
SQL (MySQL / PostgreSQL)
Relational Database Concepts
🚀 Use Cases
Bookstore inventory management
Sales performance analysis
Business intelligence reporting
Academic SQL practice project







