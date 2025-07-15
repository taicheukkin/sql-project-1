# task 1 ensure all the data format of primary key are consistent;

# first 4 character and  rest of characters of prd_key in product_info table are mapped with sales details and 
# product_category respectively

USE data_warehouse;

ALTER TABLE product_info
ADD prd_key1 varchar(20),
ADD prd_key2 varchar(20);

UPDATE product_info
SET prd_key1=left(prd_key,5),
    prd_key2=substring(prd_key,7);
 
 
UPDATE product_category
SET ID= replace(ID,"_","-"); 
 
# remove "NAS" customer ID in cust_demographic to make it  consistent to customer info
  
UPDATE cust_demographic
SET CID= REPLACE(CID ,'NAS',''); 
# the primary key should start with NAS    


# remove "NAS" customer ID in cust_demographic to make it  consistent to customer info

UPDATE location
SET CID= replace(CID,'-','');

# TASK 2 data modeling
# generate 1 fact table(fact.sales), 2 dimention table(dim_customer, dim product)


USE sales_schema;
CREATE TABLE `dim.customer` AS 
SElECT
c.cst_id AS customer_id,
c.cst_key AS customer_key, 
c.cst_firstname AS first_name,
c.cst_lastname AS last_name, 
c.cst_marital_status AS marital_status , 
c.cst_gndr AS gender, 
c.cst_create_date AS create_date,
d.BDATE AS birthday,
l.cntry AS Country
FROM data_warehouse.cust_info c 
LEFT JOIN data_warehouse.cust_demographic d 
ON c.cst_key=d.CID
LEFT JOIN data_warehouse.location l
ON l.CID=c.cst_key;

CREATE TABLE `dim.product` AS
SELECT 
      i.prd_id AS product_id, 
      i.prd_key AS product_key_cat_id,
      i.prd_nm AS product_name, 
      i.prd_cost AS product_cost, 
      i.prd_line AS product_line, 
      i.prd_start_dt AS product_startTime,
      i.prd_end_dt AS product_endTime,
      i.prd_key1 AS product_key,
      i.prd_key2 AS cat_id,
      c.CAT AS category,
      c.SUBCAT AS subcategory,
      c.MAINTENANCE AS Maintenance
      FROM data_warehouse.product_info i
      LEFT JOIN data_warehouse.product_category c
      ON i.prd_key1=c.ID;

CREATE TABLE `fact_sales` AS
	SELECT sls_ord_num AS order_number, 
	s.sls_prd_key AS product_key, 
	s.sls_cust_id AS customer_id, 
	s.sls_order_dt AS order_date, 
	s.sls_ship_dt AS ship_date, 
	s.sls_due_dt AS d_date, 
	s.sls_sales AS sales, 
	s.sls_quantity AS quantity, 
	s.sls_price AS price,
	p.product_id AS product_id	
	FROM data_warehouse.sales_details s
	left join `dim.product`p
	ON s.sls_prd_key =p.cat_id;

ALTER TABLE `dim.customer`
ADD PRIMARY KEY(customer_id);



ALTER TABLE`dim.product`
ADD PRIMARY KEY (product_id); 

# create relationship between table
ALTER TABLE fact_sales
ADD FOREIGN KEY (product_id) REFERENCES `dim.product`(product_id),
ADD FOREIGN KEY (customer_id) REFERENCES `dim.customer`(customer_id);
ADD PRIMARY KEY (product_key, order_number);       






      
