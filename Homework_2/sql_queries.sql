-- 3.	How many rows are there for the Yellow Taxi data for all CSV files in the year 2020?


SELECT COUNT(*) FROM `zoomcamp-485619.zoomcamp.yellow_tripdata` WHERE filename LIKE 'yellow_tripdata_2020%'


--4.	How many rows are there for the Green Taxi data for all CSV files in the year 2020?

SELECT COUNT(*) FROM `zoomcamp-485619.zoomcamp.green_tripdata` WHERE filename LIKE 'green_tripdata_2020%'

--5.	How many rows are there for the Yellow Taxi data for the March 2021 CSV file?

SELECT COUNT(*)
FROM `zoomcamp-485619.zoomcamp.yellow_tripdata_2021_03`
