SELECT * FROM erp.cust_az12 LIMIT 10;

USE erp;

call checkDulplicate('cust_az12','erp');

# CID is primary key, no duplicates and empty value
CALL checkEmptyValue('cust_az12','erp');
CALL checkNULLlValue('cust_az12','erp');

 SELECT BDATE FROM cust_az12 WHERE BDATE !=DATE_FORMAT(BDATE, '%Y-%m-%d');
 # ALL data fulfill the format

SELECT BDATE FROM cust_az12 WHERE YEAR(BDATE)<1900 OR MONTH(BDATE)>12 OR DAY(BDATE)>31;
# data_value is valid

#  check date type
SELECT COLUMN_NAME, DATA_TYPE from information_schema.columns WHERE TABLE_NAME='cust_az12';
 

# data cleaning
USE data_warehouse;
CREATE TABLE cust_demographic AS
SELECT *FROM erp.cust_az12;

CALL MarkEmptyValue('cust_demographic','data_warehouse');








 
 

