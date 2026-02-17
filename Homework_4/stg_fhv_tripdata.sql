
with source as (
    select * from {{ source('raw', 'fhv_tripdata') }}
),

renamed as (
    select
        -- Identifiers
        dispatching_base_num,
        Affiliated_base_number as affiliated_base_number,
        
        -- Timestamps
        pickup_datetime,
        dropOff_datetime as dropoff_datetime,
        
        -- Location IDs (rename to match project conventions)
        PUlocationID as pickup_location_id,
        DOlocationID as dropoff_location_id,
        
        -- Shared ride flag
        SR_Flag as shared_ride_flag
        
    from source
    where dispatching_base_num is not null
)

select * from renamed
