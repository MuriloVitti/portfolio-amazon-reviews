# 🛒 Amazon Sales & Pricing Strategy (SQL)

## 🎯 Project Overview

This project performs an Exploratory Data Analysis (EDA) on an Amazon dataset to uncover pricing strategies, consumer behavior, and product performance. I used PostgreSQL to clean, structure, and query the data to answer 5 key business questions.

## 📊 Database & Source

* **Source**:[Amazon Product Reviews Dataset on Kaggle] (https://www.kaggle.com/datasets/karkavelrajaj/amazon-sales-dataset)

* **Scope**: 1,000+ products analyzed across multiple categories.

* **Note**(: The full dataset is located in the /data folder, but due to file size limits, GitHub may not preview it online.

## 🛠️ Data Challenges & Cleaning (The ELT Process)
During the import process, I identified and resolved critical issues to enable numerical analysis:

* **Currency & Symbol Handling:** Cleaned the Indian Rupee (₹) symbols and special characters to convert prices into `NUMERIC`.
* **Fixing Commas:** Many numbers used commas as thousands separators (like 1,099). I removed them to change the format to 1099.00, which is the standard for SQL databases.
* **Percentage Transformation:** Stripped `%` characters and converted them into decimal values (e.g., 94% to 0.94) to allow calculations.
* **Data Integrity:** Handled inconsistent records (like the '|' character found in rating columns) to maintain a clean dataset for final insights.
