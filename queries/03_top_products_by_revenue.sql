-- Identify the top 3 revenue-generating products

SELECT
 item.item_name,
 SUM(item.item_revenue_in_usd) AS revenue_usd
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
UNNEST(items) AS item
WHERE event_name = 'purchase' AND item.item_name <> '(not set)'
GROUP BY item.item_name
ORDER BY revenue_usd DESC
LIMIT 3;

-- Result:
-- 1. Google Zip Hoodie F/C ($13,788)
-- 2. Google Crewneck Sweatshirt Navy ($10,714)
-- 3. Google Men’s Tech Fleece Grey ($9,965)

-- Insight: Google Men’s Tech Fleece Grey generated $436 more revenue compared to Super G Unisex Joggers
