-- Sequential user-level funnel drop-off. When do users stop purchasing?
WITH base AS (
  SELECT
    user_pseudo_id,
    event_name,
    event_timestamp
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE event_name IN ('view_item', 'add_to_cart', 'begin_checkout', 'purchase')
),

view_step AS (
  SELECT
    user_pseudo_id,
    MIN(event_timestamp) AS view_ts
  FROM base
  WHERE event_name = 'view_item'
  GROUP BY user_pseudo_id
),

cart_step AS (
  SELECT
    b.user_pseudo_id,
    MIN(b.event_timestamp) AS cart_ts
  FROM base b
  JOIN view_step v
    ON b.user_pseudo_id = v.user_pseudo_id
  WHERE b.event_name = 'add_to_cart'
    AND b.event_timestamp > v.view_ts
  GROUP BY b.user_pseudo_id
),

checkout_step AS (
  SELECT
    b.user_pseudo_id,
    MIN(b.event_timestamp) AS checkout_ts
  FROM base b
  JOIN cart_step c
    ON b.user_pseudo_id = c.user_pseudo_id
  WHERE b.event_name = 'begin_checkout'
    AND b.event_timestamp > c.cart_ts
  GROUP BY b.user_pseudo_id
),

purchase_step AS (
  SELECT
    b.user_pseudo_id,
    MIN(b.event_timestamp) AS purchase_ts
  FROM base b
  JOIN checkout_step AS ch
    ON b.user_pseudo_id = ch.user_pseudo_id
  WHERE b.event_name = 'purchase'
    AND b.event_timestamp > ch.checkout_ts
  GROUP BY b.user_pseudo_id
)

SELECT
  (SELECT COUNT(*) FROM view_step) AS viewed,
  (SELECT COUNT(*) FROM cart_step) AS added_to_cart,
  (SELECT COUNT(*) FROM checkout_step) AS began_checkout,
  (SELECT COUNT(*) FROM purchase_step) AS purchased

-- Result
-- viewed: 61,252
-- added_to_cart: 12,052
-- began_checkout: 4,909
-- purchased: 2,833

