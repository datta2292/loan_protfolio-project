create database loan_prediction;
use loan_prediction;

select * from `loan details`;

#1.this query is change to column name.
ALTER TABLE `loan details`
    CHANGE COLUMN Id Loan_ID VARCHAR(50),
    CHANGE COLUMN Age Age INT,
    CHANGE COLUMN Income Income BIGINT,
    CHANGE COLUMN Home Home VARCHAR(50),
    CHANGE COLUMN Emp_length Emp_length VARCHAR(50),
    CHANGE COLUMN Intent Intent VARCHAR(50),
    CHANGE COLUMN Amount Amount BIGINT,
    CHANGE COLUMN Rate Rate VARCHAR(50),
    CHANGE COLUMN Status Status VARCHAR(50),
    CHANGE COLUMN Percent_income Percent_income VARCHAR(50),
    CHANGE COLUMN `Default` Loan_Default VARCHAR(10),
    CHANGE COLUMN Cred_length Cred_length INT;

#2.Total Loan Applications.
SELECT COUNT(*) AS Total_Applications
FROM `loan details`;

#3.Distinct Loan Purposes (Intents).
SELECT DISTINCT Intent
FROM `loan details`;

#4.Number of Applicants by age.
SELECT age, COUNT(*) AS Total_Applicants
FROM `loan details`
GROUP BY age;

#5.Average Loan Amount Requested.
SELECT ROUND(AVG(Amount), 2) AS Avg_Loan_Amount
FROM `loan details`;

#6.this query to update the loan details table by replacing NULL or empty values in Emp_length with 'Unknown' and in Rate with 'NA'.
SET SQL_SAFE_UPDATES = 0;

UPDATE `loan details`
SET Emp_length = 'Unknown'
WHERE Emp_length IS NULL OR Emp_length = '';

UPDATE `loan details`
SET Rate = 'NA'
WHERE Rate IS NULL OR Rate = '';
SET SQL_SAFE_UPDATES = 1; -- turn it back on

select * from `loan details`;

#8.Highest and Lowest Interest Rate.
SELECT MAX(Rate) AS Max_Rate, MIN(Rate) AS Min_Rate
FROM `loan details`;

#9.Number of Loans by Purpose
SELECT Intent, COUNT(*) AS Loan_Count
FROM `loan details`
GROUP BY Intent
ORDER BY Loan_Count DESC;

#10.default rate analysis by purpose.
WITH PurposeStats AS (
    SELECT Intent,
           COUNT(*) AS Total,
           SUM(CASE WHEN Loan_Default = 'y' THEN 1 ELSE 0 END) AS Defaults
    FROM `loan details`
    GROUP BY Intent
)
SELECT Intent,
       Total,
       Defaults,
       ROUND(100.0 * Defaults / Total, 2) AS Default_Rate
FROM PurposeStats
ORDER BY Default_Rate DESC;


#11.Average Loan Amount & Rate by Home Ownership.
SELECT Home, 
       ROUND(AVG(Amount), 2) AS Avg_Amount,
       ROUND(AVG(Rate), 2) AS Avg_Rate
FROM `loan details`
GROUP BY Home;

#12.Applicants with Missing Employment Length.
SELECT Loan_ID, Age, Income, Emp_length
FROM `loan details`
WHERE Emp_length IS NULL OR Emp_length = '' OR Emp_length = 'Unknown';

#13.Applicants with Missing Loan Default Count
SELECT Rate, 
       COUNT(*) AS Total,
       SUM(CASE WHEN Loan_Default = 'y' THEN 1 ELSE 0 END) AS Defaults
FROM `loan details`
GROUP BY rate;

