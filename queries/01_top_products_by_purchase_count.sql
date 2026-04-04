-- Identify the top 3 purchased products by purchase count

SELECT
  item.item_name,
  COUNT(*) AS purchase_count
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
UNNEST(items) AS item
WHERE event_name = 'purchase'
  AND item.item_name IS NOT NULL
  AND item.item_name <> '(not set)'
GROUP BY item.item_name
ORDER BY purchase_count DESC
LIMIT 3;

-- Result:
-- 1. Super G Unisex Joggers
-- 2. Google Zip Hoodie F/C
-- 3. Google Crewneck Sweatshirt Navy
