# create database
CREATE DATABASE BookwormsHaven;
USE BookwormsHaven;

# create inventory table
CREATE TABLE Books_Inventory (
Book_ID int not null PRIMARY KEY, 
Title varchar(250) not null,
Author varchar(100) not null,
Genre varchar (100),
Publication_yr Year not null,
Price float not null);

# populate inventory table
INSERT INTO Books_Inventory VALUES
(1,"Harry Potter and the philosopher's stone", "J.K.Rowling", "Adventure", 1997, 7.14), 
(2, "The Hobbit an unexpected Journey", "J.R.R. Tolkein", "Adventure", 1937, 3.49),
(3, "Spare", "Prince Harry", "Autobiography", 2023, 14),
(4, "Pinch of nom", "K.Allinson", "Cookbook", 2022, 10),
(5, "Atomic Habits", "J.Clear", "Nonfiction", 2018,  9),
(6, "The boy, the mole, the fox and the horse", "C.Macksey", "Comic", 2019, 9),
(7, "The keeper of stories", "S.Page", "Romance", 2022, 8.27),
(8, "Ugly love", "C.Hoover", "Romance", 2014, 5),
(9, "The very hungry caterpillar", "E.Carle", "Comic", 1969, 4),
(10, "The dinosaur pooped easter", "D.Poynter", "Comic", 2023, 4.50);

# create customer table
CREATE TABLE customers (
Customer_ID int not null PRIMARY KEY,
Full_name varchar(100) not null,
Email varchar(100) not null,
Phone_no varchar(20),
Chapterchaser boolean,
CC_points int);

# populate customer table
INSERT INTO customers 
VALUES
(1, "John Doe", "j.doe@madeup.com", "012133335787", 1, 200),
(2, "Jane Doe", "ja.doe@madeup.com", "04869372615", 1, 100),
(3, "Barack Obama", "b.obama@mademadeup.com", "75272615389", 0, 0),
(4, "Mohammed Ali", "mohammedali@madeup.com", "07917365817", 1, 150),
(5, "Dwayne Johnson", "johnsontherock@madeup.co", "04759273519", 1, 100),
(6,  "Blake Lively", "lively.b@mademadeup.com", "72548592955", 1, 300),
(7, "Jennifer Aniston", "friends.j.a@madeup.com", "124859702715", 0, 0),
(8, "Ryan Reynolds", "wrexhamfc.r.r@madeup.com", "1726590542", 1, 400),
(9, "Aubrey Graham", "drake@mademadeup.com", "43677654321", 1, 450),
(10, "Selena Gomez", "rarebeauty@madeup.com", "6862783726", 1, 100);

# create the ChapterChaser Table
CREATE TABLE ChapterChaser (
ChapterChaser_ID INT NOT NULL,
Chapterchaser boolean,
CC_points INT
);

# Populate chapter chaser table
INSERT INTO ChapterChaser VALUES
(1, 1, 200),
(2, 1, 100),
(3, 0, 0),
(4, 1, 150),
(5, 1, 100),
(6, 1, 300),
(7, 0, 0),
(8, 1, 400),
(9, 1, 450),
(10, 1, 100);

# Create customer orders table
CREATE TABLE customers_orders (
Order_ID INT not null PRIMARY KEY,
Order_date DATE not null,
Customer_ID INT not null,
Items_Orders_ID INT not null,
Amount_paid FLOAT not null
);

# Populate customer orders table
INSERT INTO customers_orders VALUES
(1001, '2022-05-27', 1, 1, 24),
(1002, '2022-06-02', 2, 2, 10),
(1003, '2022-06-15', 3, 3, 9),
(1004, '2022-06-17', 4, 4, 17.27),
(1005, '2022-07-10', 5, 5, 14),
(1006, '2022-08-03', 5, 6, 8.27),
(1007, '2022-09-19', 6, 7, 3.49),
(1008, '2022-10-28', 3, 8, 4.5),
(1009, '2022-11-02', 7, 9, 4),
(1010, '2023-01-15', 8, 10, 7.14),
(1011, '2023-01-17', 9, 11, 9),
(1012, '2023-02-01', 10, 12, 5);

