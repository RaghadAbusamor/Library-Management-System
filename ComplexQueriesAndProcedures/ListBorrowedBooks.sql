declare  @BorrowerID int = 22
SELECT *
FROM books b
JOIN loans l ON b.bookid = l.bookid
WHERE l.borrowerid = @BorrowerID;