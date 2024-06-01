SELECT borrowerid,
       DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS BorrowingFrequencyRank
FROM loans 
GROUP BY borrowerid;
