# 🍽️ Swiggy Restaurant Data Analysis Using MySQL

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Database](https://img.shields.io/badge/Database-MySQL%208.0+-blue.svg)](https://www.mysql.com/)
[![SQL Queries](https://img.shields.io/badge/SQL-Advanced%20Analytics-orange.svg)](#-sql-analysis--business-questions)

An exploratory and analytical SQL project analyzing restaurant listings on Swiggy across multiple Indian cities. This project leverages MySQL to extract actionable insights on restaurant pricing, ratings, delivery efficiency, culinary diversity, and regional market distribution using queries ranging from basic aggregations to advanced Common Table Expressions (CTEs) and Window Functions.

---

## 📌 Project Overview

Online food delivery platforms generate rich datasets that reveal consumer preferences, regional dining trends, pricing dynamics, and delivery logistics. 

This repository contains:
- **`swiggy .csv`**: Raw dataset containing thousands of restaurant listings with attributes like price, ratings, cuisine type, and delivery duration.
- **`swiggy_restaurant_analysis.sql`**: Comprehensive SQL script containing table definitions (`DDL`) and 15 business and analytical queries (`DQL`) structured logically from fundamental summaries to advanced window analytics.

> **Note**: This dataset captures restaurant listing attributes and metadata rather than transaction-level order volumes.

---

## 📊 Dataset & Schema Architecture

The database `swiggy_analytics` stores the restaurant data in the table `swiggy_restaurants`:

```sql
CREATE DATABASE IF NOT EXISTS swiggy_analytics;
USE swiggy_analytics;

CREATE TABLE IF NOT EXISTS swiggy_restaurants (
    ID INT,
    Area VARCHAR(100),
    City VARCHAR(100),
    Restaurant VARCHAR(255),
    Price DECIMAL(10,2),
    `Avg ratings` DECIMAL(3,2),
    `Total ratings` INT,
    `Food type` TEXT,
    Address VARCHAR(500),
    `Delivery time` INT
);
```

### Data Dictionary

| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| `ID` | `INT` | Unique identifier for each restaurant listing |
| `Area` | `VARCHAR(100)` | Neighborhood / locality where the restaurant is situated |
| `City` | `VARCHAR(100)` | City of the restaurant |
| `Restaurant` | `VARCHAR(255)` | Name of the restaurant |
| `Price` | `DECIMAL(10,2)` | Average listed price for food items / cost for two |
| `Avg ratings` | `DECIMAL(3,2)` | Customer rating score (scale: 1.0 to 5.0) |
| `Total ratings`| `INT` | Number of reviews / ratings submitted by users |
| `Food type` | `TEXT` | Cuisines and food categories offered |
| `Address` | `VARCHAR(500)` | Full physical address of the restaurant |
| `Delivery time`| `INT` | Estimated delivery time in minutes |

---

## 🔍 SQL Analysis & Business Questions

The analysis is divided into three analytical tiers:

### 1. Exploratory & Platform Overview
* **Q1. Total Platform Footprint:** Counts the total number of restaurant listings.
* **Q2. City Coverage:** Lists all distinct cities serviced on the platform.
* **Q3. Luxury / High-End Outlets:** Identifies the top 5 most expensive restaurant listings.
* **Q4. High-Rating Filter:** Filters restaurants holding customer ratings above 4.0.
* **Q5. Benchmark Pricing:** Computes the overall average listing price across all restaurants.

### 2. City-Level Aggregations & Distribution
* **Q6. Restaurant Supply by City:** Groups listings by city to highlight restaurant concentration and supply density.
* **Q7. City-Wise Cost Analysis:** Calculates average dish / listing price per city to identify high-cost vs. budget-friendly dining markets.
* **Q8. Top 10 Most Popular Outlets:** Retrieves top 10 restaurants with the highest aggregate rating volume.
* **Q9. High-Performing Hubs:** Identifies cities where the collective average restaurant rating exceeds 4.0 using `HAVING`.
* **Q10. Delivery Speed Benchmark:** Calculates average delivery time per city, ranked from fastest to slowest.

### 3. Advanced Window Functions & CTE Analytics
* **Q11. Intra-City Rating Ranks:** Uses `DENSE_RANK() OVER (PARTITION BY City ORDER BY \`Avg ratings\` DESC)` to rank restaurants within each individual market.
* **Q12. Flagship Expensive Listing per City:** Uses Common Table Expressions (CTEs) and `DENSE_RANK()` to find the highest-priced dining options in every city.
* **Q13. Premium Outlets Exceeding Market Norm:** Identifies restaurants priced above their respective city's average listing price using windowed averages (`AVG(Price) OVER (PARTITION BY City)`).
* **Q14. High-Quality Quick Delivery Gems:** Finds top-tier restaurants (`Avg ratings >= 4.0`) that deliver faster than their city's average delivery benchmark.
* **Q15. Price-Tier Segmentation:** Classifies listings into `Budget` (< ₹200), `Mid-range` (₹200–₹500), and `Premium` (≥ ₹500) using `CASE` statements to analyze volume distribution and rating trends.

---

## 🚀 Getting Started

### Prerequisites
* [MySQL Server 8.0+](https://dev.mysql.com/downloads/mysql/)
* [MySQL Workbench](https://dev.mysql.com/downloads/workbench/) (or any SQL client like DBeaver, DataGrip, or CLI)

### Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/technicalabinesh/Swiggy-Restaurant-Data-Analysis-Using-MySQL.git
   cd Swiggy-Restaurant-Data-Analysis-Using-MySQL
   ```

2. **Open MySQL Workbench and connect to your database instance.**

3. **Run the DDL Script:**
   * Open [`swiggy_restaurant_analysis.sql`](swiggy_restaurant_analysis.sql) and execute the `CREATE DATABASE` and `CREATE TABLE` statements.

4. **Import the Dataset:**
   * In MySQL Workbench, expand the `swiggy_analytics` database in the left sidebar under **Schemas**.
   * Right-click `swiggy_restaurants` > select **Table Data Import Wizard**.
   * Browse and select [`swiggy .csv`](swiggy%20.csv).
   * Map the CSV headers to the table columns and click **Next** to import all rows.

5. **Run the Analytical Queries:**
   * Execute queries Q1 through Q15 in [`swiggy_restaurant_analysis.sql`](swiggy_restaurant_analysis.sql) to reproduce the findings and extract insights!

---

## 💡 Key Analytical Insights

* **Price Segmentation:** Mid-range restaurants (₹200–₹500) constitute the bulk of platform supply, serving everyday dining needs.
* **City Delivery Efficiency:** Delivery times vary significantly across cities due to urban layout and density; filtering for ratings `>= 4.0` with below-average delivery time pinpoints the top operational performers.
* **Market Disparities:** Premium listings are heavily clustered in Tier-1 metropolitan areas, while smaller cities exhibit tight pricing clusters around budget meals.

---

## 🛠️ Technologies Used

* **Database Engine:** MySQL 8.0+
* **SQL Techniques:** 
  * Aggregation Functions (`COUNT`, `AVG`, `ROUND`)
  * Data Filtering & Sorting (`GROUP BY`, `HAVING`, `ORDER BY`, `LIMIT`)
  * Window Functions (`DENSE_RANK()`, `OVER (PARTITION BY ...)`)
  * Common Table Expressions (`WITH ... AS`)
  * Conditional Expressions (`CASE WHEN`)

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

## 👤 Author

* **Abinesh** - [GitHub Profile](https://github.com/technicalabinesh)
