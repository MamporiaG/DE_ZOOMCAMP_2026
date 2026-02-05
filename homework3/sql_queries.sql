
CREATE OR REPLACE EXTERNAL TABLE `zoomcamp-485619.zoomcamp.homework3_table`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://zoomcamp-kestra-bucket-unique-id/homework3/*.parquet']
);

SELECT count(*) FROM `zoomcamp-485619.zoomcamp.homework3_table`; -- 20,332,093

SELECT COUNT(DISTINCT PULocationID)
FROM `zoomcamp-485619.zoomcamp.homework3_table`;


SELECT COUNT(DISTINCT PULocationID)
FROM `zoomcamp-485619.zoomcamp.homework3_non_partitioned`;
 -- 0 MB for the External Table and 155.12 MB for the Materialized Table

SELECT PULocationID
FROM `zoomcamp-485619.zoomcamp.homework3_non_partitioned`;


SELECT PULocationID, DULocationID
FROM `zoomcamp-485619.zoomcamp.homework3_non_partitioned`;

-- BigQuery is a columnar database, and it only scans the specific columns requested in the query. 
-- Querying two columns (PULocationID, DOLocationID) requires reading more data than querying one column (PULocationID), 
-- leading to a higher estimated number of bytes processed.

SELECT COUNT(fare_amount)
FROM `zoomcamp-485619.zoomcamp.homework3_table`
WHERE fare_amount = 0; -- 8333

-- Partition by tpep_dropoff_datetime and Cluster on VendorID

CREATE OR REPLACE TABLE `zoomcamp-485619.zoomcamp.homework3_partitioned_clustered`
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID
AS
SELECT * FROM `zoomcamp-485619.zoomcamp.homework3_partitioned_clustered`;

SELECT DISTINCT VendorID
FROM `zoomcamp-485619.zoomcamp.homework3_table`
WHERE DATE(tpep_dropoff_datetime) BETWEEN '2024-03-01' AND '2024-03-15';


SELECT DISTINCT VendorID
FROM `zoomcamp-485619.zoomcamp.homework3_partitioned_clustered`
WHERE DATE(tpep_dropoff_datetime) BETWEEN '2024-03-01' AND '2024-03-15';

-- 310.24 MB for non-partitioned table and 26.84 MB for the partitioned table
-- GCP Bucket

-- It is best practice in Big Query to always cluster your data: False








