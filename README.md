



**Project Overview**


This sql analysis is designed to analyze banking transactions and identify potential fraudulent activities. The script includes several SQL queries, each targeting specific fraud detection scenario

This report presents an in-depth SQL analysis of banking transactions to identify potential fraudulent activities. It utilizes advanced SQL techniques, including recursive Common Table Expressions (CTEs) and window functions, to uncover transaction patterns indicative of fraud.

**Entity-Relationship**
Entity-Relationship Diagram![bank_ERD](https://github.com/user-attachments/assets/88206a5b-2e8f-4113-b55d-70f15559c4ef)

This is a database table schema named transactions. It represents financial transactions, likely from a banking or fraud detection system. The table contains the following columns:
step (INT) – Represents a time step or transaction sequence.

type (VARCHAR(20)) – Type of transaction (e.g., CASH-IN, CASH-OUT, TRANSFER, DEBIT).

amount (DECIMAL(15,2)) – The amount involved in the transaction.

nameOrig (VARCHAR(20)) – The identifier for the account initiating the transaction.

oldbalanceOrg (DECIMAL(15,2)) – The sender’s balance before the transaction.

newbalanceOrig (DECIMAL(15,2)) – The sender’s balance after the transaction.

nameDest (VARCHAR(20)) – The identifier for the recipient account.

oldbalanceDest (DECIMAL(15,2)) – The recipient’s balance before the transaction.

newbalanceDest (DECIMAL(15,2)) – The recipient’s balance after the transaction.

isFraud (TINYINT) – Indicates if the transaction is fraudulent (1 = fraud, 0 = not fraud).

isFlaggedFraud (TINYINT) – Flags suspicious transactions based on predefined fraud detection rules (1 = flagged, 0 = not flagged).

**Key Findings**
Our analysis revealed several significant patterns and insights regarding banking fraud strategy. The following are the most notable findings from our research:

**Detecting Fraudulent Transaction Chains**
This section utilizes a recursive common table expression (CTE) named fraud_chain to trace sequences of fraudulent transactions. It starts by selecting transactions marked as fraudulent (isFraud = 1) and of type TRANSFER. The recursive part then joins these transactions to subsequent ones where the destination account of a prior transaction matches the origin account of a new transaction, effectively building a chain of related fraudulent transfers.

**Identifying Accounts with Recent Fraudulent Activity**
The rolling_fraud CTE calculates a rolling sum of fraudulent transactions over a window of five consecutive transaction steps for each originating account. This helps in identifying accounts that have been involved in fraudulent activities within recent transactions.

**Detecting Large Transfers Followed by Small Transactions**
This part identifies accounts that perform large transfers followed by smaller transactions within a short time frame, which can be indicative of fraudulent behavior. It uses multiple CTEs to first select large transfers and then find subsequent smaller transactions from the same account within a defined step range.

**Fraud Detection Data Reports**
Download Fraud Count Report (fraud_count.csv)
Download Fraud Type Report (fraud_type.csv)
**Key Findings & Insights**
After analyzing the banking transaction dataset, several key findings have emerged regarding fraudulent activities. These findings provide valuable insights into patterns of fraud and potential vulnerabilities in the financial system.

**1. Fraudulent Transaction Chains**
Deploy machine learning models that analyze transaction patterns and flag suspicious activities in real time.
Use anomaly detection techniques to identify transactions that deviate from normal behavior.
**Strengthen Account Monitoring**
Flag high-risk accounts with a history of fraudulent transactions.
Implement a cool-down period for accounts involved in multiple large transactions within a short time.
**Enforce Transaction Limits and Verification Steps**
Restrict large transfers beyond a certain threshold unless additional verification is provided (e.g., OTP, biometric authentication).
Apply stricter verification for TRANSFER and CASH_OUT transactions, as these are most prone to fraud.
**Introduce Recursive Fraud Chain Analysis**
Regularly run recursive fraud detection queries to trace fraudulent transaction chains.
If an account is part of a fraud chain, automatically freeze suspicious accounts for further investigation.



**Conclusion**

By leveraging advanced SQL techniques, we identified key fraud patterns such as transaction chains, layering, and balance mismatches. To mitigate these risks, implementing real-time fraud detection systems, transaction limits, and stricter verification is essential. Regular fraud monitoring and recursive transaction tracking can significantly reduce fraudulent activities and enhance banking security.










[fraud_count.csv](https://github.com/user-attachments/files/19401027/fraud_count.csv)

These queries leverage advanced SQL techniques, such as **recursive CTEs and window functions**, to uncover patterns and anomalies in transaction data that may signify fraudulent activities. By analyzing transaction sequences, rolling sums of fraud occurrences, and patterns of large and small transactions, the script aims to provide a comprehensive approach to fraud detection in banking operations.

[fraud_type.csv](https://github.com/user-attachments/files/19401030/fraud_type.csv)




![Screenshot 2025-03-22 111529](https://github.com/user-attachments/assets/8e25652b-d37f-4604-8130-3feca389dbc5)



![Screenshot 2025-03-22 111245](https://github.com/user-attachments/assets/6e9e5888-070b-499b-91b6-12f097646d00)


![Screenshot 2025-03-22 112254](https://github.com/user-attachments/assets/fdadc606-827f-4fbd-878b-e6b32f3a185b)


[heavy_transactions.csv](https://github.com/user-attachments/files/19401034/heavy_transactions.csv)fraud_percentage_above_10k
96.61512

