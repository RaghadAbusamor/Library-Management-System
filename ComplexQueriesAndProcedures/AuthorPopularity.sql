SELECT
    b.author AS author,
    COUNT(L.LoanID) AS BorrowingFrequency
FROM
    books AS B
LEFT JOIN
    loans AS l ON b.bookid = l.bookid
GROUP BY
    b.author
ORDER BY
    BorrowingFrequency DESC;