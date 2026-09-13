-- ===================================================
-- SILVER LAYER: clean, type-cast, and load from bronze
-- Every SELECT column has an inline alias matching its
-- Run ddl_silver.sql first to create the target tables
-- ===================================================

TRUNCATE TABLE silver.accidents;
TRUNCATE TABLE silver.vehicles;
TRUNCATE TABLE silver.casualties;
GO
SELECT * FROM Silver.accidents

-- 1. ACCIDENTS (collisions) accident_index

INSERT INTO silver.accidents (
    collision_index, collision_year, collision_ref_no,
    location_easting_osgr, location_northing_osgr, longitude, latitude,
    police_force, collision_severity, number_of_vehicles, number_of_casualties,
    collision_date, day_of_week, collision_time,
    local_authority_district, local_authority_ons_district,
    local_authority_highway, local_authority_highway_current,
    first_road_class, first_road_number, road_type, speed_limit,
    junction_detail_historic, junction_detail, junction_control,
    second_road_class, second_road_number,
    pedestrian_crossing_human_control_historic,
    pedestrian_crossing_physical_facilities_historic, pedestrian_crossing,
    light_conditions, weather_conditions, road_surface_conditions,
    special_conditions_at_site, carriageway_hazards_historic, carriageway_hazards,
    urban_or_rural_area, did_police_officer_attend_scene_of_accident,
    trunk_road_flag, lsoa_of_accident_location,
    enhanced_severity_collision, collision_injury_based,
    collision_adjusted_severity_serious, collision_adjusted_severity_slight
)
SELECT
    TRIM(collision_index)                                                    collision_index,
    TRY_CAST(collision_year AS INT)                                          collision_year,
    NULLIF(TRIM(collision_ref_no), '')                                       collision_ref_no,
    TRY_CAST(location_easting_osgr AS INT)                                   location_easting_osgr,
    TRY_CAST(location_northing_osgr AS INT)                                  location_northing_osgr,
    TRY_CAST(NULLIF(longitude, '') AS FLOAT)                                 longitude,
    TRY_CAST(NULLIF(latitude, '') AS FLOAT)                                  latitude,
    NULLIF(TRIM(police_force), '')                                           police_force,
    CASE TRY_CAST(collision_severity AS INT)
        WHEN 1 THEN 'Fatal'
        WHEN 2 THEN 'Serious'
        WHEN 3 THEN 'Slight'
        ELSE NULL
    END                                                                      collision_severity,
    NULLIF(TRY_CAST(number_of_vehicles AS INT), -1)                          number_of_vehicles,
    NULLIF(TRY_CAST(number_of_casualties AS INT), -1)                        number_of_casualties,
    TRY_CONVERT(DATE, [date], 103)                                           collision_date,
    NULLIF(TRIM(day_of_week), '')                                            day_of_week,
    TRY_CONVERT(TIME, [time])                                                collision_time,
    NULLIF(TRIM(local_authority_district), '')                               local_authority_district,
    NULLIF(TRIM(local_authority_ons_district), '')                           local_authority_ons_district,
    NULLIF(TRIM(local_authority_highway), '')                                local_authority_highway,
    NULLIF(TRIM(local_authority_highway_current), '')                        local_authority_highway_current,
    NULLIF(TRIM(first_road_class), '')                                       first_road_class,
    NULLIF(TRIM(first_road_number), '')                                      first_road_number,
    NULLIF(TRIM(road_type), '')                                              road_type,
    NULLIF(TRY_CAST(speed_limit AS INT), -1)                                 speed_limit,
    NULLIF(TRIM(junction_detail_historic), '')                               junction_detail_historic,
    NULLIF(TRIM(junction_detail), '')                                        junction_detail,
    NULLIF(TRIM(junction_control), '')                                       junction_control,
    NULLIF(TRIM(second_road_class), '')                                      second_road_class,
    NULLIF(TRIM(second_road_number), '')                                     second_road_number,
    NULLIF(TRIM(pedestrian_crossing_human_control_historic), '')             pedestrian_crossing_human_control_historic,
    NULLIF(TRIM(pedestrian_crossing_physical_facilities_historic), '')       pedestrian_crossing_physical_facilities_historic,
    NULLIF(TRIM(pedestrian_crossing), '')                                    pedestrian_crossing,
    NULLIF(TRIM(light_conditions), '')                                       light_conditions,
    NULLIF(TRIM(weather_conditions), '')                                     weather_conditions,
    NULLIF(TRIM(road_surface_conditions), '')                                road_surface_conditions,
    NULLIF(TRIM(special_conditions_at_site), '')                             special_conditions_at_site,
    NULLIF(TRIM(carriageway_hazards_historic), '')                           carriageway_hazards_historic,
    NULLIF(TRIM(carriageway_hazards), '')                                    carriageway_hazards,
    NULLIF(TRIM(urban_or_rural_area), '')                                    urban_or_rural_area,
    NULLIF(TRIM(did_police_officer_attend_scene_of_accident), '')            did_police_officer_attend_scene_of_accident,
    NULLIF(TRIM(trunk_road_flag), '')                                        trunk_road_flag,
    NULLIF(TRIM(lsoa_of_accident_location), '')                              lsoa_of_accident_location,
    NULLIF(TRIM(enhanced_severity_collision), '')                            enhanced_severity_collision,
    NULLIF(TRIM(collision_injury_based), '')                                 collision_injury_based,
    TRY_CAST(NULLIF(collision_adjusted_severity_serious, '') AS FLOAT)       collision_adjusted_severity_serious,
    TRY_CAST(NULLIF(collision_adjusted_severity_slight, '') AS FLOAT)        collision_adjusted_severity_slight
