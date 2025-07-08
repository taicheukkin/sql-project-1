# sql-project-1

# purpose

the project aims to create star schema for erp and crm system in MYSQL to build connection between front-office business data and back-office data to faciltate business decision-making process.

# data source
the data was downloaded from github https://github.com/DataWithBaraa/sql-data-warehouse-project/tree/main/datasets


# structure of project

## data extraction 
Raw data contains 3 csv files for each erp system and crm system.

- crm system:cust_info.csv ,prd_info.csv,sales_details.csv

- erp system:CUST_AZ12.csv,LOC_A101.csv,PX_CAT_G1.csv

In MYSQL, create 2 schema(crm and erp) and table and load csv_file to MYSQL using table data import Wizard.

## data cleaning
step involve Standardize Data Formats and Data Quality Management

- Standard data format
-- ensure data_format is consistent within the column particularly date columns.

- Data quality managment
-- ensure there are no duplicates in primary key, no null and missing value.

The table from erp and crm schema is copied to the schema named data_warehouse, meaning that the data is ready for data modeling.

Stored procedure was created for simplfy data cleaning process

Table 1.1

|sql file for data cleaning| name of uncleaned table   | name of uncleaned table schema| name of cleaned table   | name of cleaned table schema|
|-----------------------|-------------------------------|------------------------------|-------------------------|------------------------------|
|location.sql           |LOC_A101                        |ERP| location|data_warehouse |
|prd_info.sql           |product_info                    |CRM| product_info|data_warehouse |
|product_category.sql   |px_CAT_G1                      |ERP|  product_category|data_warehouse |
|sales_details.sql      |sales_details           |CRM|   sales_details|data_warehouse |
|customer_demographic.sql|cut_za12                |ERP|  cust_demographic|data_warehouse |
|customer_info.sql      |cust_info                |CRM|  cust_info|data_warehouse |

## data modeling
step involvo data consistency of primary key and build data model 

-data consistency of primary key
-- make sure all the format of primary key is standardized 
-- create surrogate key if no primary key in table


build data model
data model is consist of 3 table namely dim_product,dim_customer,and fact_sales table. 

These 3 tables was combined from cleaned table by sql join, stored in sales_schema schema 


|name of cleaned_table| join with which table| new table name|                                   
|---------------------|----------------------|---------------|
|location             |cust_info             |dim_customer  |
|product_info        |product_category      |dim_product  |
|product_category    |product_info          |dim_product  |
|sales_details       |not applicable        |fact_sales|  
|cust_demographic   |cust_info             |dim_customer|    
|cust_info           |cust_demographic and location|dim_customer|  

The data model was created in ERR Program in MYSQL server

![image](https://github.com/user-attachments/assets/556de1f2-872f-45b1-b357-1385d0b073da)

The relationship between dim_customer and fact_sales is one-to-many with customer_id as primary key in dim_customer.

The relationship between dim_product and fact_sales is one-to-many with product_key as primary key in dim_product .













 



