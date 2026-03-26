Create Database loan_project;
use loan_project;

-- total applications
select count(*) from loan_cleaned_data;

SELECT * FROM loan_cleaned_data LIMIT 10;

desc loan_cleaned_data;

-- 1. Fix the scaled credit scores
UPDATE loan_cleaned_data 
SET `Credit Score` = `Credit Score` / 10 
WHERE `Credit Score` > 850;

-- 2. Verify the fix
SELECT MIN(`Credit Score`), MAX(`Credit Score`) FROM loan_cleaned_data;

-- purpose of loan
SELECT Purpose, COUNT(*) as Total_Loans
FROM loan_cleaned_data
GROUP BY Purpose
ORDER BY Total_Loans DESC;

-- current loan amount
SELECT SUM(`Current Loan Amount`) AS Total_Value, 
       COUNT(*) AS Total_Rows 
FROM loan_cleaned_data;

-- loan status count
SELECT `Loan Status`, COUNT(*) AS total
FROM loan_cleaned_data
GROUP BY `Loan Status`;

-- approval rate
SELECT 
    ROUND(
        SUM(CASE WHEN `Loan Status` = 'Fully Paid' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS approval_rate
FROM loan_cleaned_data;

-- home ownership
SELECT `Home Ownership`, COUNT(*) AS total
FROM loan_cleaned_data
GROUP BY `Home Ownership`;

-- term
SELECT `Term`, COUNT(*) AS total
FROM loan_cleaned_data
GROUP BY `Term`;

-- risky loan categories
SELECT 
    `Purpose`, 
    COUNT(*) AS total_loans,
    SUM(CASE WHEN `Loan Status` = 'Charged Off' THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(SUM(CASE WHEN `Loan Status` = 'Charged Off' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS default_rate
FROM loan_cleaned_data
GROUP BY `Purpose`
ORDER BY default_rate DESC;

-- credit history
SELECT `Years of Credit History`, `Loan Status`, COUNT(*) AS total_count
FROM loan_cleaned_data
GROUP BY `Years of Credit History`, `Loan Status`
ORDER BY `Years of Credit History` DESC;

-- approval by income group
SELECT 
    CASE 
        WHEN `Annual Income` < 30000 THEN 'Low'
        WHEN `Annual Income` BETWEEN 30000 AND 70000 THEN 'Medium'
        ELSE 'High'
    END AS income_group,
    `Loan Status`,
    COUNT(*) AS total_count
FROM loan_cleaned_data
GROUP BY income_group, `Loan Status`
ORDER BY income_group;

-- short_term vs long_term
SELECT 
    `Term`, 
    AVG(`Current Loan Amount`) AS avg_loan_amount,
    SUM(CASE WHEN `Loan Status` = 'Fully Paid' THEN 1 ELSE 0 END) AS paid_count,
    SUM(CASE WHEN `Loan Status` = 'Charged Off' THEN 1 ELSE 0 END) AS unpaid_count
FROM loan_cleaned_data
GROUP BY `Term`;

-- credit_score vs default_rate
SELECT 
    CASE 
        WHEN `Credit Score` <= 580 THEN 'Poor'
        WHEN `Credit Score` BETWEEN 581 AND 669 THEN 'Fair'
        WHEN `Credit Score` BETWEEN 670 AND 739 THEN 'Good'
        WHEN `Credit Score` >= 740 THEN 'Excellent'
        ELSE 'Unknown'
    END AS credit_category,
    COUNT(*) AS total_customers,
    ROUND(SUM(CASE WHEN `Loan Status` = 'Charged Off' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS default_rate
FROM loan_cleaned_data
GROUP BY credit_category
ORDER BY default_rate DESC;

-- experience vs loan_approval
SELECT 
    `Years in current job`, 
    COUNT(*) AS total_loans,
    ROUND(SUM(CASE WHEN `Loan Status` = 'Fully Paid' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS success_rate
FROM loan_cleaned_data
GROUP BY `Years in current job`
ORDER BY success_rate DESC;

-- Top 10 High-Value Customers who have fully paid
SELECT 
    `Loan ID`, `Annual Income`, `Current Loan Amount`, `Home Ownership`
FROM loan_cleaned_data
WHERE `Loan Status` = 'Fully Paid' 
AND `Annual Income` > 100000 
ORDER BY `Current Loan Amount` DESC
LIMIT 10;

-- max_credit vs current balance
SELECT 
    `Loan ID`,
    `Current Credit Balance`,
    `Maximum Open Credit`,
    ROUND((`Current Credit Balance` / `Maximum Open Credit`) * 100, 2) AS utilization_rate
FROM loan_cleaned_data
WHERE `Maximum Open Credit` > 0
ORDER BY utilization_rate DESC
LIMIT 10;