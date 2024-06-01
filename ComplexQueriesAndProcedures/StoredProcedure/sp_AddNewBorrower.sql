CREATE PROCEDURE sp_AddNewBorrower
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Email NVARCHAR(255),
    @DateOfBirth DATE,
    @MembershipDate DATE
AS
BEGIN
    DECLARE @BorrowerID INT;
    IF NOT EXISTS (SELECT 1 FROM Borrowers WHERE Email = @Email)
    BEGIN
        INSERT INTO borrowers (FirstName, LastName, Email, DateOfBirth, MembershipDate)
        VALUES (@FirstName, @LastName, @Email, @DateOfBirth, @MembershipDate);
        SET @BorrowerID = SCOPE_IDENTITY();
        SELECT @BorrowerID AS NewBorrowerID;
    END
    ELSE
    BEGIN
        SELECT 'Email already exists. Cannot add duplicate borrower.' AS ErrorMessage;
    END
END;