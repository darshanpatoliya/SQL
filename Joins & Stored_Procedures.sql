-- Assignment2

--Q14
select s.name as salesman_name, c.cust_name, c.city 
from salesman s join customer c on
s.salesman_id = c.salesman_id
where c.city = s.city;

--Q15
select o.order_no, o.purch_amt, c.cust_name, c.city
from orders o join customer c on
c.customer_id = o.customer_id
where o.purch_amt >= 500 and o.purch_amt <= 2000;

--Q16
-- How did it decide to group by the salesmans with more than one customer? 
-- and if you run the query with inner join then it will arrange it by alphabetically, how come?
SELECT s.name as salesman_name, c.cust_name
FROM salesman s LEFT JOIN customer c ON
s.salesman_id = c.salesman_id;

--Q17
SELECT c.cust_name 
FROM customer c JOIN salesman s ON
c.salesman_id = s.salesman_id
WHERE s.commission > 0.12;

--Q18
-- Question has unnecessory condition
SELECT cust_name
FROM customer
WHERE grade < 300
ORDER BY cust_name ASC;

--Q19
SELECT cust_name 
FROM customer
WHERE grade > 100;

--Q20
SELECT cust_name 
FROM customer
WHERE city = 'New York' and grade > 100;

--Q21
SELECT cust_name 
FROM customer
WHERE city = 'New York' or grade > 100;

--Q22

SELECT * 
FROM  orders 
WHERE (NOT ord_date = '2012-09-10' AND salesman_id <= 5005) 
OR purch_amt <= 1000.00;

--Q23
-- Unclear statement: "Display all in reverse"
SELECT * 
FROM  orders 
WHERE ord_date = '2012-08-17' OR 
(customer_id > 3005 AND purch_amt < 1000);



--Q24
SELECT SUM(purch_amt) as total_of_all_purchase_amount
FROM orders;

--Q25
SELECT AVG(purch_amt) as total_of_all_purchase_amount
FROM orders;

--Q26
SELECT COUNT(DISTINCT salesman_id) 
FROM customer;

--Q27
SELECT COUNT(DISTINCT customer_id) 
FROM customer;

--Q28
SELECT MAX(purch_amt)
FROM orders;

--Q29
SELECT MIN(purch_amt)
FROM orders;

--Q30
SELECT customer_id, MAX(purch_amt) AS highest_purchase_amount
FROM orders 
GROUP BY customer_id
ORDER BY MAX(purch_amt) DESC;

--Q31
SELECT customer_id, MAX(purch_amt) AS highest_purchase_amount, ord_date
FROM orders 
GROUP BY ord_date, customer_id
HAVING MAX(purch_amt) BETWEEN 2000 AND 6000;

--Q32
SELECT salesman_id, ord_date, COUNT(salesman_id) as number_of_salesman
FROM orders
GROUP BY ord_date, salesman_id;

--Q33
SELECT * 
FROM orders
ORDER BY order_no ASC;

--Q34
SELECT * 
FROM orders
ORDER BY ord_date DESC;

--Q35
SELECT *
FROM orders
ORDER BY ord_date ASC, purch_amt DESC;


--Q36

BEGIN

DROP VIEW IF EXISTS displayAllInfo

CREATE VIEW displayAllInfo AS
SELECT c.customer_id, c.cust_name, c.city, grade, 
	c.salesman_id, name AS salesman_name, commission, 
	order_no, purch_amt, ord_date 
FROM customer c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN salesman s
ON o.salesman_id = s.salesman_id; 

END


--Q37
--Stored Procudures

DROP PROCEDURE IF EXISTS SP_Order_Customer_Details

CREATE PROCEDURE SP_Order_Customer_Details
AS
SELECT * 
FROM customer AS c 
JOIN orders AS o
ON o.customer_id = c.customer_id
ORDER BY cust_name;

EXECUTE SP_Order_Customer_Details;

--Q38
DROP PROCEDURE IF EXISTS SP_Customer_Salesman_Details

CREATE PROCEDURE SP_Customer_Salesman_Details @customer_id INT
AS
SELECT * 
FROM customer AS c
JOIN salesman AS s
ON c.salesman_id = s.salesman_id
WHERE customer_id = @customer_id;

EXECUTE SP_Customer_Salesman_Details 3001;

--Q39

CREATE PROCEDURE SP_Customer_Details
AS 
SELECT * FROM customer;

EXECUTE SP_Customer_Details;

--Q40
DROP PROCEDURE IF EXISTS SP_Order_Details_Salesman

CREATE PROCEDURE SP_Order_Details_Salesman @salesman_id INT
AS 
SELECT * FROM orders
WHERE salesman_id = @salesman_id;

EXECUTE SP_Order_Details_Salesman 5001;

--Q41

DROP PROCEDURE IF EXISTS SP_Update_City

CREATE PROCEDURE SP_Update_City @customer_id INT, @city NVARCHAR(MAX)
AS 
UPDATE customer
SET city = @city
WHERE customer_id = @customer_id;

EXECUTE SP_Update_City @customer_id=3001, @city='London';

--Q42
SELECT YEAR(ord_date) AS Years
FROM orders;

--43
SELECT FORMAT (ord_date, 'dd-MM-yyyy') as ord_date
FROM orders;

-- Q44
SELECT *
FROM orders
WHERE MONTH(ord_date) = '01';

-- Q45
SELECT *
FROM orders
WHERE DAY(ord_date) BETWEEN '15' AND '30';

-- USER DEFINED FUNCTION --
-- Q46
DROP FUNCTION IF EXISTS fn_CustomerTotalPurchaseAmount
GO
CREATE FUNCTION fn_CustomerTotalPurchaseAmount (@CustomerId INT)
RETURNS TABLE
AS 
RETURN
	SELECT SUM(purch_amt) as total 
	FROM orders
	WHERE customer_id = @CustomerId;

-- To Execute Function
SELECT * FROM fn_CustomerTotalPurchaseAmount(3002);

-- Q47
DROP FUNCTION IF EXISTS fn_SalesmanTotalCommission
GO
CREATE FUNCTION fn_SalesmanTotalCommission (@SalesmanId INT)
RETURNS TABLE
AS

RETURN
	SELECT commission
	FROM salesman
	WHERE salesman_id = @SalesmanId


-- To Execute Function
SELECT * FROM fn_SalesmanTotalCommission (5001);

-- Q48
DROP FUNCTION IF EXISTS fn_CustomerNameOrder 
GO
CREATE FUNCTION fn_CustomerNameOrder  (@OrderId INT)
RETURNS TABLE
AS
RETURN
	SELECT c.cust_name
	FROM customer c 
	JOIN orders o
	ON c.customer_id = o.customer_id
	WHERE o.order_no = @OrderId;
--To Execute Function
SELECT * FROM fn_CustomerNameOrder (70002);
