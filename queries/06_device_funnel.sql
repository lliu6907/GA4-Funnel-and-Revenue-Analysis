-- Determine dropoffs by device categories (desktop, mobile, tablet)
SELECT
 COUNT(DISTINCT(user_pseudo_id)) AS users,
 device.category,
 event_name
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE event_name IN ('view_item', 'add_to_cart', 'begin_checkout', 'purchase')
GROUP BY device.category, event_name
ORDER BY
 device.category,
 CASE
   WHEN event_name = 'view_item' THEN 1
   WHEN event_name = 'add_to_cart' THEN 2
   WHEN event_name = 'begin_checkout' THEN 3
   WHEN event_name = 'purchase' THEN 4
 END;

-- Result:
-- users	category	event_name
-- 36323	desktop	view_item
-- 2541	desktop	purchase
-- 5665	desktop	begin_checkout
-- 7384	desktop	add_to_cart
-- 24810	mobile	view_item
-- 3968	mobile	begin_checkout
-- 5142	mobile	add_to_cart
-- 1851	mobile	purchase
-- 1443	tablet	view_item
-- 97	tablet	purchase
-- 219	tablet	begin_checkout
-- 276	tablet	add_to_cart
