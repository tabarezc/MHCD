
--Checks if All_Classes already exists, drops it if so
--Needs to be dropped first because it has a foreign key
--dependent on Currently_Enrolled_Students
IF OBJECT_ID(N'All_Classes', N'U') IS NOT NULL
DROP TABLE All_Classes
GO

--Checks if Currently_Enrolled_Students exists, drops it if so
IF OBJECT_ID(N'Currently_Enrolled_Students', N'U') IS NOT NULL
DROP TABLE Currently_Enrolled_Students
GO

CREATE TABLE Currently_Enrolled_Students
(
    studentId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    studentName VARCHAR(50) NOT NULL,
    enrolled BIT NOT NULL,
);
GO

CREATE TABLE All_Classes
(
    studentId INT NOT NULL FOREIGN KEY REFERENCES Currently_Enrolled_Students,
    classId INT NOT NULL,
    className VARCHAR(50) NOT NULL,
    PRIMARY KEY(studentId, classId)
);
GO

INSERT INTO Currently_Enrolled_Students
(
 [studentName], [enrolled]
)
VALUES
(
    'Jimmy Smith', 1
),
(
    'Bobby Brown', 0
),
(
    'Ben Wyatt', 0
),
(
    'Rachel Greene', 1
)
GO

INSERT INTO All_Classes
(
 [studentId], [className], [classId]
)
VALUES
(
    1, 'History 101', 1
),
(
    2, 'Sociology 001', 2
),
( 
    3, 'Sociology 001', 2
),
(
    3, 'History 101', 1
),
(
    4, 'History 101', 1
),
(
    4, 'Math 201', 3
)
GO

--This query returns all registered students regardless of enrollment status
--I feel like this would be a useful query to determine to popularity of certain
--courses.
SELECT Currently_Enrolled_Students.studentName, All_Classes.className, Currently_Enrolled_Students.enrolled
FROM Currently_Enrolled_Students
INNER JOIN All_Classes ON Currently_Enrolled_Students.studentId=All_Classes.studentId
GO


--This query selects all classes with no currently enrolled students
--I struggled with this query the most, I had not written SQL in about a year,
--so figuring out how to isolate the classes with no students was a challenge
--I eventually thought of summing the enrolled status
SELECT DISTINCT className
FROM All_Classes as a
INNER JOIN Currently_Enrolled_Students as b ON a.studentId=b.studentId 
GROUP BY className
HAVING SUM(CAST(b.enrolled AS INT))=0
GO

--This query returns the total enrolled students in all the classes
--This query was much easier because the way I returned the previous query
--involved finding the sum of enrolled students, so I just displayed that sum as well
SELECT DISTINCT className,SUM(CAST(b.enrolled AS INT)) as total_enrolled
FROM All_Classes as a
INNER JOIN Currently_Enrolled_Students as b ON a.studentId=b.studentId
GROUP BY className
GO