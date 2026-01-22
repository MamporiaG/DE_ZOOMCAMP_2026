#!/usr/bin/env python
# coding: utf-8

import pandas as pd
from sqlalchemy import create_engine
from tqdm.auto import tqdm

PG_USER = "root"
PG_PASSWORD = "root"
PG_HOST = "localhost"
PG_PORT = 5434
PG_DB = "ny_taxi"

engine = create_engine(
    f"postgresql://{PG_USER}:{PG_PASSWORD}@{PG_HOST}:{PG_PORT}/{PG_DB}"
)

green_url = (
    "https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2025-11.parquet"
)
df_green = pd.read_parquet(green_url)

df_green.to_sql("green_taxi_trips", con=engine, if_exists="replace", index=False)
print(f"Green taxi trips ingested: {len(df_green)} rows")

zones_url = "https://github.com/DataTalksClub/nyc-tlc-data/releases/download/misc/taxi_zone_lookup.csv"
df_zones = pd.read_csv(zones_url)

df_zones.to_sql("zones", con=engine, if_exists="replace", index=False)
print(f"Taxi zones ingested: {len(df_zones)} rows")

print("✅ Data ingestion complete!")
