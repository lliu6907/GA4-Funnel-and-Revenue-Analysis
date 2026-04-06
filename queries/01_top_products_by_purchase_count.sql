-- Identify the top 3 purchased products by purchase count

SELECT
item.item_name,
SUM(item.quantity) AS purchase_count
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
UNNEST(items) AS item
WHERE event_name = 'purchase' AND item.item_name <> '(not set)'
GROUP BY item.item_name
ORDER BY purchase_count DESC
LIMIT 3;

-- Result:
-- 1. Google Clear Pen 4-Pack
-- 2. Google Laptop and Cell Phone Stickers
-- 3. Google Metallic Notebook Set
