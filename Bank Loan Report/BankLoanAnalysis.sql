create database BankLoanDB;
use BankLoanDB;

create table bank_loan_data(
	id int primary key,
    address_state varchar(50),
    application_type varchar(50),
    emp_length varchar(50),
    emp_title varchar(100),
    grade varchar(50),
    home_ownership varchar(50),
    issue_date date,
    last_credit_pull_date date,
	last_payment_date date,
	loan_status varchar(50) not null,
	next_payment_date date,
	member_id int,
	purpose varchar(50),
	sub_grade varchar(50),
	term varchar(50),
	verification_status varchar(50),
	annual_income float,
	dti float,
	installment float,
	int_rate float,
	loan_amount int,
	total_acc int,
	total_payment int
);

select * from bank_loan_data;


-- 1. Total Loan Applications
SELECT COUNT(*) AS Total_Applications FROM bank_loan_data;

-- 2. MTD Loan Applications
SELECT MONTH(issue_date), MONTHNAME(issue_date), COUNT(*) AS Total_Applications FROM bank_loan_data
GROUP BY MONTH(issue_date), MONTHNAME(issue_date)
ORDER BY MONTH(issue_date);

-- 3. Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data;

-- 4. MTD Total Funded Amount
SELECT MONTH(issue_date), MONTHNAME(issue_date), SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data
GROUP BY MONTH(issue_date), MONTHNAME(issue_date)
ORDER BY MONTH(issue_date);

-- 5. Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data;

-- 6. MTD Total Amount Received
SELECT MONTH(issue_date), MONTHNAME(issue_date), SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data
GROUP BY MONTH(issue_date), MONTHNAME(issue_date)
ORDER BY MONTH(issue_date);

-- 7. Average Interest Rate
SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM bank_loan_data;

-- 8. MTD Average Interest
SELECT MONTH(issue_date), MONTHNAME(issue_date), AVG(int_rate)*100 AS MTD_Avg_Int_Rate FROM bank_loan_data
GROUP BY MONTH(issue_date), MONTHNAME(issue_date)
ORDER BY MONTH(issue_date);

-- 9. Avg DTI
SELECT AVG(dti)*100 AS Avg_DTI FROM bank_loan_data;

-- 10. MTD Avg DTI
SELECT MONTH(issue_date), MONTHNAME(issue_date), AVG(dti)*100 AS MTD_Avg_DTI FROM bank_loan_data
GROUP BY MONTH(issue_date), MONTHNAME(issue_date)
ORDER BY MONTH(issue_date);

-- 11. Good Loan Percentage
SELECT (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data;

-- 12. Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- 13. Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- 14. Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- 15. Bad Loan Percentage
SELECT (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data;

-- 16. Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- 17. Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- 18. Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- 19. Loan Status Amount
SELECT loan_status, COUNT(id) AS LoanCount, SUM(total_payment) AS Total_Amount_Received,
		SUM(loan_amount) AS Total_Funded_Amount, AVG(int_rate * 100) AS Interest_Rate, AVG(dti * 100) AS DTI
FROM bank_loan_data
GROUP BY loan_status;

-- 20. Monthy Loan Status Amount
SELECT loan_status, SUM(total_payment) AS MTD_Total_Amount_Received, SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status;

-- BANK LOAN REPORT
-- Monthly
SELECT MONTH(issue_date) AS Month_Munber, MONTHNAME(issue_date) AS Month_name, COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount, SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), MONTHNAME(issue_date)
ORDER BY MONTH(issue_date);

-- State
SELECT address_state AS State, COUNT(id) AS Total_Loan_Applications, SUM(loan_amount) AS Total_Funded_Amount, SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state;

-- TERM Wise
SELECT term AS Term, COUNT(id) AS Total_Loan_Applications, SUM(loan_amount) AS Total_Funded_Amount, SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term;

-- Employment length
SELECT emp_length AS Employee_Length, COUNT(id) AS Total_Loan_Applications, SUM(loan_amount) AS Total_Funded_Amount, SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length;

-- PURPOSE
SELECT purpose AS PURPOSE, COUNT(id) AS Total_Loan_Applications, SUM(loan_amount) AS Total_Funded_Amount, SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose;

-- HOME OWNERSHIP
SELECT home_ownership AS Home_Ownership, COUNT(id) AS Total_Loan_Applications, SUM(loan_amount) AS Total_Funded_Amount, SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership;