# prod_info
USE crm;
## check duplicates of columns
CALL checkDulplicate('prd_info','crm');

# NO duplicates in primary key -- prd_id;

## check data type

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'prd_info';

## check null value using stored procedure and cursor

CALL checkNULLlValue('prd_info','crm');

# check empty value
# cst_firstname,cst_lastname,cst_gndr contains null value

CALL checkEmptyValue('prd_info','crm');


 ## data cleaning
USE data_warehouse;
CREATE TABLE product_info AS 
SELECT * FROM crm.prd_info; 

CALL Remove_Whitespace('product_info','data_warehouse');
CALL MarkEmptyValue('product_info','data_warehouse');


## no Empty Value again;
CALL checkEmptyValue('product_info','data_warehouse');


# split prd_key into key1 to key2 to match the table(sales_details,product_category)
 
SET SQL_SAFE_UPDATES = 0;

ALTER TABLE product_info
ADD COLUMN  prd_key1 VARCHAR(20),
ADD COLUMN  prd_key2 VARCHAR(20);

Update product_info
SET prd_key1= LEFT(prd_key, 5),
    prd_key2=substring(prd_key,7);