FROM bronze.accidents
WHERE collision_index IS NOT NULL
  AND TRIM(collision_index) <> '';
GO


-- 2. VEHICLES

INSERT INTO silver.vehicles (
    collision_index, collision_year, collision_ref_no, vehicle_reference,
    vehicle_type, towing_and_articulation,
    vehicle_manoeuvre_historic, vehicle_manoeuvre,
    vehicle_direction_from, vehicle_direction_to,
    vehicle_location_restricted_lane_historic, vehicle_location_restricted_lane,
    junction_location, skidding_and_overturning, hit_object_in_carriageway,
    vehicle_leaving_carriageway, hit_object_off_carriageway, first_point_of_impact,
    vehicle_left_hand_drive,
    journey_purpose_of_driver_historic, journey_purpose_of_driver,
    sex_of_driver, age_of_driver, age_band_of_driver,
    engine_capacity_cc, propulsion_code, age_of_vehicle, generic_make_model,
    driver_imd_decile, lsoa_of_driver, escooter_flag, driver_distance_banding
)
SELECT
    TRIM(collision_index)                                                    collision_index,
    TRY_CAST(collision_year AS INT)                                          collision_year,
    NULLIF(TRIM(collision_ref_no), '')                                       collision_ref_no,
    TRY_CAST(vehicle_reference AS INT)                                       vehicle_reference,
    NULLIF(TRIM(vehicle_type), '')                                           vehicle_type,
    NULLIF(TRIM(towing_and_articulation), '')                                towing_and_articulation,
    NULLIF(TRIM(vehicle_manoeuvre_historic), '')                             vehicle_manoeuvre_historic,
    NULLIF(TRIM(vehicle_manoeuvre), '')                                      vehicle_manoeuvre,
    NULLIF(TRIM(vehicle_direction_from), '')                                 vehicle_direction_from,
    NULLIF(TRIM(vehicle_direction_to), '')                                   vehicle_direction_to,
    NULLIF(TRIM(vehicle_location_restricted_lane_historic), '')              vehicle_location_restricted_lane_historic,
    NULLIF(TRIM(vehicle_location_restricted_lane), '')                       vehicle_location_restricted_lane,
    NULLIF(TRIM(junction_location), '')                                      junction_location,
    NULLIF(TRIM(skidding_and_overturning), '')                               skidding_and_overturning,
    NULLIF(TRIM(hit_object_in_carriageway), '')                              hit_object_in_carriageway,
    NULLIF(TRIM(vehicle_leaving_carriageway), '')                            vehicle_leaving_carriageway,
    NULLIF(TRIM(hit_object_off_carriageway), '')                             hit_object_off_carriageway,
    NULLIF(TRIM(first_point_of_impact), '')                                  first_point_of_impact,
    NULLIF(TRIM(vehicle_left_hand_drive), '')                                vehicle_left_hand_drive,
    NULLIF(TRIM(journey_purpose_of_driver_historic), '')                     journey_purpose_of_driver_historic,
    NULLIF(TRIM(journey_purpose_of_driver), '')                              journey_purpose_of_driver,
    NULLIF(TRIM(sex_of_driver), '')                                          sex_of_driver,
    NULLIF(TRY_CAST(age_of_driver AS INT), -1)                               age_of_driver,
    NULLIF(TRIM(age_band_of_driver), '')                                     age_band_of_driver,
    NULLIF(TRY_CAST(engine_capacity_cc AS INT), -1)                          engine_capacity_cc,
    NULLIF(TRIM(propulsion_code), '')                                        propulsion_code,
    NULLIF(TRY_CAST(age_of_vehicle AS INT), -1)                              age_of_vehicle,
    NULLIF(TRIM(generic_make_model), '')                                     generic_make_model,
    NULLIF(TRY_CAST(driver_imd_decile AS INT), -1)                           driver_imd_decile,
    NULLIF(TRIM(lsoa_of_driver), '')                                         lsoa_of_driver,
    NULLIF(TRIM(escooter_flag), '')                                          escooter_flag,
    NULLIF(TRIM(driver_distance_banding), '')                                driver_distance_banding
