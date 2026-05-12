# Fintech Data Analysis User Transaction Insights
Advanced SQL analysis for fintech transaction data.

## Project Overview
This project involves analyzing a dataset of 1,000 users and 5,000 transactions. The goal was to extract business intelligence, identify high value customers, and monitor transaction success rates using complex SQL queries involving Joins, Aggregations, and Case Logic.

## Key Business Objectives
Customer Segmentation: Identifying senior citizens (50+) and high-value investors.
Revenue Analysis: Calculating total revenue by country, currency, and purpose.
Risk Monitoring: Tracking failed transactions and identifying "silent" users with no activity.
Data Professionalism: Cleaning inconsistent date formats and creating readable reporting aliases.

## Technical Skillset Demonstrated
Data Wrangling: Using STR_TO_DATE and TIMESTAMPDIFF to handle nonstandard date formats.

Conditional Logic: Implementing CASE statements for transaction tiering (High/Medium/Low).

Relational Mapping: Executing INNER JOIN and LEFT JOIN to connect user demographics with financial activity.

Advanced Filtering: Utilizing HAVING, LIKE wildcards, and BETWEEN for granular reporting.

## Database Schema Summary
userz Table: Contains Id, UserName, ResidenceCountry, DateOfBirth, Email, and Gender.
transactionz Table: Contains transaction_id, user_id, amount, currency, purpose, and status.

## Conclusion
Through this project, I transformed raw Fintech data into an Executive Dashboard format. I successfully solved 48+ business queries, ensuring 100% data accuracy and optimizing query performance through specific filtering and joining techniques.
