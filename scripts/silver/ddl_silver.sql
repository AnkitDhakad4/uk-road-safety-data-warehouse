
-- SILVER LAYER: cleaned, typed tables

-- 1. Collisions (Accidents)
CREATE TABLE silver.accidents (
    collision_index                             NVARCHAR(20)  PRIMARY KEY,
    collision_year                              INT           NULL,
    collision_ref_no                            NVARCHAR(20)  NULL,
    location_easting_osgr                       INT           NULL,
    location_northing_osgr                      INT           NULL,
    longitude                                   FLOAT         NULL,
    latitude                                    FLOAT         NULL,
    police_force                                NVARCHAR(50)  NULL,
    collision_severity                          NVARCHAR(20)  NULL,  -- decoded: Fatal/Serious/Slight
    number_of_vehicles                          INT           NULL,
    number_of_casualties                        INT           NULL,
    collision_date                              DATE          NULL,
    day_of_week                                 NVARCHAR(15)  NULL,
    collision_time                              TIME          NULL,
    local_authority_district                    NVARCHAR(50)  NULL,
    local_authority_ons_district                NVARCHAR(50)  NULL,
    local_authority_highway                     NVARCHAR(50)  NULL,
    local_authority_highway_current             NVARCHAR(50)  NULL,
    first_road_class                            NVARCHAR(50)  NULL,
    first_road_number                           NVARCHAR(20)  NULL,
    road_type                                   NVARCHAR(50)  NULL,
    speed_limit                                 INT           NULL,
    junction_detail_historic                    NVARCHAR(50)  NULL,
    junction_detail                             NVARCHAR(50)  NULL,
    junction_control                            NVARCHAR(50)  NULL,
    second_road_class                           NVARCHAR(50)  NULL,
    second_road_number                          NVARCHAR(20)  NULL,
    pedestrian_crossing_human_control_historic  NVARCHAR(50)  NULL,
    pedestrian_crossing_physical_facilities_historic NVARCHAR(50) NULL,
    pedestrian_crossing                         NVARCHAR(50)  NULL,
    light_conditions                            NVARCHAR(50)  NULL,
    weather_conditions                          NVARCHAR(50)  NULL,
    road_surface_conditions                     NVARCHAR(50)  NULL,
    special_conditions_at_site                  NVARCHAR(50)  NULL,
    carriageway_hazards_historic                NVARCHAR(50)  NULL,
    carriageway_hazards                         NVARCHAR(50)  NULL,
    urban_or_rural_area                         NVARCHAR(10)  NULL,
    did_police_officer_attend_scene_of_accident NVARCHAR(10)  NULL,
    trunk_road_flag                             NVARCHAR(10)  NULL,
    lsoa_of_accident_location                   NVARCHAR(20)  NULL,
    enhanced_severity_collision                 NVARCHAR(30)  NULL,
    collision_injury_based                      NVARCHAR(30)  NULL,
    collision_adjusted_severity_serious          FLOAT         NULL,
    collision_adjusted_severity_slight           FLOAT         NULL,
    load_dt                                     DATETIME      DEFAULT GETDATE()
);
GO

-- 2. Vehicles
CREATE TABLE silver.vehicles (
    collision_index                            NVARCHAR(20)  NULL,   -- FK to silver.accidents
    collision_year                             INT           NULL,
    collision_ref_no                           NVARCHAR(20)  NULL,
    vehicle_reference                          INT           NULL,
    vehicle_type                               NVARCHAR(50)  NULL,
    towing_and_articulation                    NVARCHAR(50)  NULL,
    vehicle_manoeuvre_historic                 NVARCHAR(50)  NULL,
    vehicle_manoeuvre                          NVARCHAR(50)  NULL,
    vehicle_direction_from                     NVARCHAR(20)  NULL,
    vehicle_direction_to                       NVARCHAR(20)  NULL,
    vehicle_location_restricted_lane_historic  NVARCHAR(50)  NULL,
    vehicle_location_restricted_lane           NVARCHAR(50)  NULL,
    junction_location                          NVARCHAR(50)  NULL,
    skidding_and_overturning                   NVARCHAR(50)  NULL,
    hit_object_in_carriageway                  NVARCHAR(50)  NULL,
    vehicle_leaving_carriageway                NVARCHAR(50)  NULL,
    hit_object_off_carriageway                 NVARCHAR(50)  NULL,
    first_point_of_impact                      NVARCHAR(50)  NULL,
    vehicle_left_hand_drive                    NVARCHAR(10)  NULL,
    journey_purpose_of_driver_historic         NVARCHAR(50)  NULL,
    journey_purpose_of_driver                  NVARCHAR(50)  NULL,
    sex_of_driver                              NVARCHAR(10)  NULL,
    age_of_driver                              INT           NULL,
    age_band_of_driver                         NVARCHAR(20)  NULL,
    engine_capacity_cc                         INT           NULL,
    propulsion_code                            NVARCHAR(50)  NULL,
    age_of_vehicle                             INT           NULL,
    generic_make_model                         NVARCHAR(100) NULL,
    driver_imd_decile                          INT           NULL,
    lsoa_of_driver                             NVARCHAR(20)  NULL,
    escooter_flag                              NVARCHAR(10)  NULL,
    driver_distance_banding                    NVARCHAR(50)  NULL,
    load_dt                                    DATETIME      DEFAULT GETDATE()
);
GO

-- 3. Casualties
CREATE TABLE silver.casualties (
    collision_index                        NVARCHAR(20)  NULL,   -- FK to silver.accidents
    collision_year                         INT           NULL,
    collision_ref_no                       NVARCHAR(20)  NULL,
    vehicle_reference                      INT           NULL,
    casualty_reference                     INT           NULL,
    casualty_class                         NVARCHAR(30)  NULL,
    sex_of_casualty                        NVARCHAR(10)  NULL,
    age_of_casualty                        INT           NULL,
    age_band_of_casualty                   NVARCHAR(20)  NULL,
    casualty_severity                      NVARCHAR(20)  NULL,   -- decoded: Fatal/Serious/Slight
    pedestrian_location                    NVARCHAR(50)  NULL,
    pedestrian_movement                    NVARCHAR(50)  NULL,
    car_passenger                          NVARCHAR(50)  NULL,
    bus_or_coach_passenger                 NVARCHAR(50)  NULL,
    pedestrian_road_maintenance_worker     NVARCHAR(50)  NULL,
    casualty_type                          NVARCHAR(50)  NULL,
    casualty_imd_decile                    INT           NULL,
    lsoa_of_casualty                       NVARCHAR(20)  NULL,
    enhanced_casualty_severity              NVARCHAR(30)  NULL,
    casualty_injury_based                   NVARCHAR(30)  NULL,
    casualty_adjusted_severity_serious      FLOAT         NULL,
    casualty_adjusted_severity_slight       FLOAT         NULL,
    casualty_distance_banding               NVARCHAR(50)  NULL,
    load_dt                                DATETIME      DEFAULT GETDATE()
);
GO