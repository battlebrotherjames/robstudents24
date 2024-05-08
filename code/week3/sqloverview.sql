USE datawinter;
SELECT * FROM student;

SELECT lname
,      fname
,	   major
FROM   student;

SELECT COUNT(major) AS 'Count'
,      major
FROM   student
GROUP BY major
ORDER BY COUNT(major) DESC;
-- WHERE  major = 'Data Science';