FROM bronze.vehicles
WHERE collision_index IS NOT NULL
  AND TRIM(collision_index) <> '';
GO


-- 3. CASUALTIES

INSERT INTO silver.casualties (
    collision_index, collision_year, collision_ref_no, vehicle_reference,
    casualty_reference, casualty_class, sex_of_casualty, age_of_casualty,
    age_band_of_casualty, casualty_severity, pedestrian_location,
    pedestrian_movement, car_passenger, bus_or_coach_passenger,
    pedestrian_road_maintenance_worker, casualty_type, casualty_imd_decile,
    lsoa_of_casualty, enhanced_casualty_severity, casualty_injury_based,
    casualty_adjusted_severity_serious, casualty_adjusted_severity_slight,
    casualty_distance_banding
)
SELECT
    TRIM(collision_index)                                                    collision_index,
    TRY_CAST(collision_year AS INT)                                          collision_year,
    NULLIF(TRIM(collision_ref_no), '')                                       collision_ref_no,
    TRY_CAST(vehicle_reference AS INT)                                       vehicle_reference,
    TRY_CAST(casualty_reference AS INT)                                      casualty_reference,
    NULLIF(TRIM(casualty_class), '')                                         casualty_class,
    NULLIF(TRIM(sex_of_casualty), '')                                        sex_of_casualty,
    NULLIF(TRY_CAST(age_of_casualty AS INT), -1)                             age_of_casualty,
    NULLIF(TRIM(age_band_of_casualty), '')                                   age_band_of_casualty,
    CASE TRY_CAST(casualty_severity AS INT)
        WHEN 1 THEN 'Fatal'
        WHEN 2 THEN 'Serious'
        WHEN 3 THEN 'Slight'
        ELSE NULL
    END                                                                      casualty_severity,
    NULLIF(TRIM(pedestrian_location), '')                                    pedestrian_location,
    NULLIF(TRIM(pedestrian_movement), '')                                    pedestrian_movement,
    NULLIF(TRIM(car_passenger), '')                                          car_passenger,
    NULLIF(TRIM(bus_or_coach_passenger), '')                                 bus_or_coach_passenger,
    NULLIF(TRIM(pedestrian_road_maintenance_worker), '')                     pedestrian_road_maintenance_worker,
    NULLIF(TRIM(casualty_type), '')                                          casualty_type,
    NULLIF(TRY_CAST(casualty_imd_decile AS INT), -1)                         casualty_imd_decile,
    NULLIF(TRIM(lsoa_of_casualty), '')                                       lsoa_of_casualty,
    NULLIF(TRIM(enhanced_casualty_severity), '')                             enhanced_casualty_severity,
    NULLIF(TRIM(casualty_injury_based), '')                                  casualty_injury_based,
    TRY_CAST(NULLIF(casualty_adjusted_severity_serious, '') AS FLOAT)        casualty_adjusted_severity_serious,
    TRY_CAST(NULLIF(casualty_adjusted_severity_slight, '') AS FLOAT)         casualty_adjusted_severity_slight,
    NULLIF(TRIM(casualty_distance_banding), '')                              casualty_distance_banding
FROM bronze.casualties
WHERE collision_index IS NOT NULL
  AND TRIM(collision_index) <> '';
GO

-- ===================================================
-- Sanity checks
-- ===================================================
SELECT COUNT(*) AS silver_accidents_count  FROM silver.accidents;
SELECT COUNT(*) AS silver_vehicles_count   FROM silver.vehicles;
SELECT COUNT(*) AS silver_casualties_count FROM silver.casualties;