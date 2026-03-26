
## 🚀 Project Overview

This project focuses on analyzing loan application data using SQL to extract meaningful insights related to loan approvals, customer demographics, and financial risk factors.

---

## 🎯 Objectives

* 📊 Analyze total loan applications
* ✅ Calculate loan approval rate
* 👥 Perform customer segmentation
* 💳 Study impact of credit history
* 📈 Identify key factors affecting loan approval

---

## 🗂️ Dataset

* 📁 File: `loan_data.csv`
* Contains:

  * Applicant Income
  * Loan Amount
  * Credit History
  * Property Area
  * Loan Status

---

## 🛠️ Tools & Technologies

* SQL
* MySQL Workbench
* CSV Dataset

---

## ⚙️ Steps Performed

### 1️⃣ Database Creation

* Created database: `loan_project`

### 2️⃣ Data Import

* Imported CSV using Table Data Import Wizard
* Created table: `loan_cleaned_data_`

### 3️⃣ Data Cleaning

* Checked NULL values
* Handled missing data

### 4️⃣ Data Analysis

* Loan approval trends
* Gender-based analysis
* Income group segmentation
* Credit history impact

---

## 📈 Key Insights

* ✔ Applicants with credit history = 1 have higher approval chances
* ✔ Medium & high income groups show better approval rates
* ✔ Property area influences loan approvals
* ✔ Credit history is the most important factor

---

## 💻 Sample SQL Queries

```sql
-- Total Applications
SELECT COUNT(*) FROM loans;

-- Loan Status Distribution
SELECT Loan_Status, COUNT(*) 
FROM loans
GROUP BY Loan_Status;

-- Approval Rate
SELECT 
ROUND(SUM(CASE WHEN Loan_Status='Y' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) 
AS approval_rate
FROM loans;
```

---

## 📂 Project Structure

```
Loan-SQL-Project/
│── loan_cleaned_data.csv
│── loan_analysis.sql
│── README.md
```

---

## 💡 Learning Outcomes

* SQL query writing
* Data cleaning techniques
* Business insight generation
* Real-world data analysis

---

## 👩‍💻 Author

**Sakshi Keshari**

---

## ⭐ Support

If you like this project, give it a ⭐ on GitHub!
