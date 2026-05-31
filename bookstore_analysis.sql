-- 📚 Online Bookstore SQL Analysis
-- Author: Kumkum Sharma
-- Tool: MySQL Workbench
-- Dataset: Books, Customers, Orders (500+ records)
-- ================================================

USE bookstore;

-- ================================================
-- BASIC QUERIES
-- ================================================

-- Q1: Retrieve all books in the "Fiction" genre
SELECT * FROM books
WHERE genre = 'Fiction';

-- Q2: Find books published after the year 1950
SELECT * FROM books
WHERE published_year > 1950;

-- Q3: List all customers from Canada
SELECT * FROM customers
WHERE country = 'Canada';

-- Q4: Show orders placed in November 2023
SELECT * FROM orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- Q5: Retrieve the total stock of books available
SELECT SUM(stock) AS total_stocks
FROM books;

-- Q6: Find the details of the most expensive book
SELECT * FROM books
ORDER BY price DESC
LIMIT 1;

-- Q7: Show all customers who ordered more than 1 quantity of a book
SELECT o.order_id, c.customer_name, b.title, o.quantity
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN books b ON o.book_id = b.book_id
WHERE o.quantity > 1;

-- Q8: Retrieve all orders where the total amount exceeds $20
SELECT * FROM orders
WHERE total_amount > 20;

-- Q9: List all genres available in the Books table
SELECT DISTINCT genre
FROM books;

-- Q10: Find the book with the lowest stock
SELECT * FROM books
ORDER BY stock ASC
LIMIT 1;

-- Q11: Calculate the total revenue generated from all orders
SELECT SUM(total_amount) AS total_revenue
FROM orders;

-- ================================================
-- ADVANCED QUERIES
-- ================================================

-- Adv Q1: Retrieve the total number of books sold for each genre
SELECT b.genre, SUM(o.quantity) AS total_books_sold
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.genre;

-- Adv Q2: Find the average price of books in the "Fantasy" genre
SELECT AVG(price) AS avg_price
FROM books
WHERE genre = 'Fantasy';

-- Adv Q3: List customers who have placed at least 2 orders
SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS order_count
FROM customers c JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) >= 2;

-- Adv Q4: Find the most frequently ordered book
SELECT b.book_id, b.title, COUNT(o.order_id) AS order_count
FROM books b JOIN orders o
ON b.book_id = o.book_id
GROUP BY b.book_id, b.title
ORDER BY order_count DESC
LIMIT 1;

-- Adv Q5: Show the top 3 most expensive books of 'Fantasy' genre
SELECT b.book_id, b.title, b.price FROM books b
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;

-- Adv Q6: Retrieve the total quantity of books sold by each author
SELECT b.author, SUM(o.quantity) AS total_quantity
FROM books b JOIN orders o
ON b.book_id = o.book_id
GROUP BY b.author;

-- Adv Q7: List the cities where customers who spent over $30 are located
SELECT DISTINCT c.city, SUM(total_amount) AS spendings
FROM customers c JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING spendings > 30;

-- Adv Q8: Find the customer who spent the most on orders
SELECT c.customer_id, c.customer_name, SUM(total_amount) AS spendings
FROM customers c JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY spendings DESC
LIMIT 1;

-- Adv Q9: Calculate the stock remaining after fulfilling all orders
SELECT b.book_id, b.title, b.stock,
       SUM(o.quantity) AS total_ordered,
       b.stock - SUM(o.quantity) AS remaining_stock
FROM books b JOIN orders o
ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock
ORDER BY remaining_stock ASC;