#14.Income Group vs Default Rate.
SELECT 
    CASE 
      WHEN Income < 25000 THEN 'Low Income'
      WHEN Income BETWEEN 25000 AND 75000 THEN 'Middle Income'
      ELSE 'High Income'
    END AS Income_Group,
    COUNT(*) AS Total,
    SUM(CASE WHEN Loan_Default = 'Y' THEN 1 ELSE 0 END) AS Defaults,
    ROUND(100.0 * SUM(CASE WHEN Loan_Default = 'Y' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Default_Rate
FROM `loan details`
GROUP BY Income_Group
ORDER BY Default_Rate DESC;

#15.Top 10 Applicants with Highest Loan-to-Income Ratio.
SELECT Loan_ID, Income, Amount,Percent_income, 
       ROUND(Amount / Income, 2) AS Loan_Income_Ratio
FROM `loan details`
WHERE Income > 15000
ORDER BY Loan_Income_Ratio DESC
LIMIT 10;

#16.Interest Rate Comparison for Defaults vs Non-Defaults.
SELECT Loan_Default,
       ROUND(AVG(Rate), 2) AS Avg_Rate,
       ROUND(AVG(Amount), 2) AS Avg_Amount
FROM `loan details`
GROUP BY Loan_Default;

#17.Age Group vs Loan Default Rate.
SELECT 
    CASE 
      WHEN Age < 25 THEN 'Young (<25)'
      WHEN Age BETWEEN 25 AND 40 THEN 'Adult (25-40)'
      WHEN Age BETWEEN 41 AND 60 THEN 'Middle Age (41-60)'
      ELSE 'Senior (60+)'
    END AS Age_Group,
    COUNT(*) AS Total,
    SUM(CASE WHEN Loan_Default = 'Y' THEN 1 ELSE 0 END) AS Defaults,
    ROUND(100.0 * SUM(CASE WHEN Loan_Default = 'Y' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Default_Rate
FROM `loan details`
GROUP BY Age_Group;

#18.Loan Approval (Non-Default) Rate by Employment Length and Rate.
#18.1- Employment Length
SELECT Emp_length, 
       COUNT(*) AS Total,
       SUM(CASE WHEN Loan_Default = 0 THEN 1 ELSE 0 END) AS Approved,
       ROUND(100.0 * SUM(CASE WHEN Loan_Default = 0 THEN 1 ELSE 0 END) / COUNT(*), 2) AS Approval_Rate
FROM `loan details`
GROUP BY Emp_length
ORDER BY 
    CASE WHEN Emp_length = 'Unknown' THEN 2 ELSE 1 END, 
    Approval_Rate DESC;

#18.2- Rate
SELECT CASE WHEN Rate = 'NA' THEN 'Unknown/NA'
	ELSE Rate 
    END AS Rate_Group,
    COUNT(*) AS Total,
    SUM(CASE WHEN Loan_Default = 0 THEN 1 ELSE 0 END) AS Approved,
    ROUND(100.0 * SUM(CASE WHEN Loan_Default = 0 THEN 1 ELSE 0 END) / COUNT(*), 2) AS Approval_Rate
FROM `loan details`
GROUP BY Rate_Group
ORDER BY 
    CASE WHEN Rate_Group = 'Unknown/NA' THEN 2 ELSE 1 END,
    Approval_Rate DESC;

#19. above-average loan applicants
SELECT Loan_ID, Amount, Income
FROM `loan details`
WHERE Amount > (SELECT AVG(Amount) FROM `loan details`);

#20.rank applicants by loan amount
SELECT Loan_ID, Amount,
       RANK() OVER (ORDER BY Amount DESC) AS Loan_Rank
FROM `loan details`
LIMIT 10;

#21.the average credit length of applicants who defaulted vs. those who did not

---#Y = Yes, the applicant defaulted on the loan (failed to repay).
   #N = No, the applicant did not default (successfully repaid).
SELECT Loan_Default,
    AVG(Cred_length) AS Avg_Credit_Length
FROM `loan details`
GROUP BY Loan_Default;

#22.queries to add a Primary Key on Loan_ID and create indexes on Intent, Emp_length, and Rate columns in the loan details table.
ALTER TABLE `loan details`
ADD CONSTRAINT pk_loan PRIMARY KEY (Loan_ID);

CREATE INDEX idx_intent ON `loan details` (Intent);
CREATE INDEX idx_emp_length ON `loan details` (Emp_length);
CREATE INDEX idx_rate ON `loan details` (Rate);

select * from `loan details`;


