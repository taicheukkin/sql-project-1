SELECT * FROM erp.px_cat_g1v2;
USE erp;
CALL checkDulplicate('px_cat_g1v2','erp');
CALL checkNULLlVALUE('px_cat_g1v2','erp');
CALL checkEmptyVALUE('px_cat_g1v2','erp');
# no duplicates, missing value and null value

# check Datatype  
SELECT DATA_TYPE, COLUMN_NAME FROM information_schema.columns WHERE TABLE_NAME='px_cat_g1v2';

# no duplicates, missing value ,null value and data type

USE data_warehouse;
CREATE TABLE Product_category
AS SELECT * FROM erp.px_cat_g1v2;












