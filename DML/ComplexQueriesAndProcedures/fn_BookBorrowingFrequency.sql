CREATE FUNCTION fn_BookBorrowingFrequency(@BookID INT)
RETURNS INT
AS
BEGIN
    DECLARE @BorrowingCount INT;
    SELECT @BorrowingCount = COUNT(*) 
    FROM loans
    WHERE bookid = @BookID;
    RETURN @BorrowingCount;
END;