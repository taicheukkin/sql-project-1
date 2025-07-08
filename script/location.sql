SELECT * FROM erp.loc_a101;
USE erp;
CALL checkDulplicate('loc_a101','erp');
CALL checkNULLlVALUE('loc_a101','erp');
CALL checkEmptyVALUE('loc_a101','erp');

## NO null value, duplicates, but have empty value

USE data_warehouse;
CREATE TABLE location
AS SELECT * FROM erp.loc_a101;

CALL MarkEmptyValue('location','data_warehouse');








