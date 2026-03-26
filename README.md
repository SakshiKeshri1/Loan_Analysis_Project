# Loan_Analysis_Project
SELECT      `Loan ID`,     `Current Credit Balance`,     `Maximum Open Credit`,     ROUND((`Current Credit Balance` / `Maximum Open Credit`) * 100, 2) AS utilization_rate FROM loan_cleaned_data WHERE `Maximum Open Credit` > 0 ORDER BY utilization_rate DESC LIMIT 10;
