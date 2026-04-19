-- =====================================================
-- GA4 E-commerce Analysis
-- Funnel & Performance Analysis
-- =====================================================

-- =====================================================
-- 1. Events Exploration
-- =====================================================

SELECT DISTINCT event_name
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`;

-- =====================================================
-- 2. Funnel Analysis (User-Level)
-- =====================================================

WITH funnel AS (
  SELECT
    user_pseudo_id,

    MAX(CASE WHEN event_name = 'view_item' THEN 1 ELSE 0 END) AS viewed,
    MAX(CASE WHEN event_name = 'add_to_cart' THEN 1 ELSE 0 END) AS added,
    MAX(CASE WHEN event_name = 'purchase' THEN 1 ELSE 0 END) AS purchased

  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  GROUP BY user_pseudo_id
)

SELECT
  COUNT(*) AS total_users,
  SUM(viewed) AS viewed_users,
  SUM(added) AS added_users,
  SUM(purchased) AS purchased_users
FROM funnel;

-- =====================================================
-- 3. Conversion Rates
-- =====================================================

WITH funnel AS (
  SELECT
    user_pseudo_id,

    MAX(CASE WHEN event_name = 'view_item' THEN 1 ELSE 0 END) AS viewed,
    MAX(CASE WHEN event_name = 'add_to_cart' THEN 1 ELSE 0 END) AS added,
    MAX(CASE WHEN event_name = 'purchase' THEN 1 ELSE 0 END) AS purchased

  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  GROUP BY user_pseudo_id
)

SELECT
  ROUND(SAFE_DIVIDE(SUM(added), SUM(viewed)), 2) AS view_to_cart_rate,
  ROUND(SAFE_DIVIDE(SUM(purchased), SUM(added)), 2) AS cart_to_purchase_rate
FROM funnel;

-- =====================================================
-- 4. Funnel by Traffic Source
-- =====================================================

WITH funnel AS (
  SELECT
    user_pseudo_id,
    traffic_source.source AS source,

    MAX(CASE WHEN event_name = 'view_item' THEN 1 ELSE 0 END) AS viewed,
    MAX(CASE WHEN event_name = 'add_to_cart' THEN 1 ELSE 0 END) AS added,
    MAX(CASE WHEN event_name = 'purchase' THEN 1 ELSE 0 END) AS purchased

  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  GROUP BY user_pseudo_id, source
)

SELECT
  source,
  COUNT(*) AS users,
  SUM(viewed) AS viewed,
  SUM(added) AS added,
  SUM(purchased) AS purchased,

  SAFE_DIVIDE(SUM(added), SUM(viewed)) AS view_to_cart_rate,
  SAFE_DIVIDE(SUM(purchased), SUM(added)) AS cart_to_purchase_rate

FROM funnel
GROUP BY source
ORDER BY users DESC;

-- =====================================================
-- 5. Funnel by Country
-- =====================================================

WITH funnel AS (
  SELECT
    user_pseudo_id,
    geo.country AS country,

    MAX(CASE WHEN event_name = 'view_item' THEN 1 ELSE 0 END) AS viewed,
    MAX(CASE WHEN event_name = 'add_to_cart' THEN 1 ELSE 0 END) AS added,
    MAX(CASE WHEN event_name = 'purchase' THEN 1 ELSE 0 END) AS purchased

  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  GROUP BY user_pseudo_id, country
)

SELECT
  country,
  COUNT(*) AS users,
  SUM(viewed) AS viewed,
  SUM(added) AS added,
  SUM(purchased) AS purchased,

  SAFE_DIVIDE(SUM(added), SUM(viewed)) AS view_to_cart_rate,
  SAFE_DIVIDE(SUM(purchased), SUM(added)) AS cart_to_purchase_rate

FROM funnel
GROUP BY country
ORDER BY users DESC
LIMIT 10;

-- =====================================================
-- End of Analysis
-- =====================================================
