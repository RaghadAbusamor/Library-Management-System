declare  @BorrowerID int = 22
SELECT b.title, b.author,b.isbn, l.dateborrowed, l.duedate, l.datereturned
FROM books b
JOIN loans l ON b.bookid = l.bookid
WHERE l.borrowerid = @BorrowerID;