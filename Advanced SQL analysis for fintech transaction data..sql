
/* =====================================================
   SECTION A: CUSTOMER INSIGHTS (Beginner)
   ===================================================== */
-- 1. The marketing team wants a full list of all customers.
-- Write a query to retrieve all users data below.
   
   SELECT *
   FROM userz;
   
   
   /* SELECT *
   FROM transactionz AS T
   JOIN userz AS U
	ON T.user_id = U.Id;
    */

-- 2. The company wants to know where customers are located.
-- Show UserID and Country only.

SELECT Id, ResidenceCountry
FROM userz; 

-- 3. Compliance team needs to see all customer countries without duplicates.
   
   SELECT DISTINCT ResidenceCountry
   FROM userz;

-- 4. HR wants to identify customers above age 50 for a senior care program.
   
   SELECT Id, DateOfBirth
   FROM userz 
   WHERE STR_TO_DATE (DateOfBirth ,'%d/%m/%Y') <= '1976-01-01';
       -- GROUP BY id;

-- 5. Find all customers living in Nigeria.
   SELECT id,ResidenceCountry
   FROM userz 
   WHERE ResidenceCountry LIKE '%ni%';
      


/* =====================================================
   SECTION B: TRANSACTION MONITORING
   ===================================================== */

-- 6. Finance team wants to see all transactions.
   
  SELECT *
  FROM transactionz;

-- 7. Show only transaction_id and amount for reporting.
   
   SELECT transaction_id,amount
   FROM transactionz;
   
-- 8. Risk team wants to find all failed transactions.
    SELECT transaction_id,status
	FROM transactionz
    WHERE status = 'Failed';

-- 9. Identify transactions above 300,000  as (high-value transactions).
    SELECT transaction_id,amount AS hightransactions
	FROM transactionz
    WHERE amount > 300000;

-- 10. Find transactions done in USD currency.
   
    SELECT transaction_id,currency
	FROM transactionz
    WHERE currency = 'USD';

/* =====================================================
   SECTION C: FRAUD & RISK ANALYSIS
   ===================================================== */

-- 11. Find failed transactions above 400,000 (potential fraud).
    SELECT transaction_id,amount,status
	FROM transactionz
    WHERE amount > 400000 
		AND status = 'Failed';

-- 12. Find transactions where purpose is 'Airtime' and status is 'failed'.
	SELECT transaction_id,purpose,status
	FROM transactionz
    WHERE purpose = 'Airtime' 
		AND status = 'Failed';

-- 13. Find users NOT living in Canada (for regional restriction analysis).
   SELECT Id,ResidenceCountry
   FROM userz 
   WHERE ResidenceCountry != 'CANADA';

-- 14. Identify transactions that are either failed OR above 500,000.
   SELECT transaction_id,amount,status
	FROM transactionz
    WHERE amount > 500000 
		OR status = 'Failed';

-- 15. Find users who dont use yahoomail.
	
    SELECT *
	FROM userz
    WHERE UserName NOT LIKE '%yahoo.com';
		


/* =====================================================
   SECTION D: SORTING & PRIORITY REPORTS
   ===================================================== */

-- 16. Show top 50 transactions sorted by highest amount first.
    
    SELECT transaction_id,amount
	FROM transactionz
    ORDER BY amount desc
	LIMIT 50;

-- 17. Show customers sorted from oldest to youngest.
	
    SELECT Id,DateOfBirth
	FROM userz
    WHERE STR_TO_DATE (DateOfBirth, '%d/%m/%Y')
    ORDER BY DateOfBirth;

-- 18. Show transactions sorted alphabetically by bank_name.
   
	SELECT transaction_id,bank_name
	FROM transactionz
    ORDER BY bank_name;

/* =====================================================
   SECTION E: BUSINESS METRICS (AGGREGATES)
   ===================================================== */

-- 19. Calculate total revenue generated from all transactions.
		
	SELECT SUM(amount) Total_Revenue
	FROM transactionz;
    
    
-- 20. Count total number of transactions.
	SELECT COUNT(transaction_id) 
	FROM transactionz;

