# Hevo Data Assignment

# Overview
This project demonstrates an end-to-end data pipeline using a modern data stack:
PostgreSQL → Hevo → Snowflake → dbt
---
## Architecture

***Source**: PostgreSQL (Docker container on AWS EC2)
**Ingestion**: Hevo Data (Logical Replication)
***Data destination/warehouse**: Snowflake
***Transformation**: dbt (Hevo Model dbt and dbt Core)

---

## Steps Implemented

### 1. PostgreSQL Setup

* Deployed PostgreSQL using Docker on AWS EC2
* Enabled logical replication (`wal_level = logical`)
* Created tables:

  * raw_customers
  * raw_orders
  * raw_payments
* Loaded sample data

---

### 2. Hevo Pipeline

* Configured PostgreSQL as source using logical replication
* Created publication and replication slot
* Connected Snowflake as destination
* Verified data ingestion

---

### 3. Snowflake
* Data successfully loaded into:
  * HEVO_DB.ABC_PUBLIC schema

---

### 4. dbt Transformation

Created a `customers` model with:

* first_order → MIN(order_date)
* most_recent_order → MAX(order_date)
* number_of_orders → COUNT(*)
* customer_lifetime_value → SUM(payments)
---
## dbt Model

sql
-- models/customers.sql
---
## Output
Final table:
HEVO_DB.ABC_PUBLIC.CUSTOMERS
---
## Challenges Faced

* Source and destination configurations took time in Hevo. It was a bit tricky to figure out the hostname of snowflake and the warehouse name had to be in Capital letters.
* Snowflake permission and role configuration issues
* Postgres setup also took some time and effort
## Conclusion

Successfully implemented an end-to-end modern data pipeline with transformation using db
