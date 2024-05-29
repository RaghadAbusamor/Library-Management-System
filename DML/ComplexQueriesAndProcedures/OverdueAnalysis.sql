SELECT
    b.title AS BookTitle,
    B.Author AS BookAuthor,
    B.ISBN AS BookISBN,
    BR.FirstName AS BorrowerFirstName,
    BR.LastName AS BorrowerLastName,
    L.DateBorrowed AS DateBorrowed,
    L.DueDate AS DueDate,
    DATEDIFF(day, L.DueDate, GETDATE()) AS DaysOverdue
FROM
    Loans AS L
JOIN
    Books AS B ON L.BookID = B.BookID
JOIN
    Borrowers AS BR ON L.BorrowerID = BR.BorrowerID
WHERE DATEDIFF(day, L.DueDate, GETDATE()) > 30;