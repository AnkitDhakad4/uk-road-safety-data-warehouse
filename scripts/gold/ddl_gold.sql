
-- GOLD LAYER: fact + dimension tables (star schema)
-- Built from silver.accidents, silver.vehicles, silver.casualties



-- DIMENSION: Date

CREATE TABLE gold.dim_date (
    date_key        DATE PRIMARY KEY,
    collision_year  INT,
    month_no        INT,
    month_name      NVARCHAR(15),
    quarter_no      INT,
    day_of_week     NVARCHAR(15),
    is_weekend      BIT
);
GO

INSERT INTO gold.dim_date
SELECT DISTINCT
    collision_date,
    collision_year,
    MONTH(collision_date),
    DATENAME(MONTH, collision_date),
    DATEPART(QUARTER, collision_date),
    day_of_week,
    CASE WHEN day_of_week IN ('Saturday', 'Sunday') THEN 1 ELSE 0 END
FROM silver.accidents
WHERE collision_date IS NOT NULL;
GO

-- ---------------------------------------------------
-- DIMENSION: Location
-- ---------------------------------------------------
CREATE TABLE gold.dim_location (
    location_key                INT IDENTITY(1,1) PRIMARY KEY,
    local_authority_district    NVARCHAR(50),
    local_authority_highway     NVARCHAR(50),
    police_force                NVARCHAR(50),
    urban_or_rural_area         NVARCHAR(10)
);
GO

INSERT INTO gold.dim_location (local_authority_district, local_authority_highway, police_force, urban_or_rural_area)
SELECT DISTINCT
    local_authority_district,
    local_authority_highway,
    police_force,
    urban_or_rural_area
FROM silver.accidents;
GO

-- ---------------------------------------------------
-- DIMENSION: Conditions (road + weather context)
-- ---------------------------------------------------
CREATE TABLE gold.dim_conditions (
    conditions_key            INT IDENTITY(1,1) PRIMARY KEY,
    light_conditions          NVARCHAR(50),
    weather_conditions        NVARCHAR(50),
    road_surface_conditions   NVARCHAR(50),
    road_type                 NVARCHAR(50),
    speed_limit                INT
);
GO

INSERT INTO gold.dim_conditions (light_conditions, weather_conditions, road_surface_conditions, road_type, speed_limit)
SELECT DISTINCT
    light_conditions,
    weather_conditions,
    road_surface_conditions,
    road_type,
    speed_limit
FROM silver.accidents;
GO

-- ---------------------------------------------------
-- FACT: Collisions (grain = 1 row per collision)
-- ---------------------------------------------------
CREATE TABLE gold.fact_collisions (
    collision_index        NVARCHAR(20) PRIMARY KEY,
    date_key               DATE,
    location_key           INT,
    conditions_key         INT,
    collision_severity     NVARCHAR(20),
    number_of_vehicles     INT,
    number_of_casualties   INT,
    FOREIGN KEY (date_key)       REFERENCES gold.dim_date(date_key),
    FOREIGN KEY (location_key)   REFERENCES gold.dim_location(location_key),
    FOREIGN KEY (conditions_key) REFERENCES gold.dim_conditions(conditions_key)
);
GO

INSERT INTO gold.fact_collisions (collision_index, date_key, location_key, conditions_key, collision_severity, number_of_vehicles, number_of_casualties)
SELECT
    a.collision_index,
    a.collision_date,
    l.location_key,
    c.conditions_key,
    a.collision_severity,
    a.number_of_vehicles,
    a.number_of_casualties
FROM silver.accidents a
LEFT JOIN gold.dim_location l
    ON  a.local_authority_district = l.local_authority_district
    AND a.local_authority_highway  = l.local_authority_highway
    AND a.police_force             = l.police_force
    AND a.urban_or_rural_area      = l.urban_or_rural_area
LEFT JOIN gold.dim_conditions c
    ON  a.light_conditions         = c.light_conditions
    AND a.weather_conditions       = c.weather_conditions
    AND a.road_surface_conditions  = c.road_surface_conditions
    AND a.road_type                = c.road_type
    AND a.speed_limit              = c.speed_limit;
GO



-- Kept at a finer grain than fact_collisions on purpose —
-- this is what lets you analyze by age/sex/casualty type
CREATE TABLE gold.fact_casualties (
    collision_index      NVARCHAR(20),
    vehicle_reference     INT,
    casualty_reference    INT,
    casualty_class        NVARCHAR(30),
    sex_of_casualty       NVARCHAR(10),
    age_of_casualty       INT,
    age_band_of_casualty  NVARCHAR(20),
    casualty_severity     NVARCHAR(20),
    casualty_type         NVARCHAR(50)
);
GO

INSERT INTO gold.fact_casualties
SELECT
    collision_index,
    vehicle_reference,
    casualty_reference,
    casualty_class,
    sex_of_casualty,
    age_of_casualty,
    age_band_of_casualty,
    casualty_severity,
    casualty_type
FROM silver.casualties;
GO