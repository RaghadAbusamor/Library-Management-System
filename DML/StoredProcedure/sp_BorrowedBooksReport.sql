CREATE PROCEDURE sp_BorrowedBooksReport
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT
        B.Title AS BookTitle,
        B.Author AS BookAuthor,
        BR.FirstName AS BorrowerFirstName,
        BR.LastName AS BorrowerLastName,
        L.DateBorrowed AS DateBorrowed
    FROM
        Loans AS L
    JOIN
        Books AS B ON L.BookID = B.BookID
    JOIN
        Borrowers AS BR ON L.BorrowerID = BR.BorrowerID
    WHERE
        L.DateBorrowed BETWEEN @StartDate AND @EndDate
    ORDER BY
        L.DateBorrowed;
END;