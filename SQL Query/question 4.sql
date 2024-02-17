CREATE TABLE temp_category_summary AS
SELECT 
	category,
    sum(`quantity_sold(after_promo)`) as Total_SAP,
    sum(`quantity_sold(before_promo)`) as Total_SBP
FROM
    fact_events as fe 
		JOIN 
	dim_products as dp ON fe.product_code=dp.product_code 
WHERE campaign_id="CAMP_DIW_01"
GROUP BY category;

ALTER TABLE temp_category_summary
ADD COLUMN ISU float8;

UPDATE temp_category_summary
	SET
		ISU=((Total_SAP/ Total_SBP)*100);
        
SELECT 
	category,
    concat(ISU,'%') AS Incremental_Sold_Quantity,
    RANK() OVER (order by ISU DESC) as _rank_ 
FROM
	temp_category_summary
	

     