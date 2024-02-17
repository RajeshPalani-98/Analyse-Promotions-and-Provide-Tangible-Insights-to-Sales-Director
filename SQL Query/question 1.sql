SELECT 
    product_name as Product_With_PromoType_BOGOF_AND_Price_Higherthan_500
FROM
    dim_products
WHERE
    product_code IN (SELECT 
            product_code
        FROM
            fact_events
        WHERE
            base_price > 500
                AND promo_type = 'BOGOF')
