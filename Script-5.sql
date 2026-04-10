SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'afisha';

SELECT column_name, data_type 
FROM information_schema.COLUMNS
WHERE table_schema ='afisha'
	AND table_name='purchases';

SELECT column_name, data_type 
FROM information_schema.COLUMNS
WHERE table_schema ='afisha'
	AND table_name='events';

SELECT column_name, data_type 
FROM information_schema.COLUMNS
WHERE table_schema ='afisha'
	AND table_name='venues';

SELECT column_name, data_type 
FROM information_schema.COLUMNS
WHERE table_schema ='afisha'
	AND table_name='city';

SELECT column_name, data_type 
FROM information_schema.COLUMNS
WHERE table_schema ='afisha'
	AND table_name='regions';

SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_ids
FROM afisha.purchases;

SELECT 
	COUNT(*) AS total_rows,
	count(DISTINCT event_id) AS unique_ids
FROM afisha.events;

SELECT 
	count(*) AS total_rows,
	count(DISTINCT venue_id) AS unique_ids
FROM afisha.venues;

SELECT 
	count(*) AS total_rows,
	count(DISTINCT city_id) AS unique_ids
FROM afisha.city;

SELECT 
	count(*) AS total_rows,
	count(DISTINCT region_id) AS unique_ids
FROM afisha.regions;

SELECT 'purchases' AS TABLE, count(*) FROM afisha.purchases
UNION ALL 
SELECT 'events' AS TABLE, count(*) FROM afisha.events 
UNION ALL 
SELECT 'venues' AS TABLE, count(*) FROM afisha.venues 
UNION ALL 
SELECT 'city' AS TABLE, count(*) FROM afisha.city 
UNION ALL 
SELECT 'regions' AS TABLE, count(*) FROM afisha.regions;

SELECT count(order_id),
	count(DISTINCT order_id)
FROM afisha.purchases;

SELECT count(event_id),
	count(DISTINCT event_id)
FROM afisha.events;

SELECT count(venue_id),
	count(DISTINCT venue_id)
FROM afisha.venues;

SELECT count(city_id),
	count(DISTINCT city_id)
FROM afisha.city;

SELECT count(region_id),
	count(DISTINCT region_id)
FROM afisha.regions;

SELECT 
	count(*) FILTER (WHERE user_id IS NULL) AS null_user_id,
	count(*) FILTER (WHERE event_id IS null) AS null_event_id,
	count(*) FILTER (WHERE revenue IS NULL) AS null_revenue
FROM afisha.purchases;

SELECT
	count(*) FILTER (WHERE event_id IS NULL ) AS null_event_id,
	count(*) FILTER (WHERE city_id IS NULL ) AS null_city_id,
	count(*) FILTER (WHERE venue_id IS null) AS null_venue_id
FROM afisha.events;

SELECT 
	count(*) FILTER (WHERE region_id IS null) AS null_region_id
FROM afisha.city;

SELECT device_type_canonical,
	count(*) AS orders,
	round(100.0 * count(*)/sum(count(*)) OVER(), 2) AS PERCENT
FROM afisha.purchases
GROUP BY device_type_canonical 
ORDER BY orders DESC;

SELECT currency_code, count(*)
FROM afisha.purchases 
GROUP BY currency_code;

SELECT event_type_main,
	count(*) AS events_count
FROM afisha.events
GROUP BY event_type_main
ORDER BY events_count DESC;

SELECT e.event_type_main,
	count(p.order_id) AS orders
FROM afisha.purchases p 
JOIN afisha.events e 
	ON p.event_id =e.event_id 
GROUP BY e.event_type_main 
ORDER BY orders DESC;

SELECT min(revenue),
max(revenue),
avg(revenue),
percentile_cont(0.5) WITHIN GROUP (ORDER BY revenue) AS median
FROM afisha.purchases;

SELECT *
FROM afisha.purchases
ORDER BY revenue DESC 
LIMIT 20;

SELECT min(created_dt_msk),
max(created_dt_msk)
FROM afisha.purchases;

SELECT
    DATE_TRUNC('month', created_dt_msk) AS month,
    COUNT(*) AS orders,
    SUM(revenue) AS total_revenue
FROM afisha.purchases
GROUP BY month
ORDER BY month;

SELECT age_limit, COUNT(*)
FROM afisha.purchases
GROUP BY age_limit
ORDER BY age_limit;

SELECT
    MIN(tickets_count),
    MAX(tickets_count),
    AVG(tickets_count)
FROM afisha.purchases;

SELECT count(order_id), count(DISTINCT user_id)
FROM afisha.purchases;

SELECT count(event_id),
count(event_name_code)
FROM afisha.events;

SELECT count(city_id)
FROM afisha.city;

SELECT count(region_id)
FROM afisha.regions;