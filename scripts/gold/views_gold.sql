
-- GOLD LAYER: business-ready views



-- 1. Accidents by year and severity
CREATE VIEW gold.v_accidents_by_year_severity AS
SELECT
    d.collision_year,
    f.collision_severity,
    COUNT(*) AS total_collisions,
    SUM(f.number_of_casualties) AS total_casualties
FROM gold.fact_collisions f
JOIN gold.dim_date d ON f.date_key = d.date_key
GROUP BY d.collision_year, f.collision_severity;
GO

-- 2. Monthly trend 
CREATE VIEW gold.v_monthly_collision_trend AS
SELECT
    d.collision_year,
    d.month_no,
    d.month_name,
    COUNT(*) AS total_collisions
FROM gold.fact_collisions f
JOIN gold.dim_date d ON f.date_key = d.date_key
GROUP BY d.collision_year, d.month_no, d.month_name;
GO

-- 3. Weekend vs weekday risk
CREATE VIEW gold.v_weekend_vs_weekday AS
SELECT
    d.is_weekend,
    COUNT(*) AS total_collisions,
    AVG(CAST(f.number_of_casualties AS FLOAT)) AS avg_casualties_per_collision
FROM gold.fact_collisions f
JOIN gold.dim_date d ON f.date_key = d.date_key
GROUP BY d.is_weekend;
GO

-- 4. High-risk locations — where interventions matter most
CREATE VIEW gold.v_high_risk_locations AS
SELECT TOP 20
    l.local_authority_district,
    l.police_force,
    COUNT(*) AS total_collisions,
    SUM(CASE WHEN f.collision_severity = 'Fatal' THEN 1 ELSE 0 END) AS fatal_collisions
FROM gold.fact_collisions f
JOIN gold.dim_location l ON f.location_key = l.location_key
GROUP BY l.local_authority_district, l.police_force
ORDER BY total_collisions DESC;
GO

-- 5. Weather and road condition risk factors
CREATE VIEW gold.v_conditions_risk AS
SELECT
    c.weather_conditions,
    c.road_surface_conditions,
    c.light_conditions,
    COUNT(*) AS total_collisions,
    SUM(CASE WHEN f.collision_severity IN ('Fatal', 'Serious') THEN 1 ELSE 0 END) AS severe_collisions
FROM gold.fact_collisions f
JOIN gold.dim_conditions c ON f.conditions_key = c.conditions_key
GROUP BY c.weather_conditions, c.road_surface_conditions, c.light_conditions;
GO

-- 6. Casualty demographics — who is most affected
CREATE VIEW gold.v_casualty_demographics AS
SELECT
    sex_of_casualty,
    age_band_of_casualty,
    casualty_type,
    casualty_severity,
    COUNT(*) AS total_casualties
FROM gold.fact_casualties
GROUP BY sex_of_casualty, age_band_of_casualty, casualty_type, casualty_severity;
GO

-- 7. Speed limit vs severity — does speed limit correlate with worse outcomes
CREATE VIEW gold.v_speedlimit_vs_severity AS
SELECT
    c.speed_limit,
    f.collision_severity,
    COUNT(*) AS total_collisions
FROM gold.fact_collisions f
JOIN gold.dim_conditions c ON f.conditions_key = c.conditions_key
GROUP BY c.speed_limit, f.collision_severity;
GO