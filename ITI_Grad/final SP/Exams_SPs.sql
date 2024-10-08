USE [ITI_GP]
GO
/****** Object:  StoredProcedure [dbo].[GenerateExam]    Script Date: 8/24/2024 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE or alter proc [dbo].[GenerateExam]
    @Exam_Title NVARCHAR(100),
    @Exam_Duration INT,
    @Exam_Date DATE,
    @Exam_Grade DECIMAL(5,2),
    @Course_Title NVARCHAR(100), -- Course title to retrieve Course_ID
    @Quest_Nums INT =10       -- Optional parameter for number of questions, default is 10
AS
BEGIN
    -- Variables to hold the new Exam_ID and Course_ID
    DECLARE @Exam_ID INT;
    DECLARE @Course_ID INT;

    -- Retrieve the Course_ID based on the provided Course_Title
    SELECT @Course_ID = Course_ID
    FROM Course
    WHERE Course_Name = @Course_Title;

    -- Check if Course_ID was found
    IF @Course_ID IS NULL
    BEGIN
        PRINT 'Course not found for the provided title.'
        RETURN;
    END

    -- Determine the next Exam_ID by finding the maximum existing ID and incrementing
    SELECT @Exam_ID = ISNULL(MAX(Exam_ID), 0) + 1 FROM Exam;

    -- Insert a new exam record
    INSERT INTO Exam (Exam_ID, Exam_Title, Exam_Duration, Exam_Date, Quest_Nums, Exam_Grade, Course_ID)
    VALUES (@Exam_ID, @Exam_Title, @Exam_Duration, @Exam_Date, @Quest_Nums, @Exam_Grade, @Course_ID);

    -- Generate a random set of questions for the exam
    INSERT INTO Exam_Question (Exam_ID, Question_ID)
    SELECT TOP (@Quest_Nums) @Exam_ID, Question_ID
    FROM Question
    WHERE Course_ID = @Course_ID
    ORDER BY NEWID();  -- Randomize the selection

    -- Return the new Exam_ID and the number of questions selected
    SELECT @Exam_ID AS NewExamID, @Quest_Nums AS NumberOfQuestions;
END;

/*EXEC GenerateExam
    @Exam_Title = 'Midterm Exam',
    @Exam_Duration = 60,       -- Duration in minutes
    @Exam_Date = '2024-10-15', -- Exam date
    @Exam_Grade = 100.00,      -- Maximum grade
    @Course_Title = 'Database', -- Course title to retrieve Course_ID
    @Quest_Nums = 10;     */  

GO




/****** Object:  StoredProcedure [dbo].[Exam Answer]    Script Date: 8/25/2024 ******/

SET ANSI_NULLS ON
GO
CREATE OR ALTER PROCEDURE Exam_Answer
    @student_Id INT,
    @exam_Id INT,
    @question_ID INT,
    @Student_Answer VARCHAR(MAX)
AS 
BEGIN
    -- Check if the Exam_ID exists in the Exam table
    IF NOT EXISTS (SELECT 1 FROM Exam WHERE Exam_ID = @exam_Id)
    BEGIN
        PRINT'Exam ID does not exist.'
        RETURN;
    END

    -- Check if the Question_ID exists and is associated with the provided Exam_ID
    IF NOT EXISTS (
        SELECT 1 
        FROM Exam_Question 
        WHERE Exam_ID = @exam_Id AND Question_ID = @question_ID
    )
    BEGIN
        PRINT'Question ID does not exist for the given Exam ID.'
        RETURN;
    END

    -- Insert the student's answer into the Student_Exam table
    INSERT INTO Student_Exam (st_id, Exam_ID, Question_ID, Student_Answer, Question_Grade)
    VALUES (@student_Id, @exam_Id, @question_ID, @Student_Answer, 0);
END
GO

/*exec Exam_Answer 
    @student_Id =3,
    @exam_Id =18,
    @question_ID =15,
    @Student_Answer ='c) Variable names cannot start with a digit'
exec Exam_Answer 
    @student_Id =3,
    @exam_Id =18,
    @question_ID =14,
    @Student_Answer ='b) Variable names cannot start with a digit'
exec Exam_Answer 
    @student_Id =3,
    @exam_Id =18,
    @question_ID =13,
    @Student_Answer ='b) Variable names cannot start with a digit'
exec Exam_Answer 
    @student_Id =3,
    @exam_Id =18,
    @question_ID =12,
    @Student_Answer ='c) Dennis Ritchie'*/


/****** Object:  StoredProcedure [dbo].[ExamCorrection]    Script Date: 8/25/2024 ******/
Create or alter PROCEDURE ExamCorrection @exam_id INT, @student_id INT

AS
	BEGIN TRY
		----Store the model answer for each question compared to the Student answer---
		DECLARE @correctAns TABLE (Qid int, ModelAns varchar(100), userAns varchar(100))
		INSERT @correctAns(Qid, ModelAns, userAns)
		SELECT Q.Question_ID, Question_ModelAnswer, SE.Student_Answer
		FROM Student_Exam As SE, Question AS Q
		WHERE SE.Question_ID= Q.Question_ID AND ST_ID = @student_id AND Exam_ID = @exam_id

		------Set the grade for the correct answers-------
		UPDATE Student_Exam
		SET Question_Grade= 1
		WHERE Question_ID IN
		(
			SELECT Qid FROM @correctAns
			WHERE ModelAns = userAns
			AND ST_ID = @student_id AND Exam_ID = @exam_id
		) and ST_ID = @student_id AND Exam_ID = @exam_id

		---------Set the null values by zero--------------
		UPDATE Student_Exam
		SET Question_Grade = 0 
		WHERE Question_ID not IN
			(SELECT Qid FROM @correctAns
			WHERE ModelAns = userAns
			AND ST_ID = @student_id AND Exam_ID = @exam_id
			)and ST_ID = @student_id AND Exam_ID = @exam_id

		---------Compute student final grade--------------
		DECLARE @StudentDegree FLOAT  = (SELECT SUM(Question_Grade) FROM Student_Exam
										  WHERE ST_ID  = @student_id AND Exam_ID = @exam_id )
		DECLARE @ExamDegree FLOAT = (SELECT COUNT(Question_ID) FROM Exam_Question
								   	   WHERE Exam_ID = @exam_id
									   Group by Exam_ID )
		DECLARE @Student_percentage FLOAT = (@StudentDegree/@ExamDegree) * 100
		

		IF(@Student_percentage IS NULL)
		BEGIN
			SELECT 'Student Did not take this exam' as Caution
			RETURN
		END

		--- update the new info
		UPDATE Student_Course
		SET St_Grade= @Student_percentage ,Exam_id =@exam_id
		WHERE ST_ID = @student_id AND Course_ID = (select Course_ID from Exam where exam_id= @exam_id)

		--- preview student grade in the exam id
		SELECT sc.st_id, s.st_name, sc.Exam_ID, ex.Exam_Title, sc.Course_ID, c.Course_Name, sc.St_Grade
		FROM Student_Course sc 
		JOIN Student s  
		on sc.st_id = s.st_id
			AND sc.st_id = @student_id
		JOIN Exam ex
		on sc.Exam_ID = ex.Exam_ID
			AND sc.Exam_ID = @exam_id
		JOIN Course c
		on sc.Course_ID = c.Course_ID
	END TRY
	BEGIN CATCH
		SELECT 'Error in Correcting Exam!!' AS Error
	END CATCH

/*exec ExamCorrection
@exam_id=18,
@student_id =3*/

