--Assignment3

--Question1
CREATE TABLE TotalSalesByCustomer(
	customer_id INT,
	total_purch_amt DECIMAL(6,2)
);
INSERT INTO TotalSalesByCustomer(customer_id, total_purch_amt)  
SELECT DISTINCT(customer_id), SUM(purch_amt)
FROM  orders 
GROUP BY customer_id;

SELECT * FROM TotalSalesByCustomer;


--Question2
GO
DROP TRIGGER IF EXISTS OrderInsert 
GO 
CREATE TRIGGER OrderInsert
   ON  orders
   AFTER INSERT
AS
DECLARE @customer_id_new INT;
DECLARE @purch_amt_new DECIMAL;

BEGIN
SET @customer_id_new = (SELECT customer_id FROM inserted);
SET @purch_amt_new = (SELECT purch_amt FROM inserted);
IF EXISTS (SELECT customer_id FROM TotalSalesByCustomer WHERE customer_id=@customer_id_new)
	BEGIN
		UPDATE TotalSalesByCustomer
		SET total_purch_amt = total_purch_amt + @purch_amt_new
		WHERE customer_id = @customer_id_new;
	END
ELSE
	BEGIN
		INSERT INTO TotalSalesByCustomer(customer_id, total_purch_amt) VALUES(@customer_id_new, @purch_amt_new);
	END
END


--Question3
DROP PROCEDURE IF EXISTS SP_CustomersWithTwoOrMoreOrders
GO
CREATE PROCEDURE SP_CustomersWithTwoOrMoreOrders
AS
SELECT c.customer_id, c.cust_name, c.city, c.grade
FROM customer AS c
JOIN orders AS o
ON c.customer_id= o.customer_id
GROUP BY c.customer_id, c.cust_name, c.city, c.grade
HAVING COUNT(o.customer_id)>=2;

EXEC SP_CustomersWithTwoOrMoreOrders;


--Question4
DROP PROCEDURE IF EXISTS SP_OrderAndCustomerDetails
GO
CREATE PROCEDURE SP_OrderAndCustomerDetails(@order_id INT)
AS
SELECT c.customer_id, c.cust_name, c.city, c.grade, o.ord_date, o.order_no, o.purch_amt
FROM customer AS c
JOIN orders AS o
ON c.customer_id= o.customer_id
WHERE o.order_no=@order_id
GROUP BY c.customer_id, c.cust_name, c.city, c.grade, o.ord_date, o.order_no, o.purch_amt;

EXEC SP_OrderAndCustomerDetails 70010;


--Question5
DROP FUNCTION IF EXISTS GetCustomerName_fn
GO
CREATE FUNCTION GetCustomerName_fn(@customer_id INT)
RETURNS VARCHAR(255)
AS 
BEGIN
DECLARE @cust_name VARCHAR(255);
	SELECT @cust_name = cust_name FROM customer 
	WHERE customer_id = @customer_id;

	RETURN @cust_name;
END

SELECT dbo.GetCustomerName_fn(3001);

















