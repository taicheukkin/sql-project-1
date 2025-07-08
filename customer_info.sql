USE crm;
## check duplicates of columns
CALL checkDulplicate('cust_info','crm');
# duplicates of primary key(cst_id,cst_key) is found 

SELECT * FROM cust_info WHERE cst_id=29433;

## check data type

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'cust_info';

## check null value using stored procedure and cursor
CALL checkNULLVALUE('cust_info','crm');

# check empty value
# cst_firstname,cst_lastname,cst_gndr contains null value

CALL checkEmptyVALUE('cust_info','crm');


 ## data cleaning
 
USE data_warehouse;
CREATE TABLE cust_info AS 
SELECT * FROM crm.cust_info; 


ALTER TABLE cust_info
ADD cst_full_name VARCHAR(50);

SET SQL_SAFE_UPDATES = 0;

CALL Remove_Whitespace('cust_info','data_warehouse');

CALL MarkEmptyValue('cust_info','data_warehouse');
 
 # concat the name
UPDATE cust_info 
SET 
cst_full_name=concat(cst_firstname," ",cst_lastname);

# DELETE duplicates 
DELETE FROM cust_info WHERE cst_id=29433 AND cst_firstname="NA";



















	




