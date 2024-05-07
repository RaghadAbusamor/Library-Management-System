IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'AuditLog')
BEGIN
    CREATE TABLE AuditLog (
        LogID INT PRIMARY KEY IDENTITY(1,1),
        BookID INT,
        StatusChange VARCHAR(20),
        ChangeDate DATETIME
    );
END
GO

CREATE OR ALTER TRIGGER trg_LogStatusChange
ON books
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(CurrentStatus)
    BEGIN
        DECLARE @BookID INT, @OldStatus VARCHAR(20), @NewStatus VARCHAR(20);
        SELECT @BookID = i.BookID, @OldStatus = d.CurrentStatus, @NewStatus = i.CurrentStatus
        FROM inserted i
        INNER JOIN deleted d ON i.BookID = d.BookID;

        IF @OldStatus <> @NewStatus
        BEGIN
            INSERT INTO AuditLog (BookID, StatusChange, ChangeDate)
            VALUES (@BookID, CONCAT(@OldStatus, ' to ', @NewStatus), GETDATE());
        END
    END
END;
GO
