CREATE FUNCTION fn_CalculateOverdueFees
    (
    @LoanID INT
    )
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @OverdueFee DECIMAL(10, 2);
    DECLARE @OverdueDays INT;
    SELECT @OverdueDays = DATEDIFF(DAY, DueDate, GETDATE())
    FROM Loans
    WHERE LoanID = @LoanID;
    IF @OverdueDays <= 0
        SET @OverdueFee = 0;
    ELSE IF @OverdueDays <= 30
        SET @OverdueFee = @OverdueDays * 1.00;
    ELSE
        SET @OverdueFee = (30 * 1.00) + ((@OverdueDays - 30) * 2.00); 
    RETURN @OverdueFee;
END;