# Fraud_detection

 This sql analysis is designed to analyze banking transactions and identify potential fraudulent activities. The script includes several SQL queries, each targeting specific fraud detection scenarios:​

The Entity-Relationship diagrame is as follows -

![bank_ERD](https://github.com/user-attachments/assets/ba24612d-d86c-4b76-a081-569c13f3dcfd)



**Detecting Fraudulent Transaction Chains:** This section utilizes a recursive common table expression (CTE) named fraud_chain to trace sequences of fraudulent transactions. It starts by selecting transactions marked as fraudulent (isFraud = 1) and of type 'TRANSFER'. The recursive part then joins these transactions to subsequent ones where the destination account of a prior transaction matches the origin account of a new transaction, effectively building a chain of related fraudulent transfers.


**Identifying Accounts with Recent Fraudulent Activity**: The rolling_fraud CTE calculates a rolling sum of fraudulent transactions over a window of five consecutive transaction steps for each originating account. This helps in identifying accounts that have been involved in fraudulent activities within recent transactions.


**Detecting Large Transfers Followed by Small Transactions:** This part identifies accounts that perform large transfers followed by smaller transactions within a short time frame, which can be indicative of fraudulent behavior. It uses multiple CTEs to first select large transfers and then find subsequent smaller transactions from the same account within a defined step range.


These queries leverage advanced SQL techniques, such as **recursive CTEs and window functions**, to uncover patterns and anomalies in transaction data that may signify fraudulent activities. By analyzing transaction sequences, rolling sums of fraud occurrences, and patterns of large and small transactions, the script aims to provide a comprehensive approach to fraud detection in banking operations.