-- 21. Count number of unique users who performed transactions.
   SELECT COUNT(DISTINCT user_id)
	FROM transactionz;

-- 22. Find the average transaction amount.
	SELECT AVG(amount)
	FROM transactionz;

-- 23. Find the highest and lowest transaction amounts.
	SELECT MAX(amount),MIN(amount)
	FROM transactionz;


/* =====================================================
   SECTION F: PERFORMANCE REPORTING (GROUP BY)
   ===================================================== */

-- 24. Calculate total revenue generated per transaction purpose.
	
    SELECT purpose,ROUND(SUM(amount),0)
	FROM transactionz
    GROUP BY purpose
    ORDER BY purpose;
	

-- 25. Count number of transactions per status (success/failed).
	SELECT COUNT(transaction_id),status
	FROM transactionz
    GROUP BY status
    ORDER BY status;

-- 26. Calculate total revenue per bank.
	SELECT ROUND(SUM(amount),0),bank_name
	FROM transactionz
    GROUP BY bank_name
    ORDER BY bank_name;

-- 27. Show monthly revenue trend.
	SELECT ROUND(SUM(amount),0),MONTH(date)
	FROM transactionz
    GROUP BY MONTH(date)
    ORDER BY MONTH(date);


/* =====================================================
   SECTION G: CUSTOMER TARGETING
   ===================================================== */

-- 28. Find customers whose usernames starts with 'L' (target campaign).
	SELECT Id,UserName
	FROM userz
    WHERE UserName LIKE 'L%';
    

-- 29. Find number of users who were created in March 2024 (users reporting).
	SELECT DateCreated, Id
	FROM userz
    WHERE STR_TO_DATE(DateCreated, '%d/%m/%Y') BETWEEN '2024-03-1' AND '2024-03-31'
	ORDER BY DateCreated;
    
-- 30. Find gender breakdown of users who made transactions from all our users .
   
   SELECT U.Gender,COUNT(DISTINCT T.transaction_id)
   FROM transactionz AS T
   JOIN userz AS U
	ON T.user_id = U.Id
    GROUP BY U.Gender;
    
   

-- 31. Find users aged between 25 and 45 and made transactions above 400000.
	
   SELECT U.DateOfBirth,T.transaction_id
   FROM transactionz AS T
   JOIN userz AS U
	ON T.user_id = U.Id
   WHERE STR_TO_DATE(DateOfBirth, '%d/%m/%Y') 
   BETWEEN '1981-01-01' AND '2001-12-31'
   OR T.transaction_id > 400000;
	

-- 32. Find transactions between 50,000 and 300,000.
	SELECT transaction_id,amount
	FROM transactionz
    WHERE amount BETWEEN  50000 AND 300000
    ORDER BY amount;


/* =====================================================
   SECTION H: DATA LABELING (ALIASES & CASE)
   ===================================================== */

-- 33. find the userid and locations of users that were referred. Rename UserID as CustomerID and Country as Location.
    SELECT Id CustomerID,ResidenceCountry Location,ReferredBy
	FROM userz
    WHERE ReferredBy != 'Not Referred';

-- 34. Categorize transactions:
-- High (>400000), Medium (300000–400000), Low (<300000)
   
   SELECT transaction_id,amount,
    CASE
		WHEN amount > 400000 THEN 'High'
        WHEN amount BETWEEN 300000 AND 400000 THEN 'Medium'
        ELSE 'Low' 
        END AS Categorize_transactions
	FROM transactionz;


/* =====================================================
   SECTION I: BUSINESS INTELLIGENCE (JOINS)
   ===================================================== */

-- 35. Show each customer's city alongside their transaction amount.
	SELECT T.amount,T.transaction_id, U.ResidenceCountry
	FROM transactionz AS T
	JOIN userz AS U
	ON T.user_id = U.Id;
   

-- 36. Calculate total revenue generated per country.
   SELECT SUM(T.amount),U.ResidenceCountry
	FROM transactionz AS T
	JOIN userz AS U
	ON T.user_id = U.Id
    GROUP BY U.ResidenceCountry;

