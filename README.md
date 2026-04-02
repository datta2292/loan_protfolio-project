# Loan Portfolio & Risk Analysis

![SQL](https://img.shields.io/badge/SQL-MySQL-4479A1?style=flat&logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/PowerBI-Dashboard-F2C811?style=flat&logo=powerbi&logoColor=black)
![Dataset](https://img.shields.io/badge/Dataset-8%2C145%20Records-2ecc71?style=flat)

## About This Project

This is a **learning project** built to practice SQL data cleaning and Power BI visualization skills. The goal was to take a raw loan dataset, clean it using MySQL queries, and build a simple dashboard to explore the data visually.

## What I Did

### 1. Data Cleaning (MySQL)
- Renamed columns for consistency
- Replaced NULL and empty values in `Emp_length` and `Rate` columns
- Standardized the `Loan_Default` column values
- Added a Primary Key on `Loan_ID`
- Created indexes on key columns to improve query performance

### 2. Data Analysis (SQL Queries)
Wrote 22 SQL queries to explore the dataset:
- Total loan applications and average loan amount
- Loan count by purpose (Intent)
- Default rate by loan purpose, income group, and age group
- Interest rate comparison for defaulted vs non-defaulted applicants
- Top 10 applicants by loan-to-income ratio
- Used CTEs, CASE WHEN, window functions (RANK), and subqueries

### 3. Visualization (Power BI)
Built a simple interactive dashboard showing:
- Key KPIs: total applications, default rate, average loan amount
- Default breakdown by loan purpose
- Filters by home ownership and employment length

---
## Dataset

| Property | Detail |
|---|---|
| Records | 8,145 |
| Columns | 12 |
| Key fields | Age, Income, Loan Amount, Intent, Default Status |

> Note: The raw dataset contained some incorrect/inconsistent values which were cleaned during the SQL stage before visualization.

---

## Tools Used

- **MySQL** — data cleaning and querying
- **Power BI Desktop** — dashboard and visualization

---

## Repository Structure

```
loan-risk-analysis/
│
├── data/
│   ├── Loan_prediction_mini_dataset.csv     # Raw dataset
│   └── cleaned_loan_prediction_data.csv     # Cleaned dataset
│
├── sql/
│   └── loan_project_cf.sql                  # All SQL queries
│
├── dashboard/
│   └── loan_prediction_db.pbix              # Power BI file
│
└── README.md
```

---

## How to Run

**SQL:**
1. Import `Loan_prediction_mini_dataset.csv` into MySQL as `loan details`
2. Run `loan_project_cf.sql` — queries are numbered and commented
3. Database name: `loan_prediction`

**Power BI:**
1. Open `loan_prediction_db.pbix` in Power BI Desktop
2. If data doesn't load, update the source path to `cleaned_loan_prediction_data.csv`

---

## What I Learned

- Writing SQL queries for data cleaning and exploration
- Using CTEs, window functions, and CASE WHEN for analysis
- Connecting cleaned data to Power BI and building dashboards
- Understanding the full workflow from raw data to visual output

---

## connect

**Vadla Datta Sai**
Aspiring Data Analyst | Hyderabad, India
[LinkedIn](https://www.linkedin.com/in/datta-sai22)

