-- Determine dropoffs by device categories (desktop, mobile, tablet)
WITH base AS (
  SELECT
    user_pseudo_id,
    device.category AS device_category,
    event_name,
    event_timestamp
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE event_name IN ('view_item', 'add_to_cart', 'begin_checkout', 'purchase')
),

view_step AS (
  SELECT
    user_pseudo_id,
    device_category,
    MIN(event_timestamp) AS view_ts
  FROM base
  WHERE event_name = 'view_item'
  GROUP BY user_pseudo_id, device_category
),

cart_step AS (
  SELECT
    b.user_pseudo_id,
    b.device_category,
    MIN(b.event_timestamp) AS cart_ts
  FROM base b
  JOIN view_step v
    ON b.user_pseudo_id = v.user_pseudo_id
   AND b.device_category = v.device_category
  WHERE b.event_name = 'add_to_cart'
    AND b.event_timestamp > v.view_ts
  GROUP BY b.user_pseudo_id, b.device_category
),

checkout_step AS (
  SELECT
    b.user_pseudo_id,
    b.device_category,
    MIN(b.event_timestamp) AS checkout_ts
  FROM base b
  JOIN cart_step c
    ON b.user_pseudo_id = c.user_pseudo_id
   AND b.device_category = c.device_category
  WHERE b.event_name = 'begin_checkout'
    AND b.event_timestamp > c.cart_ts
  GROUP BY b.user_pseudo_id, b.device_category
),

purchase_step AS (
  SELECT
    b.user_pseudo_id,
    b.device_category,
    MIN(b.event_timestamp) AS purchase_ts
  FROM base b
  JOIN checkout_step ch
    ON b.user_pseudo_id = ch.user_pseudo_id
   AND b.device_category = ch.device_category
  WHERE b.event_name = 'purchase'
    AND b.event_timestamp > ch.checkout_ts
  GROUP BY b.user_pseudo_id, b.device_category
)

SELECT
  v.device_category,
  COUNT(*) AS viewed,
  COUNT(c.user_pseudo_id) AS added_to_cart,
  COUNT(ch.user_pseudo_id) AS began_checkout,
  COUNT(p.user_pseudo_id) AS purchased
FROM view_step v
LEFT JOIN cart_step c
  ON v.user_pseudo_id = c.user_pseudo_id
 AND v.device_category = c.device_category
LEFT JOIN checkout_step ch
  ON v.user_pseudo_id = ch.user_pseudo_id
 AND v.device_category = ch.device_category
LEFT JOIN purchase_step p
  ON v.user_pseudo_id = p.user_pseudo_id
 AND v.device_category = p.device_category
GROUP BY v.device_category
ORDER BY viewed DESC;

-- Result:
--Row	device_category	viewed	added_to_cart	began_checkout	purchased
-- 1	desktop	36323	7077	2846	1613
-- 2	mobile	24810	4953	2004	1176
-- 3	tablet	1443	263	105	62
