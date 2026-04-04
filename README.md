# Google Merch Store Funnel and Revenue Analysis

## Overview
This project analyzes [Google Merchandise Store e-commerce data](https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=ga4_obfuscated_sample_ecommerce&t=events_20210131&page=table) using SQL in BigQuery. The goal was to understand which products and categories drove the most revenue, where users dropped off before purchasing, and whether conversion behavior differed by device.

## Objective
Analyze where users drop off before purchase and identify revenue-driving patterns in the Google Merchandise Store.

## Dataset
- [Google Analytics 4 (GA4) sample e-commerce dataset](https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=ga4_obfuscated_sample_ecommerce&t=events_20210131&page=table)
- Queried in BigQuery
- Analysis focused on purchase behavior, revenue, funnel progression, and device-level conversion

## Tools
- SQL
- BigQuery
- Excel / Google Sheets

## Business Questions
1. Which products drive the most purchases?
2. Which products generate the most revenue?
3. Which product categories generate the most revenue?
4. Where do users drop off in the purchase funnel?
5. Does conversion behavior differ by device?

## SQL Skills Demonstrated
- Filtering with `WHERE`
- Aggregation with `COUNT()` and `SUM()`
- Distinct user analysis with `COUNT(DISTINCT user_pseudo_id)`
- Grouping with `GROUP BY`
- Custom ordering with `CASE`
- Working with nested data using `UNNEST(items)`

## Key Findings

### 1. Top Purchased Products
The top purchased products were:
- Super G Unisex Joggers
- Google Zip Hoodie F/C
- Google Crewneck Sweatshirt Navy

This suggests that demand was concentrated among wearable apparel items.

### 2. Top Revenue-Generating Products
The top revenue-driving products were:
- Google Zip Hoodie F/C — $13,788
- Google Crewneck Sweatshirt Navy — $10,714
- Google Men’s Tech Fleece Grey — $9,965

This shows that the most frequently purchased products were not always the exact same products generating the highest revenue.

### 3. Revenue by Category
Top revenue-driving categories:
- Apparel — $171,727
- New — $25,813
- Bags — $23,860

Apparel generated the majority of category revenue, contributing 66.2% of revenue among the top categories analyzed.

### 4. Funnel Drop-Off
Distinct-user funnel results:
- `view_item`: 61,252
- `add_to_cart`: 12,545
- `begin_checkout`: 9,715
- `purchase`: 4,419

Conversion rates:
- View item → Add to cart: 20.48%
- Add to cart → Begin checkout: 77.44%
- Begin checkout → Purchase: 45.49%
- View item → Purchase overall: 7.21%

The largest drop-off occurred between product view and add-to-cart, suggesting that the strongest opportunity for optimization may be earlier in the product decision stage.

### 5. Conversion by Device
Overall conversion was relatively similar across devices:

**Desktop**
- View → Cart: 20.33%
- Cart → Checkout: 76.72%
- Checkout → Purchase: 44.85%
- View → Purchase: 7.00%

**Mobile**
- View → Cart: 20.73%
- Cart → Checkout: 77.17%
- Checkout → Purchase: 46.65%
- View → Purchase: 7.46%

**Tablet**
- View → Cart: 19.13%
- Cart → Checkout: 79.35%
- Checkout → Purchase: 44.29%
- View → Purchase: 6.72%

Device-level conversion was fairly consistent, with mobile slightly outperforming desktop overall. This suggests that drop-off may be driven more by broader shopping behavior or merchandising factors than by device-specific experience issues.

## Recommendations
- Improve product-page persuasion and merchandising to reduce drop-off before cart creation
- Prioritize top-performing apparel categories in promotional strategy
- Investigate broader purchase funnel friction rather than focusing only on device-specific UX

## Repository Structure
```text
.
├── README.md
├── queries/
│   ├── 01_top_products_by_purchase_count.sql
│   ├── 02_top_products_by_revenue.sql
│   ├── 03_revenue_by_category.sql
│   ├── 04_funnel_event_counts.sql
│   ├── 05_funnel_distinct_users.sql
│   └── 06_device_funnel.sql
├── images/
│   ├── top-products-revenue.png
│   ├── category-revenue.png
│   └── funnel-summary.png
└── notes/
    └── findings.md
