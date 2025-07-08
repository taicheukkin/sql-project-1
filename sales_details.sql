# sale detail
# check duplicates for primary key

USE crm;

call checkDulplicate('sales_details','crm');
##  duplicates was found all 6 collumns implying they are not primary key

# Check the composite key;
SELECT max(n) FROM(SELECT sls_prd_key,sls_ord_num,COUNT(*)AS n FROM sales_details GROUP BY sls_prd_key,sls_ord_num) cd;

# Since the result return 1, order_num ,order_prd_key will be compound key

# check data type
SELECT COLUMN_NAME, DATA_TYPE from information_schema.columns WHERE TABLE_NAME='sales_details';

CALL checkNULLlValue('sales_details','crm');

# check empty value
# null value

CALL checkEmptyValue('sales_details','crm');
 SELECT sls_ship_dt FROM  sales_details WHERE sls_ship_dt!=DATE_FORMAT(sls_ship_dt, '%Y-%m-%d') 
OR sls_ship_dt!=DATE_FORMAT(sls_order_dt, '%Y-%m-%d')
OR sls_ship_dt!=DATE_FORMAT(sls_due_dt, '%Y-%m-%d');

## check the integer value of datatime
SELECT sls_ship_dt,sls_order_dt, sls_due_dt FROM sales_details WHERE YEAR(sls_ship_dt)<1900 OR YEAR(sls_order_dt)<1900 OR
YEAR(sls_due_dt)<1900;
# the wrong range of integer is found in sls_order_dt

 ## data cleaning
# Data Type and format of sls_ship_dt,sls_order_dt AND sls_due_dt are incorrect 

USE data_warehouse;
CREATE TABLE sales_details AS
SELECT * FROM crm.sales_details;

DELETE FROM sales_details 
WHERE sls_order_dt<19000000;

UPDATE sales_details
SET sls_ship_dt=str_to_date(sls_ship_dt,'%Y%m%d'),
    sls_order_dt=str_to_date(sls_order_dt,'%Y%m%d'),
    sls_due_dt=str_to_date(sls_due_dt,'%Y%m%d');

# ERROR is found beacause of incorrect datetime value 0 in sls_ship_dt

ALTER TABLE sales_details
modify column sls_ship_dt datetime,
modify column sls_due_dt datetime,
modify column sls_order_dt datetime;



