--market basket analysis level category
WITH basket AS (
  SELECT DISTINCT
    a.order_id,
    b.category
  FROM bigquery-public-data.thelook_ecommerce.order_items a
  JOIN bigquery-public-data.thelook_ecommerce.products b
    ON a.product_id = b.id
  WHERE a.status = 'Complete'
),


pair AS (
  SELECT
    a.category AS category_a,
    b.category AS category_b,
    COUNT(DISTINCT a.order_id) AS bought_together

  FROM basket a

  JOIN basket b
    ON a.order_id = b.order_id
    AND a.category < b.category

  GROUP BY
    category_a,
    category_b
)

SELECT *
FROM pair
ORDER BY bought_together DESC;