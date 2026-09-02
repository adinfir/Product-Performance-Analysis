# Product Performance, Return Rate & Margin Analysis

## 📌 Project Overview

This project analyzes **product performance across categories and brands** using the TheLook Ecommerce public dataset to evaluate product return behavior, profitability, and cross-category purchase patterns.

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

### 🔄 Overall Product Return Performance

The overall blended return rate was **10.69%** across approximately **167K** items sold.

The highest return rate categories were:

- **Jumpsuits & Rompers  13.59%**
- **Plus  11.93%**
- **Blazers & Jackets  11.36%**

These categories have return rates above the overall portfolio average and may require further investigation into **product fit, sizing, product descriptions, quality, or customer expectations**.
---

### ✅ Lowest Return Rate Category

**Suits** recorded the lowest return rate at **9.59%**.

The relatively low return rate may indicate stronger product-market fit, better size confidence, or lower expectation gaps compared with other categories.

This category can serve as a benchmark when evaluating product attributes associated with lower return behavior.

---

### ⚠️ High-Return Brands

At the brand level, **Mountain Khakis Pants** recorded a return rate of approximately **30.3%**, **while Swim Carve Designs** recorded approximately **26.7%**.

These return rates are significantly above the overall portfolio average and warrant further investigation, particularly around:

- Product sizing
- Product fit
- Product descriptions
- Product quality
- Customer expectations

Reducing return rates for these brands could help improve both customer experience and operational efficiency.

---

### 📦 Highest Volume of Returned Items

**Speedo** recorded the highest number of returned items at **119 items**, followed by **Motherhood Maternity** with **116 returned items**.

Although their return rates were approximately **10–11%**, the high absolute number of returns indicates a meaningful operational impact.

These brands may warrant investigation into **fulfillment quality, product expectations, sizing, and return drivers**.

---

### 💰 Overall Gross Margin

The overall gross margin was approximately **51.85%**, indicating a healthy level of profitability across the analyzed product portfolio.

However, profitability varies significantly between categories, making category-level margin analysis important for determining which products should receive greater strategic focus.

---

### 📈 Highest Margin Categories

**Blazers & Jackets** and **Skirts** were among the highest-margin categories, with gross margin percentages of:

- **Blazers & Jackets = 62.22%**
- **Skirts = 59.95%**

These categories demonstrate strong profitability per unit despite not necessarily being the highest-revenue categories.

They may represent attractive opportunities for **inventory prioritization, merchandising, and promotional investment**.

---

### 📉 Lowest Margin Categories

The lowest-margin categories identified were:

- Clothing Sets = 38.47%
- Suits = 39.54%
- Socks = 39.63%

These categories generate considerably lower gross margin percentages compared with the overall portfolio.

Potential actions include **pricing review, supplier cost optimization, promotional strategy adjustment, or reduced inventory focus**.

---

### 🏆 Highest Absolute Margin Contributors

**Outerwear & Coats* generated the highest absolute margin at approximately **$184K**, followed by **Jeans** at approximately **$148K**.

These two categories represent important contributors to overall profitability.

While margin percentage measures profitability efficiency, absolute margin highlights categories that contribute the greatest amount of profit to the business.

Therefore, **Outerwear & Coats and Jeans can be considered key revenue and profit backbones of the product portfolio**.

---
### 🛍️ Top Cross-Sell Category Pairs

Market basket analysis at the category level identified the following top co-purchased category pairs:

| Rank | Category Pair        | Bought Together |
| ---: | -------------------- | --------------: |
|    1 | Jeans + Sweaters     |            184x |
|    2 | Shorts + Tops & Tees |            179x |
|    3 | Jeans + Tops & Tees  |            174x |

These category combinations represent strong opportunities for:

* Product bundling
* Cross-selling
* Recommendation systems
* Promotional campaigns
* Merchandising placement

For example, customers purchasing **Jeans** could be targeted with **Sweaters** or **Tops & Tees** recommendations.

---

### 👕 Fashion Hoodies & Sweatshirts as a Complementary Category

**Fashion Hoodies & Sweatshirts** appeared in **4 of the top 10 category pairs** identified by the market basket analysis.

This indicates that the category has strong purchasing relationships with multiple other product categories.

As a result, **Fashion Hoodies & Sweatshirts** could be used as an **anchor category for bundle promotions and cross-selling campaigns**.

---

## 🧮 SQL Techniques Demonstrated

This project demonstrates practical SQL techniques commonly used in Data Analyst workflows.

### CTE

CTEs were used to separate different analytical stages, including total item calculations, returned item calculations, margin analysis, and market basket analysis.

```sql
WITH all_order AS (
    SELECT
        b.category,
        COALESCE(b.brand, 'Unknown') AS brand,
        COUNT(a.product_id) AS all_total_item
    FROM `bigquery-public-data.thelook_ecommerce.order_items` a
    JOIN `bigquery-public-data.thelook_ecommerce.products` b
        ON a.product_id = b.id
    GROUP BY
        b.category,
        b.brand
)
```

### JOIN

`JOIN` was used to connect transaction-level order items with product attributes.

```sql
JOIN `bigquery-public-data.thelook_ecommerce.products` b
    ON a.product_id = b.id
```

This allows transaction records to be analyzed based on product category and brand.

### COALESCE

`COALESCE()` was used to handle missing brand values by assigning them to an `Unknown` category.

```sql
COALESCE(b.brand, 'Unknown') AS brand
```

This prevents missing brand values from being excluded from the brand-level analysis.

### Conditional Filtering

The `WHERE` clause was used to isolate returned items and completed transactions.

```sql
WHERE a.status = 'Returned'
```

For profitability analysis:

```sql
WHERE a.status = 'Complete'
```

This ensures that revenue and margin calculations are based on completed transactions.

### Return Rate Calculation

Return rate was calculated by comparing returned items against total items.

```sql
ROUND(
    b.total_item_return / a.all_total_item * 100,
    2
) AS return_rate
```

This metric allows return performance to be compared across different categories and brands.

### Gross Margin Calculation

Gross margin was calculated as revenue minus product cost.

```sql
ROUND(
    revenue - cost,
    2
) AS margin
```

Gross margin percentage was then calculated as:

```sql
ROUND(
    (revenue - cost) / revenue * 100,
    2
) AS margin_pct
```

This provides both absolute profitability and profitability efficiency.

### COUNT DISTINCT

`COUNT(DISTINCT)` was used in the market basket analysis to ensure that each category pair was counted once per order.

```sql
COUNT(DISTINCT a.order_id) AS bought_together
```

This prevents multiple products from the same category within an order from artificially increasing the category-pair frequency.

### Market Basket Analysis

A self-join was used to identify product categories purchased together within the same order.

```sql
FROM basket a
JOIN basket b
    ON a.order_id = b.order_id
    AND a.category < b.category
```

The condition:

```sql
a.category < b.category
```

ensures that each category pair is counted only once and prevents duplicate combinations such as:

```text
Jeans + Sweaters
Sweaters + Jeans
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
│   └── dashboard.jpeg
└── Output/
    └── Output Query 1.jpeg
    └── Output Query 2.jpeg
    └── Output Query 3.jpeg
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
