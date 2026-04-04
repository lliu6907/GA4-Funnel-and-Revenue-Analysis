-- Top 5 product categories that drove revenue
SELECT
  item.item_category,
  SUM(item.item_revenue_in_usd) AS revenue_usd
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
UNNEST(items) AS item
WHERE event_name = 'purchase' AND item.item_name <> '(not set)'
GROUP BY item.item_category
ORDER BY revenue_usd DESC
LIMIT 5

-- Result
-- Apparel: $171,727
-- New: $25,813
-- Bags: $23,860
-- Campus Collection: $20,061
-- Accessories: $17,815
