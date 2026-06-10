# 🏠 Airbnb End-to-End Data Engineering Project

[![dbt](https://img.shields.io/badge/dbt-FF6B6B?style=for-the-badge&logo=dbt&logoColor=white)](https://docs.getdbt.com/)
[![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=for-the-badge&logo=Snowflake&logoColor=white)](https://www.snowflake.com/)
[![AWS S3](https://img.shields.io/badge/AWS_S3-FF9900?style=for-the-badge&logo=Amazon-S3&logoColor=white)](https://aws.amazon.com/s3/)
[![Python 3.12](https://img.shields.io/badge/Python-3.12-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)

An enterprise-grade, end-to-end data engineering pipeline transforming raw operational Airbnb data into clean, analytics-ready datasets. This project demonstrates best practices in data warehousing, dimensional modeling, and modern analytics engineering utilizing a **Medallion Architecture** managed via **dbt Core** and hosted on **Snowflake**.

---

## 🏗️ Architecture

The pipeline ingests raw transactional source files into a cloud landing zone, processes it through progressively refined stages inside Snowflake, and maintains an immutable historical ledger using Slowly Changing Dimensions.


│       └── ephemeral/              # Highly modular intermediate view abstracts
    │
    ├── macros/                         # Modular Jinja macro injections
    │   ├── generate_schema_name.sql    # Custom automated target schema routers
    │   ├── multiply.sql                # Reusable vectorized mathematical calculation engine
    │   ├── tag.sql                     # Dynamic conditional price categorization logic
    │   └── trimmer.sql                 # Universal whitespace sanitization utility
    │
    ├── snapshots/                      # SCD Type 2 state tracking engines
    ├── tests/                          # Custom business rule assertion files
    └── seeds/                          # Static mapping data arrays


    ### 🛠️ Technology Stack
* **Cloud Data Warehouse:** Snowflake
* **Transformation Layer:** dbt-core (`v1.11.2+`) & dbt-snowflake (`v1.11.0+`)
* **Storage Infrastructure:** AWS S3 External Stages
* **Code Quality / Formatting:** `sqlfmt` & `Git`
* **Environment Orchestration:** Python 3.12+ / Virtual Environments

---

## 📊 Data Refinement Pipeline (Medallion)

### 🥉 Bronze Layer (Raw Capture)
Acts as the landing zone for raw infrastructure extracts. Tables are structured with minimal operational adjustments to prevent ingestion failure while capturing clear records:
* `bronze_bookings`: Raw transactional reservation stream.
* `bronze_hosts`: Unstructured profile data from global property hosts.
* `bronze_listings`: Structural asset information for properties.

### 🥈 Silver Layer (Cleaned & Standardized)
Applies type casting, string manipulation (removing trailing whitespaces/special syntax errors), dynamic currency tracking, and categorical mapping:
* `silver_bookings`: Sanitized, schema-validated transactional records.
* `silver_hosts`: Validated accounts enriched with automated reliability tracking metrics.
* `silver_listings`: Cleaned asset profiles complete with localized price tiering.

### 🥇 Gold Layer (Analytical Presentation)
High-performance optimization schemas curated directly for Business Intelligence (BI) tools and executive metrics:
* `obt` (One Big Table): Single wide denormalized master table executing multi-way analytical joins across metrics. Highly optimized for query engines.
* `fact`: Traditional dimensional model structured for low-latency star schema joins.

---

## 🕒 Change Data Capture (SCD Type 2 Snapshots)

To preserve downstream historical integrity, Slowly Changing Dimensions (SCD Type 2) are calculated directly via dbt snapshot components. This enables data analysts to travel back in time and measure operational parameters *exactly as they appeared* at a specific historical interval.

* `dim_bookings`: Tracks booking operational status changes over time.
* `dim_hosts`: Maintains a historical record of host property metrics and ranking verification status.
* `dim_listings`: Captures price changes, availability fluctuations, and tier upgrades.

---

## 📁 Project Structure

```yaml
AWS_DBT_Snowflake/
├── README.md                           # Documentation entrypoint
├── pyproject.toml                      # Explicit tool constraints and dependencies
├── main.py                             # Automation wrapper execution script
│
├── SourceData/                         # Local database seeding assets
│   ├── bookings.csv
│   ├── hosts.csv
│   └── listings.csv
│
├── DDL/                                # Infrastructure-as-Code database scripts
│   ├── ddl.sql                         # Target tables creation SQL script
│   └── resources.sql                   # Warehouse, Stage, and RBAC setups
│
└── aws_dbt_snowflake_project/          # Enterprise dbt runtime context
    ├── dbt_project.yml                 # Core dbt engine configuration parameters
    ├── ExampleProfiles.yml             # Blueprint for Snowflake engine networking
    │
    ├── models/                         # Transmutation Logic Engine
    │   ├── sources/
    │   │   └── sources.yml             # Schema constraints, testing thresholds & sources
    │   ├── bronze/                     # Raw extraction layers
    │   ├── silver/                     # Data sanitization, deduplication & standardization
    │   └── gold/                       # Denormalized consumption layers & Star Schemas
    │       └── ephemeral/              # Highly modular intermediate view abstracts
    │
    ├── macros/                         # Modular Jinja macro injections
    │   ├── generate_schema_name.sql    # Custom automated target schema routers
    │   ├── multiply.sql                # Reusable vectorized mathematical calculation engine
    │   ├── tag.sql                     # Dynamic conditional price categorization logic
    │   └── trimmer.sql                 # Universal whitespace sanitization utility
    │
    ├── snapshots/                      # SCD Type 2 state tracking engines
    ├── tests/                          # Custom business rule assertion files
    └── seeds/                          # Static mapping data arrays