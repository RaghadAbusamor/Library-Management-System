    --First Step: Aggregate Loan Data by Day of the Week: Write a SQL query to count the number of loans for each day of the week.
    --Second Step: Calculate Percentage of Loans for Each Day: Calculate the percentage of loans for each day by dividing the number of loans for each day by the total number of loans and multiplying by 100.
    --Third Step: Sort and Display Results: Sort the results by the percentage of loans in descending order and display the top 3 days with their respective percentages.

DECLARE @TotalLoans INT;
SELECT @TotalLoans = COUNT(*)
FROM Loans;

WITH LoansByDayOfWeek AS (
    SELECT
        DATEPART(WEEKDAY, DateBorrowed) AS DayOfWeek,
        COUNT(*) AS NumLoans,
        CAST(COUNT(*) AS DECIMAL) / @TotalLoans * 100 AS Percentage
    FROM Loans
    GROUP BY DATEPART(WEEKDAY, DateBorrowed)
),
OrderedLoans AS (
    SELECT
        DayOfWeek,
        NumLoans,
        Percentage,
        ROW_NUMBER() OVER (ORDER BY NumLoans DESC) AS Rank
    FROM LoansByDayOfWeek
)
SELECT
    CASE DayOfWeek
        WHEN 1 THEN 'Sunday'
        WHEN 2 THEN 'Monday'
        WHEN 3 THEN 'Tuesday'
        WHEN 4 THEN 'Wednesday'
        WHEN 5 THEN 'Thursday'
        WHEN 6 THEN 'Friday'
        WHEN 7 THEN 'Saturday'
    END AS DayOfWeek,
    NumLoans,
    Percentage
FROM OrderedLoans
WHERE Rank <= 3
ORDER BY Rank;
