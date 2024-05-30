SELECT
    PreferredGenre,
	AgeGroup,
    COUNT(*) AS BorrowerCount
FROM
    (
        SELECT
            CASE
                WHEN DATEDIFF(YEAR, b.dateofbirth, GETDATE()) BETWEEN 0 AND 10 THEN '0-10'
                WHEN DATEDIFF(YEAR, b.dateofbirth, GETDATE()) BETWEEN 11 AND 20 THEN '11-20'
                WHEN DATEDIFF(YEAR, b.dateofbirth, GETDATE()) BETWEEN 21 AND 30 THEN '21-30'
                ELSE 'more than 30'
            END AS AgeGroup,
            bo.genre AS PreferredGenre
        FROM
            borrowers AS b
        JOIN
            loans AS l ON b.borrowerid = l.borrowerid
        JOIN
            books AS bo ON l.bookid = bo.bookid
    ) AS AgeGenre
GROUP BY
    AgeGroup, 
    PreferredGenre
HAVING
    COUNT(*) > 0
ORDER BY
    AgeGroup,
    BorrowerCount DESC;