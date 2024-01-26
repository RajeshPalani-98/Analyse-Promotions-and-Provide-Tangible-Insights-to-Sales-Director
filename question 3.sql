SELECT 
    campaign_name,
    concat(round(SUM(Revenue_before_promo)/ 1000000.0),' M') as Total_Revenue_before_promo,
    concat(round(SUM(Revenue_after_promo) / 1000000.0),' M') as Total_Revenue_after_promo
FROM
    fact_events AS fe
        JOIN
    dim_campaigns AS dc ON fe.campaign_id = dc.campaign_id
GROUP BY campaign_name;
