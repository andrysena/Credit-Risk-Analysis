SELECT * 
FROM Finance;

-- Total rows
SELECT COUNT(*) AS Total_Records
FROM Finance;

-- Default distribution
SELECT 
    loan_status,
    COUNT(*) AS Total_Clients,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS Percentage
FROM Finance
GROUP BY loan_status;

-- Overall default rate
SELECT
    COUNT(*) AS Total_Clients,
    SUM(CAST(loan_status AS INT)) AS Total_Default,
    ROUND(SUM(CAST(loan_status AS INT)) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM Finance;

-- Default rate by loan grade
SELECT 
    loan_grade,
    COUNT(*) AS Total_Clients,
    SUM(CAST(loan_status AS INT)) AS In_Default,
    ROUND(SUM(CAST(loan_status AS INT)) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM Finance
GROUP BY loan_grade
ORDER BY loan_grade;

-- Default rate by home ownership
SELECT 
    person_home_ownership,
    COUNT(*) AS Total_Clients,
    SUM(CAST(loan_status AS INT)) AS In_Default,
    ROUND(AVG(CAST(person_income AS FLOAT)), 2) AS Avg_Income,
    ROUND(SUM(CAST(loan_status AS INT)) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM Finance
GROUP BY person_home_ownership
ORDER BY Default_Rate DESC;

-- Default rate by loan intent
SELECT
    loan_intent,
    COUNT(*) AS Total_Clients,
    SUM(CAST(loan_status AS INT)) AS In_Default,
    ROUND(AVG(CAST(loan_amnt AS FLOAT)), 2) AS Avg_Loan_Amount,
    ROUND(SUM(CAST(loan_status AS INT)) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM Finance
GROUP BY loan_intent
ORDER BY Default_Rate DESC;

-- Default rate by age range
SELECT
    CASE
        WHEN person_age BETWEEN 18 AND 25 THEN '18-25'
        WHEN person_age BETWEEN 26 AND 35 THEN '26-35'
        WHEN person_age BETWEEN 36 AND 45 THEN '36-45'
        WHEN person_age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '55+'
    END AS Age_Range,
    COUNT(*) AS Total_Clients,
    SUM(CAST(loan_status AS INT)) AS In_Default,
    ROUND(SUM(CAST(loan_status AS INT)) * 100.0 / COUNT(*), 2) AS Default_Rate
FROM Finance
GROUP BY
    CASE
        WHEN person_age BETWEEN 18 AND 25 THEN '18-25'
        WHEN person_age BETWEEN 26 AND 35 THEN '26-35'
        WHEN person_age BETWEEN 36 AND 45 THEN '36-45'
        WHEN person_age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '55+'
    END
ORDER BY 
    CASE
        WHEN 
            CASE
                WHEN person_age BETWEEN 18 AND 25 THEN '18-25'
                WHEN person_age BETWEEN 26 AND 35 THEN '26-35'
                WHEN person_age BETWEEN 36 AND 45 THEN '36-45'
                WHEN person_age BETWEEN 46 AND 55 THEN '46-55'
                ELSE '55+'
            END = '18-25' THEN 1
        WHEN 
            CASE
                WHEN person_age BETWEEN 18 AND 25 THEN '18-25'
                WHEN person_age BETWEEN 26 AND 35 THEN '26-35'
                WHEN person_age BETWEEN 36 AND 45 THEN '36-45'
                WHEN person_age BETWEEN 46 AND 55 THEN '46-55'
                ELSE '55+'
            END = '26-35' THEN 2
        WHEN 
            CASE
                WHEN person_age BETWEEN 18 AND 25 THEN '18-25'
                WHEN person_age BETWEEN 26 AND 35 THEN '26-35'
                WHEN person_age BETWEEN 36 AND 45 THEN '36-45'
                WHEN person_age BETWEEN 46 AND 55 THEN '46-55'
                ELSE '55+'
            END = '36-45' THEN 3
        WHEN 
            CASE
                WHEN person_age BETWEEN 18 AND 25 THEN '18-25'
                WHEN person_age BETWEEN 26 AND 35 THEN '26-35'
                WHEN person_age BETWEEN 36 AND 45 THEN '36-45'
                WHEN person_age BETWEEN 46 AND 55 THEN '46-55'
                ELSE '55+'
            END = '46-55' THEN 4
        ELSE 5
    END;

-- Average interest rate by loan grade
SELECT
    loan_grade,
    COUNT(*) AS Total_Clients,
    ROUND(AVG(CAST(loan_int_rate AS FLOAT)), 2) AS Avg_Interest_Rate,
    ROUND(AVG(CAST(loan_amnt AS FLOAT)), 2) AS Avg_Loan_Amount,
    ROUND(AVG(CAST(person_income AS FLOAT)), 2) AS Avg_Income
FROM Finance
GROUP BY loan_grade 
ORDER BY loan_grade ASC;

-- Impact of previous credit default history
SELECT 
    cb_person_default_on_file AS Previous_Default_History,
    COUNT(*) AS Total_Clients,
    SUM(CAST(loan_status AS INT)) AS In_Default,
    ROUND(SUM(CAST(loan_status AS INT)) * 100.0 / COUNT(*), 2) AS Default_Rate,
    ROUND(AVG(CAST(loan_amnt AS FLOAT)), 2) AS Avg_Loan_Amount
FROM Finance
GROUP BY cb_person_default_on_file
ORDER BY Default_Rate DESC;

-- Executive Summary - Key Performance Indicators
SELECT
    COUNT(*) AS Total_Clients,
    SUM(CAST(loan_status AS INT)) AS Total_Default,
    ROUND(SUM(CAST(loan_status AS INT)) * 100.0 / COUNT(*), 2) AS Default_Rate,
    ROUND(AVG(CAST(loan_amnt AS FLOAT)), 2) AS Avg_Loan_Amount,
    ROUND(AVG(CAST(loan_int_rate AS FLOAT)), 2) AS Avg_Interest_Rate,
    ROUND(AVG(CAST(person_income AS FLOAT)), 2) AS Avg_Income,
    ROUND(AVG(CAST(cb_person_cred_hist_length AS FLOAT)), 2) AS Avg_Credit_History_Years,
    ROUND(AVG(CAST(person_emp_length AS FLOAT)), 2) AS Avg_Employment_Years
FROM Finance

