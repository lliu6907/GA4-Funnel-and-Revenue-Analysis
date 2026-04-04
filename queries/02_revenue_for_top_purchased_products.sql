-- Continue with `purchase_revenue_in_usd` to generate revenue from top 3 items most purchased.

SELECT
 item.item_name,
 SUM(item.item_revenue_in_usd) AS revenue_usd,
 COUNT(*) AS purchase_count
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
UNNEST(items) AS item
WHERE event_name = 'purchase' AND item.item_name <> '(not set)'
GROUP BY item.item_name
ORDER BY purchase_count DESC
LIMIT 3;

-- Result: 
-- 1. Google Zip Hoodie F/C ($13,788)
-- 2. Google Crewneck Sweatshirt Navy ($10,714)
-- 3. Super G Unisex Joggers ($9,529)
