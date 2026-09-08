# Product Performance Analysis

## 📌 Project Overview

This project analyzes **product performance across categories and brands over a 24-month period (January 2024 – December 2025)** using the TheLook Ecommerce public dataset to evaluate product return behavior, profitability, and cross-category purchase patterns.

The analysis focuses on identifying **high-return products and brands, profitable product categories, absolute margin contribution, and frequently co-purchased category pairs** to support inventory prioritization, pricing strategy, product optimization, and bundling/upsell opportunities.

The analysis was conducted using **Google BigQuery (GoogleSQL)** with CTEs, aggregations, JOINs, conditional filtering, ratio calculations, and multi-level product analysis.

---

## 🗂️ Dataset

The analysis uses the **TheLook Ecommerce** public dataset in Google BigQuery.

The analysis combines data from two tables:

- `order_items` — item-level transaction, product, status, and sales information
- `products` — product category, brand, cost, and product attribute information

### Key Columns

#### `order_items`

| Column | Description |
|---|---|
| `id` | Unique order item identifier |
| `order_id` | Identifier linking the order item to an order |
| `user_id` | Unique customer identifier associated with the order item |
| `product_id` | Identifier linking the order item to a product |
| `inventory_item_id` | Identifier linking the order item to an inventory item |
| `status` | Current status of the order item |
| `created_at` | Timestamp when the order item was created |
| `shipped_at` | Timestamp when the item was shipped |
| `delivered_at` | Timestamp when the item was delivered |
| `returned_at` | Timestamp when the item was returned |
| `sale_price` | Selling price of the product in the transaction |

#### `products`

| Column | Description |
|---|---|
| `id` | Unique product identifier |
| `cost` | Product cost |
| `category` | Product category |
| `name` | Product name |
| `brand` | Product brand |
| `retail_price` | Product retail price |
| `department` | Product department |
| `sku` | Stock keeping unit identifier |
| `distribution_center_id` | Identifier of the distribution center |

### Columns Primarily Used in the Analysis

The analysis primarily uses the following columns from the two source tables:

#### `order_items`

- `id` — identifies individual order item records
- `order_id` — identifies transactions and measures co-purchase behavior between categories
- `product_id` — connects transaction records with product attributes
- `status` — distinguishes completed and returned items
- `sale_price` — calculates revenue and profitability

#### `products`

- `id` — joins product information with transaction records
- `cost` — calculates product cost and gross margin
- `category` — analyzes return rate, profitability, and category-level co-purchase behavior
- `brand` — analyzes return performance at the brand level

---

## 🔗 Data Relationship

The two tables are connected through the product identifier:

```text
products
    │
    │ id = product_id
    ▼
order_items

This relationship allows order-level metrics to be combined with item-level sales and product attributes.

The resulting dataset can be used to evaluate **return behavior, profitability, and cross-category purchasing patterns**.

---

## 🛠️ Tools & Technologies

- **Google BigQuery**
- **GoogleSQL**
- CTEs (`WITH`)
- `JOIN`
- `COUNT()`
- `COUNT(DISTINCT)`
- `SUM()`
- 'ROUND()`
- `COALESCE()`
- Date Functions
- `DATE_DIFF()`
- Ratio Calculations
- Return Rate Calculation
- Gross Margin Calculation
- Category-Level Aggregation
- Brand-Level Aggregation
- Market Basket Analysis


---

## 📊 Key Metrics

### Total items Sold

Total number of order item records included in the product analysis.

### Returned Items

Number of order items with a ``Returned`` status.

### Return Rate

Percentage of returned items relative to total items sold.

`` 
Return Rate =
Returned Items / Total Items × 100
``

### Revenue

Total sales generated from completed order items.

``
Revenue =
SUM(sale_price)
``

### Cost

Total product cost associated with completed order items.

``
Cost =
SUM(cost)
``

### Gross Margin

Difference between revenue and product cost.

``
Gross Margin =
Revenue - Cost
``

### Gross Marg%

Percentage of revenue retained after product cost.

``
Gross Margin % =
(Revenue - Cost) / Revenue × 100
``

### Category Co-Purchase

Number of completed orders containing two different product categories within the same order.

This metric is used to identify **cross-selling and bundling opportunities**.

---

## 📈 Insight

* Overall blended return rate was **12.00%** across **59,846 items**, with **Jumpsuits & Rompers (16.50%)**, **Pants & Capris (15.54%)**, and **Skirts (14.94%)** recording the highest return rates.
* **Suits (10.03%)** and **Suits & Sport Coats (10.76%)** had the lowest return rates, indicating relatively lower return exposure among these categories.
* At brand level, **MJ Soffe Active (28.2%)**, **Calvin Klein Socks (20.8%)**, and **Casual Moments Sleep & Lounge (20.8%)** showed the highest return rates, making them priority candidates for product, sizing, or quality review.
* **Speedo (54 returned items)**, **Carhartt (49)**, and **Motherhood Maternity (47)** generated the highest return volumes. Although their return rates are not necessarily the highest, the absolute volume indicates a larger operational or customer-expectation impact.
* Overall gross margin reached **51.99%**, indicating a healthy margin profile across the analyzed product portfolio.
* **Blazers & Jackets (61.9%)**, **Skirts (60.3%)**, and **Suits & Sport Coats (60.0%)** delivered the highest margin percentages, indicating strong profitability relative to their sales.
* **Clothing Sets (38.6%)**, **Suits (39.7%)**, and **Socks (39.9%)** recorded the lowest margin percentages, making them potential candidates for pricing or assortment review.
* **Outerwear & Coats** generated the highest absolute margin at **$74.9K**, followed by **Jeans ($55.1K)** and **Sweaters ($42.7K)**. These categories represent the strongest contributors to overall catalog profitability.
* The strongest category co-purchase combinations were **Jeans + Tops & Tees (98x)**, **Fashion Hoodies & Sweatshirts + Tops & Tees (73x)**, and **Fashion Hoodies & Sweatshirts + Jeans (73x)**, highlighting potential bundle and cross-sell opportunities.
* **Fashion Hoodies & Sweatshirts** appeared in **5 of the top 10 category pairs**, making it the most frequently connected category and a strong anchor for bundle or recommendation strategies.

