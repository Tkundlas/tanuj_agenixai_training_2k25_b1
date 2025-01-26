-- First 
SELECT 
    B.Title,
    COUNT(T.BookID) AS IssueCount
FROM 
    Books B
JOIN 
    Transactions T ON B.BookID = T.BookID
GROUP BY 
    B.Title
ORDER BY 
    IssueCount DESC
LIMIT 5;

-- 2nd

SELECT 
    B.Title,
    B.PublicationYear,
    A.Name AS AuthorName
FROM 
    Books B
JOIN 
    Authors A ON B.AuthorID = A.AuthorID
WHERE 
    B.Genre = 'Fantasy'
ORDER BY 
    B.PublicationYear DESC;

--3rd

SELECT 
    C.Name AS CustomerName,
    COUNT(T.CustomerID) AS BooksBorrowed
FROM 
    Customers C
JOIN 
    Transactions T ON C.CustomerID = T.CustomerID
GROUP BY 
    C.Name
ORDER BY 
    BooksBorrowed DESC
LIMIT 3;


--4th

SELECT 
    C.Name AS CustomerName,
    T.IssueDate
FROM 
    Customers C
JOIN 
    Transactions T ON C.CustomerID = T.CustomerID
WHERE 
    T.ReturnDate IS NULL 
    AND T.IssueDate < NOW() - INTERVAL '30 days';

--5th

SELECT 
    A.Name AS AuthorName,
    COUNT(B.BookID) AS BooksWritten
FROM 
    Authors A
JOIN 
    Books B ON A.AuthorID = B.AuthorID
GROUP BY 
    A.Name
HAVING 
    COUNT(B.BookID) > 3;
	
-- 6th

SELECT DISTINCT 
    A.Name AS AuthorName
FROM 
    Authors A
JOIN 
    Books B ON A.AuthorID = B.AuthorID
JOIN 
    Transactions T ON B.BookID = T.BookID
WHERE 
    T.IssueDate >= NOW() - INTERVAL '6 months';

--7th

SELECT 
    COUNT(T.BookID) AS CurrentlyIssuedBooks,
    ROUND((COUNT(T.BookID) * 100.0 / SUM(B.TotalCopies))::numeric, 2) AS PercentageIssued
FROM 
    Books B
LEFT JOIN 
    Transactions T ON B.BookID = T.BookID
WHERE 
    T.ReturnDate IS NULL;

--8th

SELECT 
    TO_CHAR(T.IssueDate, 'YYYY-MM') AS Month,
    COUNT(T.BookID) AS BookCount,
    COUNT(DISTINCT T.CustomerID) AS UniqueCustomerCount
FROM 
    Transactions T
WHERE 
    T.IssueDate >= NOW() - INTERVAL '1 year'
GROUP BY 
    TO_CHAR(T.IssueDate, 'YYYY-MM')
ORDER BY 
    Month;


--9th

CREATE INDEX idx_bookid ON Transactions(BookID);
CREATE INDEX idx_customerid ON Transactions(CustomerID);
CREATE INDEX idx_authorid ON Books(AuthorID);
CREATE INDEX idx_issuedate ON Transactions(IssueDate);

--10th

EXPLAIN SELECT B.Title, COUNT(T.BookID) AS IssueCount
FROM Books B
JOIN Transactions T ON B.BookID = T.BookID
GROUP BY B.Title
ORDER BY IssueCount DESC
LIMIT 5;


