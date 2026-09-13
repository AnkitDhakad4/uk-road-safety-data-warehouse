# Bronze Layer — Data Load Process

## Source Data
Three CSV files downloaded from the UK government's official road safety open data portal:
https://www.gov.uk/government/statistical-data-sets/road-safety-open-data

- dft-road-casualty-statistics-collision-last-5-years.csv — one row per collision
- dft-road-casualty-statistics-vehicle-last-5-years.csv — one row per vehicle involved in a collision
- dft-road-casualty-statistics-casualty-last-5-years.csv — one row per person injured or killed

Date range used: 2021-2025 (a 5-year window, chosen to keep the dataset manageable
while still covering enough time for year-over-year trend analysis).

## Load Method
The database and its three schemas (bronze, silver, gold) were created first via
the init_database script. Because the schemas already existed, SQL Server
Management Studio's Import Flat File Wizard could target the bronze schema
directly from its schema selection dropdown during import.

Steps followed:
1. Ran the wizard once per CSV file (three times total): Database -> right-click
   -> Tasks -> Import Flat File.
2. Selected the bronze schema from the wizard's schema dropdown so each table
   landed directly under bronze instead of the default dbo schema.
3. On the "Modify Columns" screen, set every column to allow NULLs and typed as
   VARCHAR(50) — this avoided import failures caused by the wizard's automatic
   type-guessing, where a numeric-looking column would otherwise reject a
   blank or missing value.
4. Named the target tables accidents, vehicles, and casualties.

## Resulting Bronze Tables
| Table | Schema | Columns | Notes |
|---|---|---|---|
| accidents| bronze | all VARCHAR(50), nullable | raw, untyped, no cleaning applied |
| vehicles | bronze | all VARCHAR(50), nullable | raw, untyped, no cleaning applied |
| casualties | bronze | all VARCHAR(50), nullable | raw, untyped, no cleaning applied |

Bronze intentionally holds unclean, untyped data exactly as delivered by the
source. This preserves an auditable, reproducible copy of the raw files before
any transformation happens in the Silver layer.

## Verification
After loading, row counts and a sample of rows were checked for each table to
confirm the import completed correctly and no columns were fully empty due to
a mismatched import.
