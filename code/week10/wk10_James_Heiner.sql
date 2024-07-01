-- -------------------------------------------------------------------------------------------

USE bike;

-- -------------------------------------------------------------------------------------------
-- 1. Get the average quantity that we have in all our bike stocks.
--    Round to the nearest whole number.
-- -------------------------------------------------------------------------------------------
SELECT ROUND(AVG(quantity))
FROM stock;

-- -------------------------------------------------------------------------------------------
-- 2. Show each bike that needs to be reordered
--    (those bikes that are out of stock).
--    Filter the results to only the lowest quantity of zero.
--    Order by product_name.
--    (hint for this one: 
--     Two different stores have the same bike that needs to be reordered
--     , you only need it to show up once.)
-- -------------------------------------------------------------------------------------------
SELECT distinct product_name AS 'Bike models out of stock'
FROM product p
INNER JOIN stock s
ON p.product_id = s.product_id
WHERE quantity = 0
ORDER BY product_name; 
-- -------------------------------------------------------------------------------------------
-- 3. How many bikes for each category of bike do we have in stock at
--    our "Rowlett Bikes" store. We need to see the name of the category
--    as well as the number of bikes in the category.
--    Sort it by lowest total first.
-- -------------------------------------------------------------------------------------------
SELECT category_name AS 'Category', SUM(quantity) AS 'Number of bikes'
FROM category c 
INNER JOIN product p 
ON c.category_id = p.category_id
INNER JOIN stock s 
ON p.product_id = s.product_id
INNER JOIN store sr 
ON s.store_id = sr.store_id
WHERE store_name = 'Rowlett Bikes'
GROUP BY category_name
ORDER BY count(product_name) ASC;


-- -------------------------------------------------------------------------------------------
-- 4. How many employees do we have?
-- -------------------------------------------------------------------------------------------
SELECT COUNT(emp_no) AS 'Number of employees'
FROM employees;
-- -------------------------------------------------------------------------------------------
-- 5. Get the average salaries in each department.
--    We only need those departments that have
--    average salaries that are below 60,000.
--    Format the salary to 2 decimal places and a comma
--    in the thousands place and dollar sign in front. 
-- -------------------------------------------------------------------------------------------
SELECT dept_name AS 'Department', CONCAT("$",FORMAT(AVG(salary),2)) AS 'Average Salary'
FROM salaries s 
INNER JOIN dept_emp de
ON s.emp_no = de.emp_no
INNER JOIN departments d 
ON de.dept_no = d.dept_no
GROUP BY dept_name
HAVING AVG(salary) < 60000;



-- -------------------------------------------------------------------------------------------
-- 6. Find out how many males work in each department
--    List the department name and number of male workers,
--    ordered from most to least.
-- -------------------------------------------------------------------------------------------
SELECT dept_name AS 'Department', COUNT(gender) AS 'Number of Men'
FROM departments d
INNER JOIN dept_emp de
ON d.dept_no = de.dept_no
INNER JOIN employees e 
ON de.emp_no = e.emp_no
WHERE gender = 'M'
GROUP BY dept_name
ORDER BY COUNT(gender) DESC;