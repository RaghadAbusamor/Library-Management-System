declare @_totalBorrowedBooks int =2;
WITH BorrowedBooksCount AS (
    SELECT borrowerid, COUNT(*) AS totalBorrowedBooks
    FROM loans
    WHERE datereturned IS NULL
    GROUP BY borrowerid
)
SELECT borrowerid
FROM BorrowedBooksCount
WHERE totalBorrowedBooks >= @_totalBorrowedBook;