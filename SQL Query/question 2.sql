SELECT 
    city, COUNT(store_id) as Store_count
FROM
    dim_stores
GROUP BY city
ORDER BY COUNT(store_id) DESC