WITH base AS (
  SELECT 
    b.category,
    COUNT(a.order_id) as total_order,
    SUM(a.sale_price) as revenue,
    SUM(b.cost) as cost
  FROM bigquery-public-data.thelook_ecommerce.order_items a
  JOIN bigquery-public-data.thelook_ecommerce.products b
  ON a.product_id = b.id
  WHERE a.status = 'Complete'
  GROUP BY
    b.category
)

SELECT
  category,
  ROUND(revenue,2) as revenue,
  ROUND(cost,2) as cost,
  ROUND(revenue - cost,2) as margin,
  ROUND((revenue - cost) / revenue * 100,2) as margin_pct
FROM base
ORDER BY margin DESC