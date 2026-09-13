-- ===================================================
-- BRONZE LAYER: raw, untyped, permissive tables
-- All columns VARCHAR(50) as imported — no cleaning here
-- ===================================================

-- 1. Accidents / Collisions
CREATE TABLE bronze.accidents (
    accident_index                              VARCHAR(50),
    accident_year                               VARCHAR(50),
    accident_reference                          VARCHAR(50),
    location_easting_osgr                       VARCHAR(50),
    location_northing_osgr                      VARCHAR(50),
    longitude                                   VARCHAR(50),
    latitude                                    VARCHAR(50),
    police_force                                VARCHAR(50),
    accident_severity                           VARCHAR(50),
    number_of_vehicles                          VARCHAR(50),
    number_of_casualties                        VARCHAR(50),
    date                                        VARCHAR(50),
    day_of_week                                 VARCHAR(50),
    time                                        VARCHAR(50),
    local_authority_district                    VARCHAR(50),
    local_authority_ons_district                VARCHAR(50),
    local_authority_highway                     VARCHAR(50),
    first_road_class                            VARCHAR(50),
    first_road_number                           VARCHAR(50),
    road_type                                   VARCHAR(50),
    speed_limit                                 VARCHAR(50),
    junction_detail                             VARCHAR(50),
    junction_control                            VARCHAR(50),
    second_road_class                           VARCHAR(50),
    second_road_number                          VARCHAR(50),
    pedestrian_crossing_human_control           VARCHAR(50),
    pedestrian_crossing_physical_facilities     VARCHAR(50),
    light_conditions                            VARCHAR(50),
    weather_conditions                          VARCHAR(50),
    road_surface_conditions                     VARCHAR(50),
    special_conditions_at_site                  VARCHAR(50),
    carriageway_hazards                         VARCHAR(50),
    urban_or_rural_area                         VARCHAR(50),
    did_police_officer_attend_scene_of_accident VARCHAR(50),
    trunk_road_flag                             VARCHAR(50),
    lsoa_of_accident_location                   VARCHAR(50)
);
GO

-- 2. Vehicles
CREATE TABLE bronze.vehicles (
    accident_index                    VARCHAR(50),
    accident_year                     VARCHAR(50),
    accident_reference                VARCHAR(50),
    vehicle_reference                 VARCHAR(50),
    vehicle_type                      VARCHAR(50),
    towing_and_articulation           VARCHAR(50),
    vehicle_manoeuvre                 VARCHAR(50),
    vehicle_direction_from            VARCHAR(50),
    vehicle_direction_to              VARCHAR(50),
    vehicle_location_restricted_lane  VARCHAR(50),
    junction_location                 VARCHAR(50),
    skidding_and_overturning          VARCHAR(50),
    hit_object_in_carriageway         VARCHAR(50),
    vehicle_leaving_carriageway       VARCHAR(50),
    hit_object_off_carriageway        VARCHAR(50),
    first_point_of_impact             VARCHAR(50),
    vehicle_left_hand_drive           VARCHAR(50),
    journey_purpose_of_driver         VARCHAR(50),
    sex_of_driver                     VARCHAR(50),
    age_of_driver                     VARCHAR(50),
    age_band_of_driver                VARCHAR(50),
    engine_capacity_cc                VARCHAR(50),
    propulsion_code                   VARCHAR(50),
    age_of_vehicle                    VARCHAR(50),
    generic_make_model                VARCHAR(50),
    driver_imd_decile                 VARCHAR(50),
    driver_home_area_type             VARCHAR(50),
    lsoa_of_driver                    VARCHAR(50)
);
GO

-- 3. Casualties
CREATE TABLE bronze.casualties (
    accident_index                          VARCHAR(50),
    accident_year                           VARCHAR(50),
    accident_reference                      VARCHAR(50),
    vehicle_reference                       VARCHAR(50),
    casualty_reference                      VARCHAR(50),
    casualty_class                          VARCHAR(50),
    sex_of_casualty                         VARCHAR(50),
    age_of_casualty                         VARCHAR(50),
    age_band_of_casualty                    VARCHAR(50),
    casualty_severity                       VARCHAR(50),
    pedestrian_location                     VARCHAR(50),
    pedestrian_movement                     VARCHAR(50),
    car_passenger                           VARCHAR(50),
    bus_or_coach_passenger                  VARCHAR(50),
    pedestrian_road_maintenance_worker      VARCHAR(50),
    casualty_type                           VARCHAR(50),
    casualty_home_area_type                 VARCHAR(50),
    casualty_imd_decile                     VARCHAR(50),
    lsoa_of_casualty                        VARCHAR(50)
);
GO