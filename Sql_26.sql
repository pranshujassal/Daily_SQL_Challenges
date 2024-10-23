CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    total_items_ordered INT
);


INSERT INTO orders VALUES
(1, 101, '2022-01-01', 5),
(2, 102, '2022-01-02', 10),
(3, 103, '2022-01-03', 8),
(4, 104, '2022-01-04', 12),
(5, 105, '2022-01-05', 15),
(6, 106, '2022-01-06', 20),
(7, 107, '2022-01-07', 25),
(8, 108, '2022-01-08', 30),
(9, 109, '2022-01-09', 35),
(10, 110, '2022-01-10', 40),
(11, 111, '2022-01-11', 45),
(12, 112, '2022-01-12', 50),
(13, 113, '2022-01-13', 55),
(14, 114, '2022-01-14', 60),
(15, 115, '2022-01-15', 65);


CREATE TABLE returns (
    return_id INT,
    order_id INT,
    return_date DATE,
    returned_items INT
);

INSERT INTO returns VALUES
(1, 1, '2022-01-03', 2),
(2, 2, '2022-01-05', 3),
(3, 3, '2022-01-07', 1),
(4, 5, '2022-01-08', 4),
(5, 6, '2022-01-08', 6),
(6, 7, '2022-01-09', 7),
(7, 8, '2022-01-10', 8),
(8, 9, '2022-01-11', 9),
(9, 10, '2022-01-12', 10),
(10, 11, '2022-01-13', 11),
(11, 12, '2022-01-14', 12),
(12, 13, '2022-01-15', 13),
(13, 14, '2022-01-16', 14),
(14, 15, '2022-01-17', 15);


*

/*
Question:

Suppose you are given two tables - Orders and Returns. 
The Orders table contains information about orders placed by customers, 
and the Returns table contains information about returned items. 

Design a SQL query to 
find the top 5 ustomer with the highest percentage 
of returned items out of their total orders. 
	
Return the customer ID 
and the percentage of returned items rounded to two decimal places.

*/

SELECT
    o.customer_id,
    SUM(o.total_items_ordered) AS total_items_ordered,
    SUM(r.returned_items) AS total_items_returned,
    ROUND(CASE
        WHEN SUM(o.total_items_ordered) > 0 THEN (SUM(r.returned_items)::float / SUM(o.total_items_ordered)::float) * 100
        ELSE 0
    END::numeric, 2) AS return_percentage
FROM orders AS o
LEFT JOIN returns AS r
ON o.order_id = r.order_id
GROUP BY o.customer_id
ORDER BY return_percentage DESC
LIMIT 5;


--without null query 

SELECT
    o.customer_id,
    SUM(o.total_items_ordered) AS total_items_ordered,
    COALESCE(SUM(r.returned_items), 0) AS total_items_returned,  -- Replacing null with 0
    ROUND(CASE
        WHEN SUM(o.total_items_ordered) > 0 THEN (COALESCE(SUM(r.returned_items), 0)::float / SUM(o.total_items_ordered)::float) * 100
        ELSE 0
    END::numeric, 2) AS return_percentage
FROM orders AS o
LEFT JOIN returns AS r
ON o.order_id = r.order_id
GROUP BY o.customer_id
ORDER BY return_percentage DESC
LIMIT 5;
