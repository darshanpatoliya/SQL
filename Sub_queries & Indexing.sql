-- Assignment 1

ALTER TABLE [dbo].[customer]
ADD country NVARCHAR(MAX) NULL;


UPDATE [dbo].[customer] SET [country]='UK' WHERE [customer_id]=3001;
UPDATE [dbo].[customer] SET [country]='USA' WHERE [customer_id]=3002;
UPDATE [dbo].[customer] SET [country]='Russia' WHERE [customer_id]=3003;
UPDATE [dbo].[customer] SET [country]='France' WHERE [customer_id]=3004;
UPDATE [dbo].[customer] SET [country]='USA' WHERE [customer_id]=3005;
UPDATE [dbo].[customer] SET [country]='Germany' WHERE [customer_id]=3009;
UPDATE [dbo].[customer] SET [country]='USA' WHERE [customer_id]=3007;
UPDATE [dbo].[customer] SET [country]='UK' WHERE [customer_id]=3008;


SELECT * FROM salesman;

SELECT name, commission FROM salesman;

SELECT * FROM customer WHERE country='USA';

SELECT * FROM customer WHERE grade=200;

SELECT * FROM salesman WHERE commission>0.12;

SELECT * FROM orders WHERE purch_amt<2000;

ALTER TABLE [dbo].[customer]
DROP COLUMN country;