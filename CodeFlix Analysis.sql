-- Get Familiar with the Data
-- 1. View the first 5 rows & identify segments
SELECT * 
FROM subscriptions 
LIMIT 5;

-- To find how many distinct segments exist:
SELECT DISTINCT segment 
FROM subscriptions;

--  2. Determine the range of months
SELECT 
  MIN(subscription_start) AS earliest_subscription,
  MAX(subscription_start) AS latest_subscription
FROM subscriptions;
-- To identify which months are safe to calculate churn, remember that churn requires looking at subscriptions that end, so only consider months where subscription_end values are present.

-- Churn Rate Calculations
-- We'll focus on Jan, Feb, and Mar 2017.

 -- 3. Create temporary table for the months
WITH months AS (
  SELECT '2017-01-01' AS first_day, '2017-01-31' AS last_day
  UNION
  SELECT '2017-02-01', '2017-02-28'
  UNION
  SELECT '2017-03-01', '2017-03-31'
),

cross_join AS (
  SELECT 
    s.id,
    s.subscription_start,
    s.subscription_end,
    s.segment,
    m.first_day,
    m.last_day
  FROM subscriptions s
  CROSS JOIN months m
),

status AS (
  SELECT 
    id,
    first_day AS month,

    -- is_active for segment 87
    CASE 
      WHEN segment = 87 
           AND subscription_start < first_day 
           AND (subscription_end > first_day OR subscription_end IS NULL)
      THEN 1 ELSE 0 
    END AS is_active_87,

    -- is_active for segment 30
    CASE 
      WHEN segment = 30 
           AND subscription_start < first_day 
           AND (subscription_end > first_day OR subscription_end IS NULL)
      THEN 1 ELSE 0 
    END AS is_active_30,

    -- is_canceled for segment 87
    CASE 
      WHEN segment = 87 
           AND subscription_end BETWEEN first_day AND last_day
      THEN 1 ELSE 0 
    END AS is_canceled_87,

    -- is_canceled for segment 30
    CASE 
      WHEN segment = 30 
           AND subscription_end BETWEEN first_day AND last_day
      THEN 1 ELSE 0 
    END AS is_canceled_30

  FROM cross_join
),

status_aggregate AS (
  SELECT 
    month,
    SUM(is_active_87) AS sum_active_87,
    SUM(is_active_30) AS sum_active_30,
    SUM(is_canceled_87) AS sum_canceled_87,
    SUM(is_canceled_30) AS sum_canceled_30
  FROM status
  GROUP BY month
)

SELECT 
  month,
  sum_active_87,
  sum_canceled_87,
  ROUND(sum_canceled_87 * 1.0 / NULLIF(sum_active_87, 0), 4) AS churn_rate_87,

  sum_active_30,
  sum_canceled_30,
  ROUND(sum_canceled_30 * 1.0 / NULLIF(sum_active_30, 0), 4) AS churn_rate_30
FROM status_aggregate;