---

## 🧮 SQL Techniques Demonstrated

### 1. CTE (Common Table Expression)

Used multiple CTEs to separate analysis into logical stages, including total items, returned items, category profitability, and product basket construction.

```sql id="c2j8x4"
WITH all_order AS (...),
returned AS (...)
```

### 2. Date Filtering with `FORMAT_DATE()`

Restricted the analysis to transactions from **2024–2025** using year-based filtering on `created_at`.

```sql id="m4n7q2"
WHERE FORMAT_DATE('%Y', created_at) IN ('2024', '2025')
```

### 3. `JOIN`

Joined `order_items` with `products` using `product_id` and product `id` to combine transaction and product attributes.

```sql id="p8v3k1"
JOIN bigquery-public-data.thelook_ecommerce.products b
  ON a.product_id = b.id
```

### 4. Aggregation & `GROUP BY`

Used aggregation functions including `COUNT()`, `COUNT(DISTINCT)`, and `SUM()` to calculate item volume, returned items, revenue, cost, and category-level purchase combinations.

```sql id="q6t2r9"
COUNT(a.order_id) AS total_order,
SUM(a.sale_price) AS revenue,
SUM(b.cost) AS cost
```

### 5. `COALESCE` / `IFNULL`

Handled missing brand values and potential null results in the return-rate calculation.

```sql id="w1k5d7"
COALESCE(b.brand, 'Unknown') AS brand
```

and:

```sql id="e9r4u6"
IFNULL(
  ROUND(b.total_item_return / a.all_total_item * 100, 2),
  0
) AS return_rate
```

### 6. Ratio & Percentage Calculations

Calculated return rate and gross margin percentage directly from aggregated metrics.

**Return Rate:**

```sql id="f3a8c2"
ROUND(
  b.total_item_return / a.all_total_item * 100,
  2
) AS return_rate
```

**Gross Margin %:**

```sql id="h7d1m5"
ROUND(
  (revenue - cost) / revenue * 100,
  2
) AS margin_pct
```

### 7. Gross Margin Calculation

Calculated both absolute margin and margin percentage from revenue and product cost.

```sql id="u2b6n8"
revenue - cost AS margin
```

### 8. Self-JOIN for Market Basket Analysis

Joined the basket dataset to itself using the same `order_id` to identify category pairs purchased within the same order.

```sql id="z5c9x3"
JOIN basket b
  ON a.order_id = b.order_id
  AND a.category < b.category
```

The condition `a.category < b.category` prevents duplicate or reversed pairs such as `Jeans + Tops & Tees` and `Tops & Tees + Jeans`.

### 9. `COUNT(DISTINCT)` for Co-Purchase Frequency

Counted distinct orders containing each category pair to measure how frequently two categories were purchased together.

```sql id="r4k7p2"
COUNT(DISTINCT a.order_id) AS bought_together
```

### 10. `ORDER BY` for Ranking

Used descending sorting to identify the highest-return-volume brands, highest-margin categories, and most frequently co-purchased category pairs.

```sql id="n6v2s8"
ORDER BY bought_together DESC
```


---

## 📁 Project Structure

```text
Product-Performance-Analysis/
│
├── README.md
│
├── sql/
│   └── query_1 return rate product.sql
│   └── query_2 highest margin.sql
│   └── query_3 market basket analysis.sql
│
├── images/
│   ├── Preview Table order_items the_look ecommerce.jpeg
│   └── Preview Table products the_look ecommerce.jpeg
│
└── dashboard/
│   └── dashboard.png
└── Output/
    └── Output Query 1.png
    └── Output Query 2.png
    └── Output Query 3.png
```

> The project uses the public TheLook Ecommerce dataset available through Google BigQuery. No private customer transaction data is included in this repository.


> The project uses the public TheLook Ecommerce dataset available through Google BigQuery. No private customer transaction data is included in this repository.

---

## 🚀 Future Analysis

## 🚀 Future Analysis

This analysis can be extended with additional product and commercial analytics such as:

* Product-Level Return Rate Analysis
* Brand-Level Profitability Analysis
* Product-Level Gross Margin Analysis
* Category Revenue Growth Analysis
* Brand Revenue Growth Analysis
* Product Performance Ranking
* Product Profitability Ranking
* Low-Margin Product Identification
* High-Return Product Identification
* Return Reason Analysis
* Customer Segment by Product Category
* Customer Purchase Affinity Analysis
* Market Basket Analysis at Product Level
* Product Recommendation Analysis
* Cross-Sell Opportunity Analysis
* Bundle Performance Analysis
* Pricing Optimization
* Inventory Prioritization
* Product Demand Forecasting

These additional analyses would provide a deeper understanding of **product profitability, customer purchasing behavior, return drivers, and cross-selling opportunities**, helping businesses optimize product assortment, pricing, inventory, and merchandising strategies.


---

## 👤 Author

[Curriculum Vitae](https://drive.google.com/file/d/1Sf1mfTCJu-IcL2qFh0gElmXqYrTEsl3b/view?usp=sharing) | [Portfolio](https://public.tableau.com/app/profile/adin4572/vizzes)

**Adient Fir**

Data Analyst Portfolio Project

**Focus:** SQL | Product Analytics | Business Analytics | BigQuery 
