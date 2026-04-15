# 📊 SQL Electronics EDA Pipeline

## 🔍 Overview

This project demonstrates a complete **data cleaning + exploratory data analysis (EDA)** workflow using SQL on raw e-commerce electronics data.

The dataset contains inconsistencies such as:

* Price ranges (`"$100 through $200"`)
* Mixed discount formats
* Embedded rating + review counts
* Unstructured product titles

This project converts messy raw data into structured, analysis-ready format and extracts actionable insights.

---

## ⚙️ Tech Stack

* SQL (MySQL)
* Window Functions
* Stored Procedures
* Data Cleaning Techniques
* Statistical Analysis (Percentiles, Correlation)

---

## 🧹 Data Cleaning Steps

### 1. Price Normalization

* Removed `$` and `,`
* Converted price ranges into averages
* Converted price column to `DECIMAL`

### 2. Discount Engineering

* Created `discount_given` flag (YES/NO)
* Derived `MRP` using:

  * Flat discount logic
  * Estimated % discount fallback

### 3. Rating Extraction

* Extracted:

  * `Average_Rating`
  * `reviews_count`
* Removed raw text column

### 4. Brand Standardization

* Extracted brand from product title
* Cleaned inconsistent brand names (e.g., Apple variations)

### 5. Data Quality Fixes

* Removed invalid rows
* Dropped unnecessary columns (currency)
* Handled null values

---

## 📊 Exploratory Data Analysis

### Univariate Analysis

* Min, Max, Avg, Std Dev of price
* Percentile calculation using window functions
* Histogram bucket distribution

### Outlier Detection

* Used IQR method via stored procedure:

  * Q1, Median, Q3
  * Identified extreme price values

### Bivariate Analysis

* Correlation between:

  * Ratings vs Reviews
* Calculated:

  * Covariance
  * Correlation coefficient
  * Regression slope

### Categorical Analysis

* Product distribution across sub-categories
* Brand vs category spread

### Multivariate Analysis

* Covariance between Price & MRP across categories

---

## 🧠 Key Insights (What a business would care about)

* High-priced items show **lower review density**
* Some brands dominate multiple categories → **market leaders**
* Discount strategies vary widely → **pricing inconsistency**
* Outliers reveal **premium vs budget segmentation**

---

## 🏗️ Project Structure

```
├── sql/
│   └── eda_using_sql.sql
├── data/
│   └── ElectronicsData.csv
├── README.md
```

---

## ▶️ How to Run

1. Create database:

```sql
CREATE DATABASE electronics_db;
USE electronics_db;
```

2. Load dataset:

```sql
LOAD DATA INFILE 'path_to_csv'
INTO TABLE electronicsdata
...
```

3. Run SQL script step-by-step:

* Cleaning
* Transformation
* EDA queries

---

## 💼 Why This Project Matters

This project demonstrates:

* Real-world messy data handling
* Business-focused feature engineering
* Strong SQL fundamentals (window functions, procedures)
* Ability to extract insights—not just write queries

---

## 🚀 Future Improvements

* Build dashboard (Power BI / Tableau)
* Add time-series pricing trends
* Perform customer segmentation
* Move pipeline to Python + SQL hybrid

---