-- 37. Count transactions per month and year.
	SELECT COUNT(U.ResidenceCountry), MONTH(U.DateCreated),YEAR(U.DateCreated)
	FROM transactionz AS T
	JOIN userz AS U
	ON T.user_id = U.Id
    GROUP BY U.ResidenceCountry,MONTH(U.DateCreated),YEAR(U.DateCreated);

-- 38. Show all users with no transactions.
    SELECT U.Id,T.transaction_id
	FROM userz AS U
	LEFT JOIN transactionz AS T
		ON T.user_id = U.Id
    WHERE T.transaction_id IS NULL;



/* =====================================================
   SECTION J: ADVANCED ANALYTICS
   ===================================================== */

-- 39. Find custumer with total revenue greater than 300,000 in GBP.
	
    SELECT SUM(amount),T.currency,T.transaction_id
	FROM transactionz AS T
	JOIN userz AS U
	ON T.user_id = U.Id
	WHERE T.currency = 'GBP'
    GROUP BY T.transaction_id,T.currency
    HAVING SUM(amount) > 300000
    ORDER BY SUM(amount) DESC
    ;

-- 40. Find cities with average transaction cost above 400000 in USD.
	SELECT AVG(amount),U.ResidenceCountry
	FROM transactionz AS T
	JOIN userz AS U
	ON T.user_id = U.Id
    GROUP BY U.ResidenceCountry
    HAVING AVG(amount) > 400000;

-- 41. Show top 5 highest transactions by currency.
	SELECT amount,T.currency
	FROM transactionz AS T
	JOIN userz AS U
	ON T.user_id = U.Id
    ORDER BY amount DESC
    LIMIT 5;

-- 42. Find transactions above the average transaction amount by currency.
	SELECT ROUND(AVG(amount),0),T.currency
	FROM transactionz AS T
	JOIN userz AS U
	ON T.user_id = U.Id
    GROUP BY T.currency
    HAVING  ROUND(AVG(amount),0) > 248239;

-- 43. Find users who have made transactions in NGN.
   
	SELECT amount,T.currency,T.transaction_id
	FROM transactionz AS T
	JOIN userz AS U
	ON T.user_id = U.Id
    WHERE T.currency = 'NGN'
    ORDER BY amount;
    

/* =====================================================
   SECTION K: EXECUTIVE DASHBOARD (CHALLENGE)
   ===================================================== */

-- 44. Find top 3 cities generating the highest revenue.
	SELECT SUM(amount),U.ResidenceCountry
	FROM transactionz AS T
	JOIN userz AS U
	ON T.user_id = U.Id
    GROUP BY U.ResidenceCountry
    ORDER BY SUM(amount) DESC
    LIMIT 3;

-- 45. Identify top 5 highest-spending users.
	
	SELECT ROUND(SUM(amount),0), Id
	FROM transactionz AS T
	JOIN userz AS U
	ON T.user_id = U.Id
    GROUP BY Id
    ORDER BY SUM(amount) DESC
    LIMIT 5;

-- 46. Calculate revenue contribution by BANK type.
	
    SELECT ROUND(SUM(amount),0), bank_name
	FROM transactionz AS T
	JOIN userz AS U
	ON T.user_id = U.Id
    GROUP BY bank_name
    ORDER BY ROUND(SUM(amount),0) DESC;

-- 47. Find the month with the highest revenue.
	
    SELECT ROUND(SUM(amount),0), MONTH(date)
	FROM transactionz AS T
	JOIN userz AS U
	ON T.user_id = U.Id
    GROUP BY MONTH(date)
    ORDER BY ROUND(SUM(amount),0) DESC;

-- 48. Identify customers who have never made a transaction.
	
    SELECT U.Id,T.transaction_id
	FROM userz AS U
	LEFT JOIN transactionz AS T
		ON T.user_id = U.Id
    WHERE T.transaction_id IS NULL;

/* =====================================================
   END 
   ===================================================== */
