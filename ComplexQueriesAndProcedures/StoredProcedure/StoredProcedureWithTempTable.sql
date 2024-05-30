CREATE OR ALTER PROCEDURE sp_GetBorrowersWithOverdueBooks
AS
BEGIN
    SET NOCOUNT ON;

    CREATE TABLE #TempBorrowersWithOverdueBooks (
        BorrowerID INT,
        FirstName VARCHAR(100),
        LastName VARCHAR(100),
        Email VARCHAR(255)
    );

    INSERT INTO #TempBorrowersWithOverdueBooks (BorrowerID, FirstName, LastName, Email)
    SELECT b.BorrowerID, b.FirstName, b.LastName, b.Email
    FROM Borrowers b
    INNER JOIN Loans l ON b.BorrowerID = l.BorrowerID
    WHERE l.DueDate < GETDATE() AND l.DateReturned IS NULL;

    SELECT tbwob.*, b.Title AS OverdueBookTitle, l.DueDate AS DueDate
    FROM #TempBorrowersWithOverdueBooks tbwob
    INNER JOIN Loans l ON tbwob.BorrowerID = l.BorrowerID
    INNER JOIN Books b ON l.BookID = b.BookID
    WHERE l.DueDate < GETDATE() AND l.DateReturned IS NULL;

    DROP TABLE #TempBorrowersWithOverdueBooks;
END;
