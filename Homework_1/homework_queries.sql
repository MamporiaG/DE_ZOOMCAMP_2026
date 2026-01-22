--3.	For the trips in November 2025 (lpep_pickup_datetime between '2025-11-01' and '2025-12-01', exclusive of the upper bound), 
--      how many trips had a trip_distance of less than or equal to 1 mile? 7,853 8,007 8,254 8,421

SELECT COUNT(*) FROM green_taxi_trips 
WHERE lpep_pickup_datetime BETWEEN '2025-11-01' AND '2025-12-01'
AND trip_distance <= 1;

--4 Which was the pick up day with the longest trip distance? Only consider trips with trip_distance less than 100 miles (to exclude data errors). 
-- Use the pick up time for your calculations. 2025-11-14 2025-11-20 2025-11-23 2025-11-25
SELECT lpep_pickup_datetime FROM green_taxi_trips 
WHERE trip_distance < 100 
ORDER BY trip_distance DESC 
LIMIT 1;

--5 Which was the pickup zone with the largest total_amount (sum of all trips) on November 18th, 2025? (1 point)
SELECT
    zones."Zone",
    SUM(green_taxi_trips.total_amount) AS total_revenue
FROM
    green_taxi_trips
JOIN
    zones ON green_taxi_trips."PULocationID" = zones."LocationID"
WHERE
    green_taxi_trips.lpep_pickup_datetime >= '2025-11-18 00:00:00' 
    AND green_taxi_trips.lpep_pickup_datetime < '2025-11-19 00:00:00'
GROUP BY
    zones."Zone"
ORDER BY
    total_revenue DESC
LIMIT 1;

--6 For the passengers picked up in the zone named "East Harlem North" in November 2025, 
-- which was the drop off zone that had the largest tip? (1 point)

SELECT
    (SELECT "Zone" FROM zones WHERE "LocationID" = green_taxi_trips."DOLocationID") AS dropoff_zone_name,
    green_taxi_trips.tip_amount
FROM
    green_taxi_trips
WHERE
    (SELECT "Zone" FROM zones WHERE "LocationID" = green_taxi_trips."PULocationID") = 'East Harlem North'
    AND green_taxi_trips.lpep_pickup_datetime >= '2025-11-01' 
    AND green_taxi_trips.lpep_pickup_datetime < '2025-12-01'
ORDER BY
    green_taxi_trips.tip_amount DESC
LIMIT 1;