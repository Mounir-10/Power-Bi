USE ITI_GP
GO 
----------------------- StudentExamAnswerReport--------------------------
CREATE OR ALTER PROCEDURE StudentExamAnswersReport 
				@examID int,
				@studentID int
AS
	SELECT SE.Exam_ID, E.Exam_Title,se.ST_ID, s.st_name, SE.Question_ID, Q.Question, Q.Question_ModelAnswer, SE.Student_Answer
	FROM Student_Exam SE
	JOIN Question Q
	ON SE.Question_ID = Q.Question_ID
	JOIN Exam E
	ON SE.Exam_ID = E.Exam_ID
	JOIN Student S
	ON SE.ST_ID = S.ST_ID
	WHERE SE.Exam_ID = @examID AND SE.ST_ID=@studentID

--EXECUTE StudentExamAnswersReport 1,1
GO

----------------------- Student_Track--------------------------
CREATE OR ALTER PROC [Studs_track] @track_ID INT
AS
BEGIN
    SELECT distinct s.* , t.Track_Name
           
    FROM Student s
    INNER JOIN Track t   ON t.Track_ID         = s.Track_ID
    
    WHERE t.Track_ID = @track_ID
END

GO

----------------------- Questions_in_Exam--------------------------
/* joins the Exam, Exam_Question, Question, and Choices  Common Table Expression (CTE)*/
Create view Questions_in_Exam
as 
	with Choices 
	as (select Choice_ID, Question_ID, Choice
	from Choice)
	 select e.Exam_ID Exam_ID,q.Question_ID Question_ID
	 ,Question, c1.Choice Choice1, c2.Choice Choice2, isnull(c3.Choice,'') Choice3,
	 isnull(c4.Choice,'') Choice4
		 from Exam e
		 join Exam_Question eq
		 on e.Exam_ID = eq.Exam_ID
		 join Question q
		 on q.Question_ID = eq.Question_ID
		 join Choices c1
		 on c1.Question_ID = q.Question_ID and c1.Choice like '%a)%'
		 join Choices c2
		 on c2.Question_ID = q.Question_ID and c2.Choice like '%b)%'
		  left join Choices c3
		 on c3.Question_ID = q.Question_ID and c3.Choice like '%c)%'
		 left join Choices c4
		 on c4.Question_ID = q.Question_ID and c4.Choice like '%d)%'

GO

Create PROC QuestionsinExam @exam_id int
AS 
BEGIN
    SELECT 
        ROW_NUMBER() OVER (ORDER BY Question ASC) AS RowNumber, 
        Question, Choice1, Choice2, Choice3, Choice4
    FROM Questions_in_Exam
    WHERE Exam_ID = @exam_id
END
GO
----------------------- GetCourseTopic--------------------------
CREATE OR ALTER PROCEDURE [dbo].[GetCourseTopic]
    @CourseID INT
AS
BEGIN
    SELECT 
        C.Course_Name,
        T.Topic_Name
    FROM 
        Course C
    INNER JOIN 
        Topic T ON C.Topic_ID = T.Topic_ID
    WHERE 
        C.Course_ID = @CourseID;
END

GO

----------------------- Grade Report --------------------------
CREATE OR ALTER PROC GradeReport @StudentID int
AS
	SELECT 
		Course.Course_Name, 
		Student_Course.St_Grade, 
		student.ST_name,    
		student.ST_ID AS StudentID
	FROM 
		student 
	INNER JOIN
		Student_Course ON student.ST_ID = Student_Course.st_id 
	INNER JOIN
		Course ON Student_Course.Course_ID = Course.Course_ID
	WHERE 
		student.ST_ID = @StudentID

GO

-----------------------GetInstructorsCourse --------------------------
CREATE OR ALTER PROC GetInstructorsCourse @Instructor int
AS
	SELECT
		Course.Course_Name,
		Instructor_Course.Instructor_ID,
		COUNT(DISTINCT Student_Course.st_id) AS Student_Count
	FROM
		Course
	INNER JOIN
		Instructor_Course ON Course.Course_ID = Instructor_Course.Course_ID
	LEFT JOIN
		Student_Course ON Course.Course_ID = Student_Course.Course_ID
	where Instructor_Course.Instructor_ID=@Instructor
	GROUP BY
		Course.Course_Name,
		Instructor_Course.Instructor_ID