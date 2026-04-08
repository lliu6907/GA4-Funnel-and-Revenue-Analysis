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
- Using CTEs to conduct a sequential user-level funnel

## Key Findings

### 1. Top Purchased Products
The top purchased products were:
- Google Clear Pen 4-Pack (444 purchases)
- Google Laptop and Cell Phone Stickers (416 purchases)
- Google Metallic Notebook Set (365 purchases)

This suggests that demand was concentrated among stationary items, like pens, stickers, and notebooks.

### 2. Top Revenue-Generating Products
<p align="left">
  <img src="images/top3_revenue" alt="Top 3 Revenue Generating Products" width="450">
</p>

The top revenue-driving products were:
- Google Zip Hoodie F/C — $13,788
- Google Crewneck Sweatshirt Navy — $10,714
- Google Men’s Tech Fleece Grey — $9,965

This shows that the most frequently purchased products were not always the exact same products generating the highest revenue.

### 3. Revenue by Category
<p align="left">
  <img src="images/product_category_pie" alt="Top 5 Product Categories by Revenue Share" width="450">
</p>

Top revenue-driving categories:
- Apparel — $171,727
- New — $25,813
- Bags — $23,860

Apparel generated the majority of category revenue, contributing 66.2% of revenue among the top categories analyzed.

### 4. Funnel Drop-Off
Sequential-level user funnel results:
- `viewed`: 61,252
- `added_to_cart`: 12,052
- `began_checkout`: 4,909
- `purchased`: 2,833

Conversion rates:
- View → Add to Cart: 12,052 / 61,252 = 19.68%
- Add to Cart → Begin Checkout: 4,909 / 12,052 = 40.73%
- Begin Checkout → Purchase: 2,833 / 4,909 = 57.71%

Overall Conversion Rate:
- View → Purchase: 2,833 / 61,252 = 4.63%

The largest drop-off occurred between product view and add-to-cart, suggesting that the strongest opportunity for optimization may be earlier in the product decision stage.

### 5. Conversion by Device
Overall conversion was relatively similar across devices:

**Desktop**
- View → Add to Cart: 7077 / 36323 = 19.49%
- Add to Cart → Begin Checkout: 2846 / 7077 = 40.21%
- Begin Checkout → Purchase: 1613 / 2846 = 56.68%
- Overall View → Purchase: 1613 / 36323 = 4.44%

**Mobile**
- View → Add to Cart: 4953 / 24810 = 19.96%
- Add to Cart → Begin Checkout: 2004 / 4953 = 40.46%
- Begin Checkout → Purchase: 1176 / 2004 = 58.68%
- Overall View → Purchase: 1176 / 24810 = 4.74%

**Tablet**
- View → Add to Cart: 263 / 1443 = 18.23%
- Add to Cart → Begin Checkout: 105 / 263 = 39.92%
- Begin Checkout → Purchase: 62 / 105 = 59.05%
- Overall View → Purchase: 62 / 1443 = 4.30%

Device-level conversion was fairly consistent, with mobile slightly outperforming desktop overall. This suggests that drop-off may be driven more by broader shopping behavior or merchandising factors than by device-specific experience issues.

## Recommendations
- Put more promotional focus on **apparel**, since it was the **strongest revenue-driving** category.
  - Apparel generated $171,727, far ahead of New ($25,813) and Bags ($23,860), and made up 66.2% of revenue among the top categories analyzed.
- Improve product pages so more viewers add items to their cart.
  - Only 19.68% of users who viewed a product moved to `added_to_cart` (12,052 out of 61,252), making this the largest drop-off point in the funnel.
- Investigate broader **purchase funnel friction** rather than **device-specific** fixes first.
  - Conversion was fairly similar across devices: overall `viewed_item` → `purchased` was 4.44% on desktop, 4.74% on mobile, and 4.30% on tablet.
 
## Limitations
- This analysis uses the GA4 sample e-commerce dataset, so findings are meant to demonstrate analytical approach rather than serve as direct business recommendations for a live company.
 Funnel results are based on user_pseudo_id and ordered event timestamps, which capture sequential user progression but do not guarantee a same-session purchase journey.
- Because GA4 BigQuery export contains raw event data, results may differ from GA4 UI reports, which can include additional modeling and reporting logic.

## Repository Structure
```text
.
├── README.md
└── queries/
    ├── 01_top_products_by_purchase_count.sql
    ├── 02_revenue_for_top_purchased_products.sql
    ├── 03_top_products_by_revenue.sql
    ├── 04_revenue_by_category.sql
    ├── 05_funnel_sequential_users.sql
    └── 06_device_funnel.sql
