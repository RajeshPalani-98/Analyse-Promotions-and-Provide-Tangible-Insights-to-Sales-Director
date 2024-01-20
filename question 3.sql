ALTER TABLE	fact_events
ADD COLUMN Revenue_before_promo int,
ADD COLUMN Revenue_after_promo int;

UPDATE fact_events 
SET 
    Revenue_before_promo = base_price * `quantity_sold(before_promo)`,
    Revenue_after_promo = base_price * `quantity_sold(after_promo)`;
    
SELECT 
    campaign_name,
    concat((SUM(Revenue_before_promo)/ 1000000.0),' M') as Total_Revenue_before_promo,
    concat((SUM(Revenue_after_promo) / 1000000.0),' M') as Total_Revenue_after_promo
FROM
    fact_events AS fe
        JOIN
    dim_campaigns AS dc ON fe.campaign_id = dc.campaign_id
GROUP BY campaign_name;
