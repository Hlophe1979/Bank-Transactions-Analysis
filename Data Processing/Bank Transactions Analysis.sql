-- Viewing the entire table to inspect each column
select * from `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data` limit 100;


--A) Exploratory Data Analysis (EDA)

-------------------------------------------------------------------------------------------------------
-- 1. Checking the range of the Date
-------------------------------------------------------------------------------------------------------
SELECT MIN(TransactionDate) AS min_date
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`;
-- Therefore, the first Transaction was made in 02 February 2023

SELECT MAX(TransactionDate) AS max_date
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`;
-- Therefore, the last Transaction was made in 01 January 2024
-- Hence, the range of these transactions is one year

-------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------
--2. Checking the names and number of different transaction locations
-------------------------------------------------------------------------------------------------------
SELECT DISTINCT Location
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`;

SELECT COUNT(DISTINCT Location) AS NumberOfLocations
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`;

-- Therefore, we have 43 different Locations where the Transactions took place
--------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------
--3. Checking the different types of Transactions, Channels and CustomerOccupations
-------------------------------------------------------------------------------------------------------
SELECT DISTINCT TransactionType
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`;

SELECT DISTINCT Channel
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`;

SELECT DISTINCT CustomerOccupation
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`;

--------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------
--4. Checking if the NULLS exist in various columns
-------------------------------------------------------------------------------------------------------
SELECT *
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`
WHERE TransactionType IS NULL
OR TransactionAmount IS NULL
OR AccountBalance IS NULL;
-- Hence, no NULL values exist in these columns
--------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------
--5. Checking the Hour, Day Name and Month Name of each Transaction Date
-------------------------------------------------------------------------------------------------------
SELECT  TransactionDate,
        Hour(TransactionDate) As HourOfTransaction,
        Dayname(TransactionDate) AS DayName,
        Monthname(TransactionDate) AS MonthName
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`;

-- 5.1. Checking the Hour, Day Name and Month Name of each Previous Transaction Date
SELECT PreviousTransactionDate,
        Hour(PreviousTransactionDate) AS PrevTransHour,
        Dayname(PreviousTransactionDate) AS PrevDayName,
        Monthname(PreviousTransactionDate) AS PrevMonthName
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`;
--------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------
--6. Calculating the Total and Average Transaction Amount (Aggregate Functions)
-------------------------------------------------------------------------------------------------------
SELECT SUM(TransactionAmount) AS TotalTransactAmount,
        AVG(TransactionAmount) AS AvgTransactAmount
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`;
--------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------
--7. Checking the Maximum and Minimum Transaction Amoumt
-------------------------------------------------------------------------------------------------------
SELECT Max(TransactionAmount) AS MaxTransactAmount,
        Min(TransactionAmount) AS MinTransactAmount
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`;
--------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------
--8. Checking the highest and Lowest Account Balances 
-------------------------------------------------------------------------------------------------------
SELECT MAX(AccountBalance) AS HighestAccBalance,
        MIN(AccountBalance) AS LowestAccBalance
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`;
--------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------
--9. Getting the Highest and Lowest Transaction Durations
-------------------------------------------------------------------------------------------------------
SELECT MAX(TransactionDuration) AS HighestDuration,
        MIN(TransactionDuration) AS LowestDuration
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`;
--------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------
--10. Getting the Age of the oldest and youngest Customers
-------------------------------------------------------------------------------------------------------
SELECT MAX(CustomerAge) AS OldestCustomer,
        MIN(CustomerAge) AS YoungestCustomer
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`;

-- Therefore, our oldest customer age is 80 and our youngest is 18
--------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------
--11. Getting the number of rows, different Transactions and Accounts
-------------------------------------------------------------------------------------------------------
SELECT  COUNT(*) AS NumberOfRows,
        COUNT(DISTINCT TransactionID) AS NumberOfTransactions,
        COUNT(DISTINCT AccountID) AS NumberOfAccounts
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`;

--------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------
--12. Calculating the number of Transactions Per Customer Occupation
-------------------------------------------------------------------------------------------------------
SELECT CustomerOccupation,
        COUNT(TransactionID)
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`
GROUP BY CustomerOccupation;

--------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------
--13. Calculating the total Transaction Amounts & Number of Transactions Per Customer Occupation
-------------------------------------------------------------------------------------------------------
SELECT CustomerOccupation,
        SUM(TransactionAmount) AS TotalAmountPerOccupation,
        COUNT(TransactionID) AS TotalNumberPerOccupation

FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`
GROUP BY CustomerOccupation;

--------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------
--14. Calculating the total Account Balances Per Customer Occupation
-------------------------------------------------------------------------------------------------------
SELECT CustomerOccupation,
        SUM(AccountBalance) AS TotalBalancePerOccupation
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`
GROUP BY CustomerOccupation;

--------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------
--15. Checking the highest and lowest number of Login Attempts
-------------------------------------------------------------------------------------------------------
SELECT MAX(LoginAttempts) AS HighestLoginAttNumber,
        MIN(LoginAttempts) AS LowestLoginAttNumber
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`;

