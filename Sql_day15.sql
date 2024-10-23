-- SQL Challenge 15/30 Days 

CREATE TABLE Sales (
    SaleID SERIAL PRIMARY KEY,
    Region VARCHAR(50),
    Amount DECIMAL(10, 2),
    SaleDate DATE
);

INSERT INTO Sales (Region, Amount, SaleDate) VALUES
('North', 5000.00, '2024-09-01'),
('South', 6000.00, '2024-09-02'),
('East', 4500.00, '2024-09-03'),
('West', 7000.00, '2024-09-04'),
('North', 5500.00, '2024-09-05'),
('South', 6500.00, '2024-09-06'),
('East', 4800.00, '2024-09-07'),
('West', 7200.00, '2024-09-08'),
('North', 5200.00, '2024-09-09'),
('South', 6200.00, '2024-09-10'),
('East', 4700.00, '2024-09-11'),
('West', 7100.00, '2024-09-12'),
('North', 5300.00, '2024-09-13'),
('South', 6300.00, '2024-09-14'),
('East', 4600.00, '2024-09-15'),
('West', 7300.00, '2024-09-16'),
('North', 5400.00, '2024-09-17'),
('South', 6400.00, '2024-09-18'),
('East', 4900.00, '2024-09-19'),
('West', 7400.00, '2024-09-20'),
('North', 5600.00, '2024-09-21'),
('South', 6600.00, '2024-09-22'),
('East', 5000.00, '2024-09-23'),
('West', 7500.00, '2024-09-24'),
('North', 5700.00, '2024-09-25'),
('South', 6700.00, '2024-09-26'),
('East', 5100.00, '2024-09-27'),
('West', 7600.00, '2024-09-28');





/*

Identify the region with the lowest sales amount for the previous month. 
return region name and total_sale amount.

*/
-- region and sum sale
-- filter last month
-- lowest sale region



SELECT 
	region,
	SUM(amount) as total_sales
FROM sales
WHERE EXTRACT(MONTH FROM saledate) = EXTRACT(MONTH FROM CURRENT_DATE - INTERVAL '1 month')
AND EXTRACT(YEAR FROM saledate) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY region
ORDER BY total_sales ASC
LIMIT 1;




