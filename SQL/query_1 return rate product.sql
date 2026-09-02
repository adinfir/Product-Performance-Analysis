--return product by Kategori + Brand
WITH all_order AS(
    SELECT
    b.category,
    COALESCE(b.brand, 'Unknown') AS brand,
    COUNT(a.product_id) as all_total_item
  FROM bigquery-public-data.thelook_ecommerce.order_items a
  JOIN bigquery-public-data.thelook_ecommerce.products b
    ON a.product_id = b.id
  GROUP BY
    b.category,
    b.brand
),
returned AS (
  SELECT
    b.category,
    COALESCE(b.brand, 'Unknown') AS brand,
    COUNT(a.product_id) as total_item_return
  FROM bigquery-public-data.thelook_ecommerce.order_items a
  JOIN bigquery-public-data.thelook_ecommerce.products b
    ON a.product_id = b.id
  WHERE a.status = 'Returned'
  GROUP BY
    b.category,
    b.brand
)

SELECT
  b.category,
  b.brand,
  b.total_item_return,
  a.all_total_item,
  ROUND(b.total_item_return / a.all_total_item*100,2) AS return_rate
FROM all_order a
JOIN returned b
  ON a.category = b.category AND
  a.brand = b.brand 
ORDER BY total_item_return DESC, return_rate DESC;

