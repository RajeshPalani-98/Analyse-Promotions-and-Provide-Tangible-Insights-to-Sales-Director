CREATE TABLE temp_product_summary AS
SELECT 
	product_name,
    SUM(Revenue_before_promo) as Total_RBP,
    SUM(Revenue_after_promo) AS Total_RAP
FROM
    fact_events as fe 
		JOIN 
	dim_products as dp ON fe.product_code=dp.product_code
GROUP BY product_name;

ALTER TABLE temp_product_summary
ADD COLUMN IRP float8;

UPDATE temp_product_summary
	SET
		IRP=((Total_RAP/ Total_RBP)*100);
        
SELECT
	tps.product_name,
    category,
    concat(IRP,'%') AS Incremental_Revenue_Percentage
FROM
	temp_product_summary as tps 
		JOIN
	dim_products as dp ON tps.product_name=dp.product_name
ORDER BY IRP DESC LIMIT 5
    

