CREATE FUNCTION GetMostPopularGenreForMonth(@Month INT)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @Genre NVARCHAR(50);
    WITH LoanedGenres AS (
        SELECT
            b.genre,
            COUNT(*) AS GenreCount,
            RANK() OVER (ORDER BY COUNT(*) DESC) AS GenreRank
        FROM
            loans AS l
        JOIN
            books AS b ON l.bookid = b.bookid
        WHERE
            MONTH(l.dateborrowed) = @Month
        GROUP BY
            b.genre
    )
    
    SELECT TOP 1
        @Genre = Genre
    FROM
        LoanedGenres
    WHERE
        GenreRank = 1;

    RETURN @Genre;
END;