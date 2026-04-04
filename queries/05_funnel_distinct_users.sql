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

WITH funnel AS (
  SELECT
    event_name,
    COUNT(DISTINCT user_pseudo_id) AS users
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE event_name IN ('view_item', 'add_to_cart', 'begin_checkout', 'purchase')
  GROUP BY event_name
)

SELECT
  MAX(CASE WHEN event_name = 'view_item' THEN users END) AS view_item,
  MAX(CASE WHEN event_name = 'add_to_cart' THEN users END) AS add_to_cart,
  MAX(CASE WHEN event_name = 'begin_checkout' THEN users END) AS begin_checkout,
  MAX(CASE WHEN event_name = 'purchase' THEN users END) AS purchase,

  ROUND(
    MAX(CASE WHEN event_name = 'add_to_cart' THEN users END) * 100.0 /
    MAX(CASE WHEN event_name = 'view_item' THEN users END),
    2
  ) AS view_to_cart_pct,

  ROUND(
    MAX(CASE WHEN event_name = 'begin_checkout' THEN users END) * 100.0 /
    MAX(CASE WHEN event_name = 'add_to_cart' THEN users END),
    2
  ) AS cart_to_checkout_pct,

  ROUND(
    MAX(CASE WHEN event_name = 'purchase' THEN users END) * 100.0 /
    MAX(CASE WHEN event_name = 'begin_checkout' THEN users END),
    2
  ) AS checkout_to_purchase_pct,

  ROUND(
    MAX(CASE WHEN event_name = 'purchase' THEN users END) * 100.0 /
    MAX(CASE WHEN event_name = 'view_item' THEN users END),
    2
  ) AS view_to_purchase_pct
FROM funnel;