-- Therefore, the highest number is 5 and the lowest is 1
--------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------
--16. Checking the total Transaction Amounts Per Transaction Type 
-------------------------------------------------------------------------------------------------------
SELECT TransactionType,
        SUM(TransactionAmount) AS TotalTransAmount
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`
GROUP BY TransactionType;

-- Therefore, Debit has the most transaction amount
--------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------
--17. Checking the total number of Transactions Per Transaction Type 
-------------------------------------------------------------------------------------------------------
SELECT TransactionType,
        COUNT(TransactionID) AS NumberOfTransactions
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`
GROUP BY TransactionType;

-- Therefore, Debit has the most transactions
--------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------
--18. Finding out which Location makes the mostnumber of transactions and the highest transaction amount
-------------------------------------------------------------------------------------------------------
SELECT Location,
        COUNT(TransactionID) AS NumberOfTransactions,
        SUM(TransactionAmount) AS SumOfTransactions
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`
GROUP BY Location;

-- Therefore, Fort Worth has made the most transactions and Austin has made the Highest Transaction Amount
--------------------------------------------------------------------------------------------------------\


-------------------------------------------------------------------------------------------------------
--19. Finding out which channel made the most transactions
-------------------------------------------------------------------------------------------------------
SELECT Channel,
        COUNT(TransactionID) AS TransactionsPerChannel
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`
GROUP BY Channel;

-- Therefore, The Branch channel has been used for most transactions
--------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------
--20. Finding out which channel made the most transactions amount, as well as the Average amount per channel
-------------------------------------------------------------------------------------------------------
SELECT Channel,
        SUM(TransactionAmount) AS TotAmountPerChannel,
        AVG(TransactionAmount) AS AvgAmountPerChannel
FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`
GROUP BY Channel;

-- Therefore, The ATM channel has been used for highest transaction amounts
--------------------------------------------------------------------------------------------------------



--B) Data Processing: To gain more insights

SELECT TransactionID,
        AccountID,
        TransactionAmount,
        TransactionDate,
        TransactionType,
        Location,
        Channel,
        CustomerAge,
        CustomerOccupation,
        TransactionDuration,
        LoginAttempts,
        AccountBalance,
        PreviousTransactionDate,

-- Adding columns to enhabce the table for better insights
        Dayname(TransactionDate) AS DayName,
        Monthname(TransactionDate) AS MonthName,
        Dayofmonth(TransactionDate) AS DayOfMonth,
        Hour(TransactionDate) AS HourOfTransaction,
        
        Dayname(PreviousTransactionDate) AS PrevDayName,
        Monthname(PreviousTransactionDate) AS PrevMonthName,
        Dayofmonth(PreviousTransactionDate) AS PrevDayOfMonth,
        Hour(PreviousTransactionDate) AS PrevTransHour,

-- Classifying the Weekdays from Weekends
        CASE
                WHEN Dayname(TransactionDate) IN ('Sunday', 'Sat') THEN 'Weekend'
                ELSE 'Weekday'
        END AS DayClassification,

-- Adding the time buckets column
        CASE
                WHEN date_format(TransactionDate, 'HH:MM:SS') BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
                WHEN date_format(TransactionDate, 'HH:MM:SS') BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
                WHEN date_format(TransactionDate, 'HH:MM:SS') BETWEEN '18:00:00' AND '23:59:59' THEN 'Morning'
                WHEN date_format(TransactionDate, 'HH:MM:SS') BETWEEN '00:00:00' AND '05:59:59' THEN 'Midnight'
        END AS TimeBuckets,

-- Adding the Transaction Amount buckets column 
        CASE
                WHEN TransactionAmount < 100 THEN 'Low Amount'
                WHEN TransactionAmount BETWEEN 100 AND 1000 THEN 'Medium Amount'
                WHEN TransactionAmount > 1000 THEN 'Large Amount'
        END AS TransactionAmountSize,

-- Adding the Age group column
        CASE
                WHEN CustomerAge BETWEEN 18 AND 29 THEN 'Young Adult'
                WHEN CustomerAge BETWEEN 30 AND 39 THEN 'Adult'
                WHEN CustomerAge BETWEEN 40 AND 59 THEN 'Middle Aged'
                WHEN CustomerAge >= 60 THEN 'Senior Citizen'
        END AS Age_group,

-- Adding a Duration span column
        CASE
                WHEN TransactionDuration < 100 THEN 'Short Duration'
                WHEN TransactionDuration BETWEEN 100 AND 200 THEN ' Normal Duration'
                WHEN TransactionDuration > 200 THEN 'Long Duration'
        END AS DurationSpan,

-- Adding a column to classify the number of login attempts
        CASE 
                WHEN LoginAttempts <=2 THEN 'Small'
                WHEN LoginAttempts = 3 THEN 'Medium'
                WHEN LoginAttempts > 3 THEN 'Large'
        END AS LoginAttemptsCount,

-- Adding a High Risk Flag column
        CASE 
                WHEN (TransactionAmountSize = 'Large Amount') AND (DurationSpan = 'Short Duration' OR LoginAttemptsCount ='Large')
                THEN 'High Risk'
                ELSE 'Normal'
        END AS HighRiskFlag

FROM `bank_transactions_analysis`.`transaction_analysis`.`bank_transactions_data`;
