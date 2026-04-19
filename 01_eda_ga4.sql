-- =====================================================
-- GA4 E-commerce Dataset - Exploratory Data Analysis
-- =====================================================

-- Dataset:
-- bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*
-- Tool: Google BigQuery

-- =====================================================
-- 1. Data Overview
-- =====================================================

SELECT *
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20201101`
LIMIT 1000;

-- Basic columns exploration

SELECT
  event_date,
  event_name,
  user_pseudo_id,
  user_first_touch_timestamp
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
LIMIT 1000;

-- =====================================================
-- 2. Device Analysis
-- =====================================================

SELECT
  device.category,
  device.operating_system,
  device.web_info.browser
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
LIMIT 1000;

-- =====================================================
-- 3. Geographic Analysis
-- =====================================================

SELECT
  geo.continent,
  geo.country,
  geo.region,
  geo.city
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
LIMIT 1000;

-- =====================================================
-- 4. Traffic Source Analysis
-- =====================================================

SELECT
  traffic_source.name,
  traffic_source.source
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
LIMIT 1000;

-- =====================================================
-- 5. Platform & Stream
-- =====================================================

SELECT
  platform,
  stream_id
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
LIMIT 1000;

-- Note:
-- stream_id is not used in current analysis (mainly relevant for multi-stream setups)

-- =====================================================
-- 6. Ecommerce Data Exploration
-- =====================================================

SELECT
  ecommerce.total_item_quantity,
  ecommerce.purchase_revenue_in_usd,
  ecommerce.transaction_id
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE
  ecommerce.total_item_quantity IS NOT NULL
  AND ecommerce.purchase_revenue_in_usd IS NOT NULL;

-- =====================================================
-- 7. Items (Nested Data)
-- =====================================================

-- Initial inspection (first item only)
SELECT
  items[SAFE_OFFSET(0)].item_id,
  items[SAFE_OFFSET(0)].item_name,
  items[SAFE_OFFSET(0)].item_category,
  items[SAFE_OFFSET(0)].price,
  items[SAFE_OFFSET(0)].quantity
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE items[SAFE_OFFSET(0)].item_id IS NOT NULL;

-- Recommended approach using UNNEST

SELECT
  item.item_id,
  item.item_name,
  item.item_category,
  item.price,
  item.quantity
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
UNNEST(items) AS item
WHERE item.item_id IS NOT NULL
LIMIT 1000;

-- =====================================================
-- 8. Data Quality Checks (Null Analysis)
-- =====================================================

-- Total records with items

SELECT COUNT(*) AS total_items
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE items[SAFE_OFFSET(0)].item_id IS NOT NULL;

-- Items with quantity

SELECT COUNT(*) AS items_with_quantity
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE
  items[SAFE_OFFSET(0)].item_id IS NOT NULL
  AND items[SAFE_OFFSET(0)].quantity IS NOT NULL;

-- Missing quantity (using UNNEST - accurate)

SELECT
  COUNT(*) AS items_without_quantity
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
UNNEST(items) AS item
WHERE
  event_name = 'purchase'
  AND item.item_id IS NOT NULL
  AND item.quantity IS NULL;

-- Items with quantity (accurate)

SELECT
  COUNT(*) AS items_with_quantity
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
UNNEST(items) AS item
WHERE
  event_name = 'purchase'
  AND item.item_id IS NOT NULL
  AND item.quantity IS NOT NULL;

-- =====================================================
-- 9. User Lifetime Value (LTV)
-- =====================================================

SELECT
  user_ltv.revenue,
  user_ltv.currency,
  ecommerce.total_item_quantity,
  ecommerce.purchase_revenue_in_usd
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE user_ltv.revenue != 0.0;

-- Note:
-- user_ltv is a nested field and may contain null or incomplete values.
-- It is not used in the core analysis.

-- =====================================================
-- End of EDA
-- =====================================================
