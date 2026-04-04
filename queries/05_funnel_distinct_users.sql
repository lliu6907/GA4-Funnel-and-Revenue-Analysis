-- Funnel drop-off. When do users stop purchasing?
SELECT
 event_name,
 COUNT(DISTINCT(user_pseudo_id)) AS event
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE event_name IN ('view_item', 'add_to_cart', 'begin_checkout', 'purchase')
GROUP BY event_name;

-- Result
-- view_item: 61,252
-- add_to_cart: 12,545
-- begin_checkout: 9,715
-- purchase: 4,419