# Create item ordered table - this table reduces duplicate lines in customer orders
CREATE TABLE items (
ItemsOrders_ID INT,
Order_ID INT not null,
Book_ID INT not null,
Qty_Ordered INT,
Price FLOAT,
Customer_ID INT
);

# Populate items ordered table
INSERT INTO items VALUES
(1, 1001, 3, 1, 14, 1),
(1, 1001, 4, 1, 10, 1),
(2, 1002, 4, 1, 10, 2),
(3, 1003, 6, 1, 9, 3),
(4, 1004, 5, 1, 9, 4),
(4, 1004, 7, 1, 8.27, 4),
(5, 1005, 3, 1, 14, 5),
(6, 1006, 7, 1, 8.27, 5),
(7, 1007, 2, 1, 3.49, 6),
(8, 1008, 10, 1, 4.5, 3), 
(9, 1009, 9, 1, 4, 7),
(10, 1010, 1, 1, 7.14, 8),
(11, 1011, 6, 1, 9, 9),
(12, 1012, 8, 1, 5, 10);


# Create a inner join to link customers and customer orders
# This provides detail on customer order frequency and spend
SELECT
a.Customer_ID,
a.Full_name,
b.Order_ID,
b.Order_date,
b.Amount_paid
FROM customers AS a
INNER JOIN customers_orders as b
ON  a.Customer_ID = b.Customer_ID;

# Aggregation to show the count of a genre of the books
SELECT
	COUNT(*) AS CountGenre
FROM
	Books_Inventory
WHERE Genre = 'Comic' AND Publication_yr > 2015;

# Sum Aggregation for the total amount paid 
SELECT
SUM(Amount_paid)  AS SumAmount_paid
FROM
	customers_orders;

# Aggregation for average price
SELECT
	AVG(Price) AS AvgPrice
FROM 
	Books_Inventory;

# Aggregation for minimum publication year
SELECT
  MIN(Publication_yr) AS
MinAge
FROM Books_Inventory;

# Aggregation for maximum chapter chaser points
SELECT
 MAX(CC_points) AS Maxpoints
FROM ChapterChaser;


# used to insert chapter chaser id into customers table
INSERT INTO customers (ChapterChaser_ID) VALUES 
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);

/*
SELECT * FROM Books_Inventory;
SELECT * FROM customers;
SELECT * FROM ChapterChaser;
SELECT * FROM customers_orders;
SELECT * FROM items;

# attempt at updating integer to floats in customer_orders table
ALTER TABLE customers_orders MODIFY COLUMN Amount_paid float NOT NULL;

# used to update integer to floats in customer_orders table
UPDATE customers_orders
SET Amount_paid = 7.14
WHERE order_id = 1010;

# used this to remove security feature so items table could be deleted 
SET SQL_SAFE_UPDATES = 0;

# The following queries show data and tables that were deleted or updated during database design process
DELETE FROM items;

ALTER TABLE items
ADD Qty_Books_Ordered INT;

DROP TABLE customers_orders;

ALTER TABLE items
DROP COLUMN Qty_Books_Ordered;

ALTER TABLE items
ADD COLUMN Customer_ID INT;

# Foreign keys changed to find the best FK suited to the data

ALTER TABLE items
ADD FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID);

ALTER TABLE items
ADD FOREIGN KEY (Book_ID) REFERENCES Books_Inventory(Book_ID);

ALTER TABLE items
ADD FOREIGN KEY (Order_ID) REFERENCES customers_orders(Order_ID);

ALTER TABLE customers_orders
ADD FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID);

ALTER TABLE customers_orders
RENAME COLUMN Items_Orders TO Items_Orders_ID;

ALTER TABLE ChapterChaser 
RENAME COLUMN Chapterchaser TO CC_Member_Status;

ALTER TABLE customers 
RENAME COLUMN Chapterchaser TO CC_Member_Status;

ALTER TABLE items
ADD PRIMARY KEY (ItemsOrders_ID);

#Change to foreign key.
ALTER TABLE customers
ADD FOREIGN KEY (ChapterChaser_ID) REFERENCES ChapterChaser(ChapterChaser_ID);

ALTER TABLE customers_orders
ADD FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID);

ALTER TABLE customers_orders
ADD FOREIGN KEY (Book_ID) REFERENCES Books_Inventory(Book_ID);
*/
