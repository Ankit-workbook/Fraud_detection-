use bank;


select * from transactions

-- number of fraudulent transactions 

 SELECT COUNT(*) AS fraud_count
FROM transactions
WHERE isFraud = 1;

-- common transaction types  for fraud cases

 SELECT type, COUNT(*) AS fraud_count
FROM transactions
WHERE isFraud = 1
GROUP BY type
ORDER BY fraud_count DESC;


--  percentage of fraudulent transactions are above a certain threshold  $10,000

SELECT 
    (COUNT(CASE WHEN amount > 10000 THEN 1 END) * 100.0 / COUNT(*)) AS fraud_percentage_above_10k
FROM transactions
WHERE isFraud = 1;



-- dectecting fraud transactions

    

WITH RECURSIVE fraud_chain as (
SELECT nameOrig as initial_account,
nameDest as next_account,
step,
amount,
newbalanceorig
FROM 
transactions
WHERE isFraud = 1 and type = 'TRANSFER'

UNION ALL 

SELECT fc.initial_account,
t.nameDest,t.step,t.amount ,t.newbalanceorig
FROM fraud_chain fc
JOIN transactions t
ON fc.next_account = t.nameorig and fc.step < t.step 
where t.isfraud = 1 and t.type = 'TRANSFER')

SELECT * FROM fraud_chain;

--Fraud with period of time

with rolling_fraud as ( SELECT nameorig,step, 
SUM(isfraud) OVER (PARTITION BY nameOrig order by STEP ROWS BETWEEN 4 PRECEDING and CURRENT ROW ) as fraud_rolling
FROM transactions)

SELECT * FROM rolling_fraud
WHERE fraud_rolling > 0 ;



--  Complex Fraud Detection Using Multiple CTEs


WITH large_transfers as (
SELECT nameOrig,step,amount FROM transactions WHERE type = 'TRANSFER' and amount >500000),
no_balance_change as (
SELECT nameOrig,step,oldbalanceOrg,newbalanceOrig FROM transactions where oldbalanceOrg=newbalanceOrig),
flagged_transactions as (
SELECT nameOrig,step FROM transactions where  isflaggedfraud = 1) 

SELECT 
    lt.nameOrig
FROM 
    large_transfers lt
JOIN 
    no_balance_change nbc ON lt.nameOrig = nbc.nameOrig AND lt.step = nbc.step
JOIN 
    flagged_transactions ft ON lt.nameOrig = ft.nameOrig AND lt.step = ft.step;



--  Write me a query that checks if the computed new_updated_Balance is the same as the actual newbalanceDest in the table. If they are equal, it returns those rows.

with CTE as (
SELECT amount,nameorig,oldbalancedest,newbalanceDest,(amount+oldbalancedest) as new_updated_Balance 
FROM transactions
)
SELECT * FROM CTE where new_updated_Balance = newbalanceDest;
