--------------------------------------- Instructor table ---------------------------------------------------

----- SP SELECT 
CREATE PROCEDURE SelectInstructor
    @Instructor_ID INT = NULL
AS
BEGIN
    IF @Instructor_ID IS NULL
    BEGIN
        SELECT * FROM Instructor;
        PRINT 'Select operation completed successfully.';
    END
    ELSE
    BEGIN
        IF EXISTS (SELECT 1 FROM Instructor WHERE Instructor_ID = @Instructor_ID)
        BEGIN
            SELECT * FROM Instructor WHERE Instructor_ID = @Instructor_ID;
            PRINT 'Select operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Instructor_ID.';
        END
    END
END;

--EXEC SelectInstructor;
--EXEC SelectInstructor @Instructor_ID = 1;
--EXEC SelectInstructor @Instructor_ID = 9999;
GO 
----- SP INSERT
CREATE PROCEDURE InsertInstructor
	@Instructor_ID int,
    @Instructor_Fname VARCHAR(200),
    @Instructor_Lname VARCHAR(200),
    @Instructor_Age INT,
    @Instructor_Gender VARCHAR(200),
    @Salary INT,
    @City VARCHAR(200),
    @Hire_Date DATE,
    @Dept_ID INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Instructor (Instructor_ID , Instructor_Fname, Instructor_Lname, Instuctor_Age, Instructor_Gender, Salary, City, Hire_Date, Dept_ID)
        VALUES (@Instructor_ID ,@Instructor_Fname, @Instructor_Lname, @Instructor_Age, @Instructor_Gender, @Salary, @City, @Hire_Date, @Dept_ID);
        
        PRINT 'Insert operation completed successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the insert operation.';
    END CATCH
END;
/*EXEC InsertInstructor 
	@Instructor_ID = 30 ,
    @Instructor_Fname = 'Kirllos', 
    @Instructor_Lname = 'Mounir', 
    @Instructor_Age = 45, 
    @Instructor_Gender = 'Male', 
    @Salary = 70000, 
    @City = 'New York', 
    @Hire_Date = '2023-08-01', 
    @Dept_ID = 20;*/
GO
----- SP UPDATE 
CREATE PROCEDURE UpdateInstructor
    @Instructor_ID INT,
    @Instructor_Fname VARCHAR(200) = NULL,
    @Instructor_Lname VARCHAR(200) = NULL,
    @Instructor_Age INT = NULL,
    @Instructor_Gender VARCHAR(200) = NULL,
    @Salary INT = NULL,
    @City VARCHAR(200) = NULL,
    @Hire_Date DATE = NULL,
    @Dept_ID INT = NULL
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Instructor WHERE Instructor_ID = @Instructor_ID)
        BEGIN
            UPDATE Instructor
            SET
                Instructor_Fname = COALESCE(@Instructor_Fname, Instructor_Fname),
                Instructor_Lname = COALESCE(@Instructor_Lname, Instructor_Lname),
                Instuctor_Age = COALESCE(@Instructor_Age, Instuctor_Age),
                Instructor_Gender = COALESCE(@Instructor_Gender, Instructor_Gender),
                Salary = COALESCE(@Salary, Salary),
                City = COALESCE(@City, City),
                Hire_Date = COALESCE(@Hire_Date, Hire_Date),
                Dept_ID = COALESCE(@Dept_ID, Dept_ID)
            WHERE Instructor_ID = @Instructor_ID;
            
            PRINT 'Update operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Instructor_ID.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the update operation.';
    END CATCH
END;
/*EXEC UpdateInstructor 
    @Instructor_ID = 1, 
    @Salary = 4000*/
  
/*EXEC UpdateInstructor 
    @Instructor_ID = 9999, 
    @Salary = 75000;*/
GO
----- SP DELETE
CREATE PROCEDURE DeleteInstructor
    @Instructor_ID INT
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Instructor WHERE Instructor_ID = @Instructor_ID)
        BEGIN
            DELETE FROM Instructor WHERE Instructor_ID = @Instructor_ID;
            PRINT 'Delete operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Instructor_ID.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the delete operation.';
    END CATCH
END;
--EXEC DeleteInstructor @Instructor_ID = 30;
GO
--------------------------------------- Exam_Question ---------------------------------------------------

----- SP SELECT 
CREATE PROCEDURE SelectExamQuestion
    @Exam_ID INT = NULL,
    @Question_ID INT = NULL
AS
BEGIN
    IF @Exam_ID IS NULL AND @Question_ID IS NULL
    BEGIN
        SELECT * FROM Exam_Question;
        PRINT 'Select operation completed successfully.';
    END
    ELSE
    BEGIN
        IF EXISTS (SELECT 1 FROM Exam_Question WHERE Exam_ID = @Exam_ID AND Question_ID = @Question_ID)
        BEGIN
            SELECT * FROM Exam_Question WHERE Exam_ID = @Exam_ID AND Question_ID = @Question_ID;
            PRINT 'Select operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Exam_ID and Question_ID.';
        END
    END
END;
--EXEC SelectExamQuestion @Exam_ID = 1, @Question_ID = 34;
GO
----- SP INSERT 
CREATE PROCEDURE InsertExamQuestion
    @Exam_ID INT,
    @Question_ID INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Exam_Question (Exam_ID, Question_ID)
        VALUES (@Exam_ID, @Question_ID);
        
        PRINT 'Insert operation completed successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the insert operation.';
    END CATCH
END;
--EXEC InsertExamQuestion @Exam_ID = 1, @Question_ID = 3;
GO
----- SP UPDATE 

CREATE PROCEDURE UpdateExamQuestion
    @Exam_ID INT,
    @Old_Question_ID INT,
    @New_Question_ID INT
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Exam_Question WHERE Exam_ID = @Exam_ID AND Question_ID = @Old_Question_ID)
        BEGIN
            UPDATE Exam_Question
            SET Question_ID = @New_Question_ID
            WHERE Exam_ID = @Exam_ID AND Question_ID = @Old_Question_ID;
            
            PRINT 'Update operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Exam_ID and Old_Question_ID.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the update operation.';
    END CATCH
END;
--EXEC UpdateExamQuestion @Exam_ID = 1, @Old_Question_ID = 3, @New_Question_ID = 4;
GO
----- SP DELETE


CREATE PROCEDURE DeleteExamQuestion
    @Exam_ID INT,
    @Question_ID INT
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Exam_Question WHERE Exam_ID = @Exam_ID AND Question_ID = @Question_ID)
        BEGIN
            DELETE FROM Exam_Question WHERE Exam_ID = @Exam_ID AND Question_ID = @Question_ID;
            PRINT 'Delete operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Exam_ID and Question_ID.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the delete operation.';
    END CATCH
END;
--EXEC DeleteExamQuestion @Exam_ID = 1, @Question_ID = 4;
GO
--------------------------------------- Freelancing ---------------------------------------------------

----- SP SELECT 

CREATE PROCEDURE SelectFreelanceJob
    @Freelanc_ID INT = NULL
AS
BEGIN
    IF @Freelanc_ID IS NULL
    BEGIN
        SELECT * FROM Freelancing;
        PRINT 'Select operation completed successfully.';
    END
    ELSE
    BEGIN
        IF EXISTS (SELECT 1 FROM Freelancing WHERE Freelanc_ID = @Freelanc_ID)
        BEGIN
            SELECT * FROM Freelancing WHERE Freelanc_ID = @Freelanc_ID;
            PRINT 'Select operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Freelanc_ID.';
        END
    END
END;
--EXEC SelectFreelanceJob @Freelanc_ID = 1;
GO
----- SP INSERT 
CREATE PROCEDURE InsertFreelanceJob
	@Freelanc_ID int,
    @Job_Name VARCHAR(200),
    @Job_Website VARCHAR(200) = NULL,
    @Job_StartDate DATETIME = NULL,
    @Job_Tools VARCHAR(200) = NULL,
    @Feedback_Rating FLOAT = NULL,
    @ST_ID INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Freelancing (Freelanc_ID ,Job_Name, Job_Website, Job_StartDate, Job_Tools, Feedback_Rating, ST_ID)
        VALUES (@Freelanc_ID ,  @Job_Name, @Job_Website, @Job_StartDate, @Job_Tools, @Feedback_Rating, @ST_ID);
        
        PRINT 'Insert operation completed successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the insert operation.';
    END CATCH
END;
/*EXEC InsertFreelanceJob 
	@Freelanc_ID = 501 ,
    @Job_Name = 'Website Development', 
    @Job_Website = 'www.5msat.com', 
    @Job_StartDate = '2024-08-01', 
    @Job_Tools = 'HTML, CSS, JavaScript', 
    @Feedback_Rating = 4.8, 
    @ST_ID = 101;*/
GO
----- SP UPDATE 

CREATE PROCEDURE UpdateFreelanceJob
    @Freelanc_ID INT,
    @Job_Name VARCHAR(200) = NULL,
    @Job_Website VARCHAR(200) = NULL,
    @Job_StartDate DATETIME = NULL,
    @Job_Tools VARCHAR(200) = NULL,
    @Feedback_Rating FLOAT = NULL,
    @ST_ID INT = NULL
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Freelancing WHERE Freelanc_ID = @Freelanc_ID)
        BEGIN
            UPDATE Freelancing
            SET
                Job_Name = COALESCE(@Job_Name, Job_Name),
                Job_Website = COALESCE(@Job_Website, Job_Website),
                Job_StartDate = COALESCE(@Job_StartDate, Job_StartDate),
                Job_Tools = COALESCE(@Job_Tools, Job_Tools),
                Feedback_Rating = COALESCE(@Feedback_Rating, Feedback_Rating),
                ST_ID = COALESCE(@ST_ID, ST_ID)
            WHERE Freelanc_ID = @Freelanc_ID;
            
            PRINT 'Update operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Freelanc_ID.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the update operation.';
    END CATCH
END;

/*EXEC UpdateFreelanceJob 
    @Freelanc_ID = 501, 
    @Job_Name = 'Updated Website Development', 
    @Feedback_Rating = 4.9;*/
GO
----- SP DELETE 


CREATE PROCEDURE DeleteFreelanceJob
    @Freelanc_ID INT
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Freelancing WHERE Freelanc_ID = @Freelanc_ID)
        BEGIN
            DELETE FROM Freelancing WHERE Freelanc_ID = @Freelanc_ID;
            PRINT 'Delete operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Freelanc_ID.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the delete operation.';
    END CATCH
END;
--EXEC DeleteFreelanceJob @Freelanc_ID = 500;
GO

--------------------------------------- Hiring ----------------------------------------------------------
----- SP SELECT 

CREATE PROCEDURE SelectHiring
    @Hiring_ID INT = NULL
AS
BEGIN
    IF @Hiring_ID IS NULL
    BEGIN
        SELECT * FROM Hiring;
        PRINT 'Select operation completed successfully.';
    END
    ELSE
    BEGIN
        IF EXISTS (SELECT 1 FROM Hiring WHERE Hiring_ID = @Hiring_ID)
        BEGIN
            SELECT * FROM Hiring WHERE Hiring_ID = @Hiring_ID;
            PRINT 'Select operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Hiring_ID.';
        END
    END
END;
--EXEC SelectHiring @Hiring_ID = 1;
 
 GO
----- SP INSERT 

CREATE PROCEDURE InsertHiring
	@Hiring_ID int ,
    @Position VARCHAR(200),
    @Hiring_Date DATE,
    @Company VARCHAR(200),
    @Location VARCHAR(200),
    @Hiring_Type VARCHAR(200),
    @ST_ID INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO hiring ( Hiring_ID ,Position, Hiring_Date, Company, Location, Hiring_Type, ST_ID)
        VALUES ( @Hiring_ID, @Position, @Hiring_Date, @Company, @Location, @Hiring_Type, @ST_ID);

        PRINT 'Insert operation completed successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the insert operation.';
    END CATCH
END;
/*EXEC InsertHiring
	@Hiring_ID = 500 ,
    @Position = 'System Analyst',
    @Hiring_Date = '2024-05-15',
    @Company = 'Innovatech',
    @Location = 'Los Angeles',
    @Hiring_Type = 'Contract',
    @ST_ID = 500;*/
GO
----- SP UPDATE 
CREATE PROCEDURE UpdateHiring
    @Hiring_ID INT,
    @Position VARCHAR(200) = NULL,
    @Hiring_Date DATE = NULL,
    @Company VARCHAR(200) = NULL,
    @Location VARCHAR(200) = NULL,
    @Hiring_Type VARCHAR(200) = NULL,
    @ST_ID INT = NULL
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM dbo.hiring WHERE Hiring_ID = @Hiring_ID)
        BEGIN
            UPDATE hiring
            SET
                Position = COALESCE(@Position, Position),
                Hiring_Date = COALESCE(@Hiring_Date, Hiring_Date),
                Company = COALESCE(@Company, Company),
                Location = COALESCE(@Location, Location),
                Hiring_Type = COALESCE(@Hiring_Type, Hiring_Type),
                ST_ID = COALESCE(@ST_ID, ST_ID)
            WHERE Hiring_ID = @Hiring_ID;
            
            PRINT 'Update operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Hiring_ID.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the update operation.';
    END CATCH
END;
/*EXEC UpdateHiring 
    @Hiring_ID = 500  ,
    @Position = 'Lead System Analyst',
    @Location = 'San Diego';*/
GO
----- SP DELETE 

CREATE PROCEDURE DeleteHiring
    @Hiring_ID INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM dbo.hiring
        WHERE Hiring_ID = @Hiring_ID;

        PRINT 'Delete operation completed successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the delete operation.';
    END CATCH
END;
/*EXEC DeleteHiring 
    @Hiring_ID = 500;*/

GO 

---------------------------------Table Student--------------------------------------

--select
CREATE OR ALTER PROC SELECT_STUDENT (@ST_ID INT)
AS
BEGIN
    SELECT * FROM STUDENT WHERE ST_ID = @ST_ID;
END;

exec SELECT_STUDENT 1

GO 

--Insert
--select * from student
CREATE OR ALTER PROCEDURE INSERT_STUDENT 
    @ST_ID INT,
    @ST_SSN VARCHAR(50),
    @ST_NAME VARCHAR(100),
    @ST_AGE INT,
    @ST_CITY VARCHAR(100),
    @ST_GENDER CHAR(1),
    @Branch_ID INT,
    @TRACK_ID FLOAT,
    @MAIL VARCHAR(100),
    @SOCIAL_MEDIA VARCHAR(100),
    @GPA FLOAT,
    @GRADUATION_YEAR FLOAT
AS
BEGIN TRY 
    INSERT INTO STUDENT (ST_ID, ST_SSN, ST_NAME, ST_AGE, ST_CITY, ST_GENDER, Branch_ID, TRACK_ID, MAIL, SocialMedia, GPA, GRADUATION_YEAR) 
    VALUES (@ST_ID, @ST_SSN, @ST_NAME, @ST_AGE, @ST_CITY, @ST_GENDER, @Branch_ID, @TRACK_ID, @MAIL, @SOCIAL_MEDIA, @GPA, @GRADUATION_YEAR);
END TRY 
BEGIN CATCH 
    SELECT 'ERROR';
END CATCH;

GO

--Update

CREATE OR ALTER PROCEDURE UPDATE_STUDENT 
    @ST_ID INT,
    @ST_SSN VARCHAR(50),
    @ST_NAME VARCHAR(100),
    @ST_AGE INT,
    @ST_CITY VARCHAR(100),
    @ST_GENDER CHAR(1),
    @Branch_ID INT,
    @TRACK_ID INT,
    @MAIL VARCHAR(100),
    @SOCIAL_MEDIA VARCHAR(100),
    @GPA FLOAT,
    @GRADUATION_YEAR FLOAT
AS
BEGIN TRY 
    UPDATE STUDENT
    SET 
        ST_SSN = @ST_SSN,
        ST_NAME = @ST_NAME, 
        ST_AGE = @ST_AGE, 
        ST_CITY = @ST_CITY, 
        ST_GENDER = @ST_GENDER,
        Branch_ID = @Branch_ID, 
        TRACK_ID = @TRACK_ID,
        MAIL = @MAIL, 
        SocialMedia = @SOCIAL_MEDIA, 
        GPA = @GPA, 
        GRADUATION_YEAR = @GRADUATION_YEAR
    WHERE ST_ID = @ST_ID;
END TRY 
BEGIN CATCH 
    SELECT 'ERROR';
END CATCH;


GO

--DELETE

CREATE OR ALTER PROCEDURE DELETE_STUDENT 
    @ST_ID INT 
AS 
BEGIN TRY 
    DELETE FROM STUDENT WHERE ST_ID = @ST_ID;
END TRY 
BEGIN CATCH 
    SELECT 'ERROR';
END CATCH;

GO


---------------------------------Table QUESTION--------------------------------------

--SELECT
CREATE  OR ALTER PROCEDURE SelectQuestions @QUESTION_ID INT 
AS
BEGIN
    SELECT * FROM Question WHERE QUESTION_ID= @QUESTION_ID
END;
 
 GO

 --INSERT
CREATE  OR ALTER PROCEDURE InsertQuestion
    @Question_ID INT,
    @Question_Type VARCHAR(50),
    @Question_ModelAnswer VARCHAR(500),
    @Question VARCHAR(500),
    @Course_ID INT
AS
BEGIN TRY 
    INSERT INTO Question (Question_ID, Question_Type, Question_ModelAnswer, Question, Course_ID)
    VALUES (@Question_ID, @Question_Type, @Question_ModelAnswer, @Question, @Course_ID);
END TRY 
BEGIN CATCH 
SELECT 'ERROR'
END CATCH 

GO

--UPDATE
CREATE  OR ALTER PROCEDURE UpdateQuestion
    @Question_ID INT,
    @Question_Type VARCHAR(50),
    @Question_ModelAnswer VARCHAR(200),
	@QUESTION VARCHAR(500),
	@COURSE_ID INT 
AS
BEGIN TRY 
    UPDATE Question
    SET Question_Type = @Question_Type, Question_ModelAnswer = @Question_ModelAnswer, Question=@QUESTION, Course_ID=@COURSE_ID
    WHERE Question_ID = @Question_ID;
END TRY 
BEGIN CATCH 
SELECT 'ERROR'
END CATCH 

GO 

--DELETE
CREATE OR ALTER PROCEDURE DeleteQuestion
    @Question_ID INT
AS
BEGIN TRY 
    DELETE FROM Question WHERE Question_ID = @Question_ID;
END TRY 
BEGIN CATCH 
SELECT 'ERROR'
END CATCH 

GO

---------------------------------Table Student_Course--------------------------------------
--Select
CREATE  OR ALTER PROCEDURE SelectStudentCourses @ST_ID INT, @CRS_ID INT 
AS
    BEGIN TRY
        SELECT * FROM Student_Course WHERE ST_ID =@ST_ID AND CRS_ID=@CRS_ID 
    END TRY
    BEGIN CATCH
      
        SELECT 'ERROR'
          
    END CATCH

GO

--INSERT
CREATE OR ALTER PROCEDURE InsertStudentCourse
    @ST_ID INT,
    @Crs_ID INT,
    @ST_Grade INT,
    @Exam_ID INT
AS
    BEGIN TRY
        INSERT INTO Student_Course (ST_ID, Crs_ID, ST_Grade, Exam_ID)
        VALUES (@ST_ID, @Crs_ID , @ST_Grade, @Exam_ID);
  END TRY
 BEGIN CATCH
   SELECT  'ERROR'
   END CATCH

GO

--UPDATE
CREATE  OR ALTER PROCEDURE UpdateStudentCourse
    @ST_ID INT,
    @CRS_ID INT,
    @ST_Grade INT,
	@EXAM_ID INT
AS
    BEGIN TRY
        UPDATE Student_Course
        SET ST_Grade = @ST_Grade , ST_ID=  @ST_ID, CRS_ID= @CRS_ID, Exam_ID=@EXAM_ID
        WHERE ST_ID = @ST_ID AND CRS_ID = @CRS_ID;
    END TRY
    BEGIN CATCH
      
        SELECT 'ERROR'
           
    END CATCH

GO

-- DELETE
CREATE OR ALTER  PROCEDURE DeleteStudentCourse
    @ST_ID INT,
    @CRS_ID INT
AS

    BEGIN TRY
        DELETE FROM Student_Course WHERE ST_ID = @ST_ID AND CRS_ID = @CRS_ID;
    END TRY
    BEGIN CATCH
     
        SELECT 'ERROR'
           
    END CATCH

GO

---------------------------------Table INSTRUCTOR_COURSE--------------------------------------

-- SELECT
CREATE OR ALTER PROCEDURE SELECT_INSTRUCTOR_COURSE 
    @COURSE_ID INT,
    @INSTRUCTOR_ID INT
AS
BEGIN 
    SELECT * 
    FROM INSTRUCTOR_COURSE 
    WHERE COURSE_ID = @COURSE_ID 
      AND INSTRUCTOR_ID = @INSTRUCTOR_ID;
	  END 

GO

-- INSERT
CREATE OR ALTER PROCEDURE INSERT_INSTRUCTOR_COURSE 
    @COURSE_ID INT,
    @INSTRUCTOR_ID INT
AS
BEGIN TRY 
    INSERT INTO INSTRUCTOR_COURSE (COURSE_ID, INSTRUCTOR_ID)
    VALUES (@COURSE_ID, @INSTRUCTOR_ID);
END TRY 
BEGIN CATCH 
    SELECT 'ERROR';
END CATCH;

GO

--UPDATE
CREATE OR ALTER PROCEDURE UPDATE_INSTRUCTOR_COURSE 
    @COURSE_ID INT,
    @INSTRUCTOR_ID INT
AS
BEGIN TRY 
    UPDATE INSTRUCTOR_COURSE
    SET COURSE_ID = @COURSE_ID, 
        INSTRUCTOR_ID = @INSTRUCTOR_ID
    WHERE COURSE_ID = @COURSE_ID 
      AND INSTRUCTOR_ID = @INSTRUCTOR_ID;
END TRY 
BEGIN CATCH 
    SELECT 'ERROR';
END CATCH;

GO

-- DELETE
CREATE OR ALTER PROCEDURE DELETE_INSTRUCTOR_COURSE 
    @COURSE_ID INT,
    @INSTRUCTOR_ID INT
AS 
BEGIN TRY 
    DELETE FROM INSTRUCTOR_COURSE 
    WHERE COURSE_ID = @COURSE_ID 
      AND INSTRUCTOR_ID = @INSTRUCTOR_ID;
END TRY 
BEGIN CATCH 
    SELECT 'ERROR';
END CATCH;

GO

--------------------------- Table Branch_Track------------------------------
-- Insert
CREATE PROC InsertBranchTrack
    @Branch_ID NVARCHAR(50),
    @Track_ID NVARCHAR(50) 
AS
BEGIN
    INSERT INTO Branch_Track (Branch_ID,  Track_ID)
    VALUES (@Branch_ID, @Track_ID)
END

GO 

--update
CREATE PROC UpdateBranchTrack
    @Branch_ID NVARCHAR(50),
    @Track_ID NVARCHAR(50)
AS
BEGIN
    UPDATE Branch_Track
    SET Track_ID = @Track_ID
    WHERE Branch_ID = @Branch_ID;
END;

GO

-- Delete 
CREATE PROC DeleteBranchTrack
    @Branch_ID NVARCHAR(50)
AS
BEGIN
    DELETE FROM Branch_Track
    WHERE Branch_ID = @Branch_ID;
END;

GO
--------------------------- Table Branch ------------------------------
--INSERT
CREATE PROC InsertBranch
    @Branch_Id NVARCHAR(50),
    @Branch_Name NVARCHAR(50),
	@Address VARCHAR(20),
	@Phone NVARCHAR(50),
	@Num_of_Rooms NVARCHAR(20)  
AS
BEGIN
    INSERT INTO Branches(Branch_Id,  Branch_Name,Address,Phone,Num_of_Rooms)
    VALUES (@Branch_Id, @Branch_Name,@Address,@Phone,@Num_of_Rooms)
END

GO 

--UPDATE
CREATE PROC UpdateBranch
    @Branch_Id NVARCHAR(50),
    @Branch_Name NVARCHAR(50),
    @Address VARCHAR(20),
    @Phone NVARCHAR(50),
    @Num_of_Rooms NVARCHAR(20)
AS
BEGIN
    UPDATE Branches
    SET Branch_Name = @Branch_Name,
        Address = @Address,
        Phone = @Phone,
        Num_of_Rooms = @Num_of_Rooms
    WHERE Branch_Id = @Branch_Id;
END;

GO
--DELETE
CREATE PROC DeleteBranch
    @Branch_Id NVARCHAR(50)
AS
BEGIN
    DELETE FROM Branches
    WHERE Branch_Id = @Branch_Id;
END;

GO 

--------------------------- Table Certification ------------------------------
--INSERT
CREATE PROC InsertCertification
    @Certification_ID NVARCHAR(50),
	@Certification_Name NVARCHAR(50),
      @Certificate_Hour  NVARCHAR(50),
      @Platform NVARCHAR(50),
     @Certificate_URL NVARCHAR(50),
     @Certificate_Date NVARCHAR(50),
      @ST_ID NVARCHAR(50)  
AS
BEGIN
    INSERT INTO Certificate ( Certification_ID,  Certification_Name,Certificate_Hour,Platform,Certificate_URL,Certificate_Date,ST_ID)
    VALUES (@Certification_ID, @Certification_Name,@Certificate_Hour,@Platform,@Certificate_URL,@Certificate_Date,@ST_ID)
END

GO 

--UPDATE
CREATE PROC UpdateCertification
    @Certification_ID NVARCHAR(50),
    @Certification_Name NVARCHAR(50),
    @Certificate_Hour NVARCHAR(50),
    @Platform NVARCHAR(50),
    @Certificate_URL NVARCHAR(50),
    @Certificate_Date NVARCHAR(50),
    @ST_ID NVARCHAR(50)
AS
BEGIN
    UPDATE Certificate
    SET Certification_Name = @Certification_Name,
        Certificate_Hour = @Certificate_Hour,
        Platform = @Platform,
        Certificate_URL = @Certificate_URL,
        Certificate_Date = @Certificate_Date,
        ST_ID = @ST_ID
    WHERE Certification_ID = @Certification_ID;
END;

GO 

--DELETE
CREATE PROC DeleteCertification
    @Certification_ID NVARCHAR(50)
AS
BEGIN
    DELETE FROM Certificate
    WHERE Certification_ID = @Certification_ID;
END;

GO 

--------------------------------------- Choice  table ---------------------------------------------------

----- SP SELECT 
CREATE PROCEDURE SelectChoice
    @Choice_ID INT = NULL
AS
BEGIN
    IF @Choice_ID IS NULL
    BEGIN
        SELECT * FROM Choice;
        PRINT 'Select operation completed successfully.';
    END
    ELSE
    BEGIN
        IF EXISTS (SELECT 1 FROM Choice WHERE Choice_ID = @Choice_ID)
        BEGIN
            SELECT * FROM Choice WHERE Choice_ID = @Choice_ID;
            PRINT 'Select operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Choice_ID.';
        END
    END
END;

GO
----- SP INSERT
CREATE PROCEDURE InsertChoice
    @Choice_ID INT,
    @Question_ID INT,
    @Choice VARCHAR(255)
AS
BEGIN
    BEGIN TRY
        INSERT INTO Choice (Choice_ID, Question_ID, Choice)
        VALUES (@Choice_ID, @Question_ID, @Choice);
        
        PRINT 'Insert operation completed successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the insert operation.';
    END CATCH
END;

GO

----- SP UPDATE 
CREATE PROCEDURE UpdateChoice
    @Choice_ID INT,
    @Question_ID INT = NULL,
    @Choice VARCHAR(255) = NULL
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Choice WHERE Choice_ID = @Choice_ID)
        BEGIN
            UPDATE Choice
            SET
                Question_ID = COALESCE(@Question_ID, Question_ID),
                Choice = COALESCE(@Choice, Choice)
            WHERE Choice_ID = @Choice_ID;
            
            PRINT 'Update operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Choice_ID.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the update operation.';
    END CATCH
END;

GO

----- SP DELETE
CREATE PROCEDURE DeleteChoice
    @Choice_ID INT
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Choice WHERE Choice_ID = @Choice_ID)
        BEGIN
            DELETE FROM Choice WHERE Choice_ID = @Choice_ID;
            PRINT 'Delete operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Choice_ID.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the delete operation.';
    END CATCH
END;

GO

---------------------------------------  Course Table ---------------------------------------------------

----- SP SELECT 
CREATE PROCEDURE SelectCourse
    @Course_ID INT = NULL
AS
BEGIN
    IF @Course_ID IS NULL
    BEGIN
        SELECT * FROM Course;
        PRINT 'Select operation completed successfully.';
    END
    ELSE
    BEGIN
        IF EXISTS (SELECT 1 FROM Course WHERE Course_ID = @Course_ID)
        BEGIN
            SELECT * FROM Course WHERE Course_ID = @Course_ID;
            PRINT 'Select operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Course_ID.';
        END
    END
END;

GO

----- SP INSERT 
CREATE PROCEDURE InsertCourse
    @Course_ID INT,
    @Course_Name VARCHAR(255),
    @Course_Duration INT,
    @Course_Level VARCHAR(50),
    @Topic_ID INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Course (Course_ID, Course_Name, Course_Duration, Course_Level, Topic_ID)
        VALUES (@Course_ID, @Course_Name, @Course_Duration, @Course_Level, @Topic_ID);
        
        PRINT 'Insert operation completed successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the insert operation.';
    END CATCH
END;

GO

----- SP UPDATE 

CREATE PROCEDURE UpdateCourse
    @Course_ID INT,
    @Course_Name VARCHAR(255) = NULL,
    @Course_Duration INT = NULL,
    @Course_Level VARCHAR(50) = NULL,
    @Topic_ID INT = NULL
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Course WHERE Course_ID = @Course_ID)
        BEGIN
            UPDATE Course
            SET
                Course_Name = COALESCE(@Course_Name, Course_Name),
                Course_Duration = COALESCE(@Course_Duration, Course_Duration),
                Course_Level = COALESCE(@Course_Level, Course_Level),
                Topic_ID = COALESCE(@Topic_ID, Topic_ID)
            WHERE Course_ID = @Course_ID;
            
            PRINT 'Update operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Course_ID.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the update operation.';
    END CATCH
END;

GO

----- SP DELETE 
CREATE PROCEDURE DeleteCourse
    @Course_ID INT
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Course WHERE Course_ID = @Course_ID)
        BEGIN
            DELETE FROM Course WHERE Course_ID = @Course_ID;
            PRINT 'Delete operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Course_ID.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the delete operation.';
    END CATCH
END;

GO

--------------------------------------- Department Table ---------------------------------------------------

----- SP SELECT 
CREATE PROCEDURE SelectDepartment
    @Dept_ID INT = NULL
AS
BEGIN
    IF @Dept_ID IS NULL
    BEGIN
        SELECT * FROM Department;
        PRINT 'Select operation completed successfully.';
    END
    ELSE
    BEGIN
        IF EXISTS (SELECT 1 FROM Department WHERE Dept_ID = @Dept_ID)
        BEGIN
            SELECT * FROM Department WHERE Dept_ID = @Dept_ID;
            PRINT 'Select operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Dept_ID.';
        END
    END
END;

GO

----- SP INSERT 
CREATE PROCEDURE InsertDepartment
    @Dept_ID INT,
    @Dept_Name VARCHAR(255),
    @Dept_Location VARCHAR(255),
    @Dept_Description TEXT,
    @Manager_ID INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Department (Dept_ID, Dept_Name, Dept_Location, Dept_Description, Manager_ID)
        VALUES (@Dept_ID, @Dept_Name, @Dept_Location, @Dept_Description, @Manager_ID);
        
        PRINT 'Insert operation completed successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the insert operation.';
    END CATCH
END;

GO
----- SP UPDATE --------------------------------------------------------------------------------------------
CREATE PROCEDURE UpdateDepartment
    @Dept_ID INT,
    @Dept_Name VARCHAR(255) = NULL,
    @Dept_Location VARCHAR(255) = NULL,
    @Dept_Description TEXT = NULL,
    @Manager_ID INT = NULL
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Department WHERE Dept_ID = @Dept_ID)
        BEGIN
            UPDATE Department
            SET
                Dept_Name = COALESCE(@Dept_Name, Dept_Name),
                Dept_Location = COALESCE(@Dept_Location, Dept_Location),
                Dept_Description = COALESCE(@Dept_Description, Dept_Description),
                Manager_ID = COALESCE(@Manager_ID, Manager_ID)
            WHERE Dept_ID = @Dept_ID;
            
            PRINT 'Update operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Dept_ID.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the update operation.';
    END CATCH
END;

GO

----- SP DELETE 
CREATE PROCEDURE DeleteDepartment
    @Dept_ID INT
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Department WHERE Dept_ID = @Dept_ID)
        BEGIN
            DELETE FROM Department WHERE Dept_ID = @Dept_ID;
            PRINT 'Delete operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Dept_ID.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the delete operation.';
    END CATCH
END;

GO

--------------------------------------- Exam Table ----------------------------------------------------------

----- SP SELECT 
CREATE PROCEDURE SelectExam
    @Exam_ID INT = NULL
AS
BEGIN
    IF @Exam_ID IS NULL
    BEGIN
        SELECT * FROM Exam;
        PRINT 'Select operation completed successfully.';
    END
    ELSE
    BEGIN
        IF EXISTS (SELECT 1 FROM Exam WHERE Exam_ID = @Exam_ID)
        BEGIN
            SELECT * FROM Exam WHERE Exam_ID = @Exam_ID;
            PRINT 'Select operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Exam_ID.';
        END
    END
END;

GO

----- SP INSERT 
CREATE PROCEDURE InsertExam
    @Exam_ID INT,
    @Exam_Title VARCHAR(255),
    @Exam_Duration INT,
    @Exam_Date DATE,
    @Quest_Nums INT,
    @Exam_Grade VARCHAR(50),
    @Course_ID INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Exam (Exam_ID, Exam_Title, Exam_Duration, Exam_Date, Quest_Nums, Exam_Grade, Course_ID)
        VALUES (@Exam_ID, @Exam_Title, @Exam_Duration, @Exam_Date, @Quest_Nums, @Exam_Grade, @Course_ID);
        
        PRINT 'Insert operation completed successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the insert operation.';
    END CATCH
END;

GO

----- SP UPDATE 
CREATE PROCEDURE UpdateExam
    @Exam_ID INT,
    @Exam_Title VARCHAR(255) = NULL,
    @Exam_Duration INT = NULL,
    @Exam_Date DATE = NULL,
    @Quest_Nums INT = NULL,
    @Exam_Grade VARCHAR(50) = NULL,
    @Course_ID INT = NULL
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Exam WHERE Exam_ID = @Exam_ID)
        BEGIN
            UPDATE Exam
            SET
                Exam_Title = COALESCE(@Exam_Title, Exam_Title),
                Exam_Duration = COALESCE(@Exam_Duration, Exam_Duration),
                Exam_Date = COALESCE(@Exam_Date, Exam_Date),
                Quest_Nums = COALESCE(@Quest_Nums, Quest_Nums),
                Exam_Grade = COALESCE(@Exam_Grade, Exam_Grade),
                Course_ID = COALESCE(@Course_ID, Course_ID)
            WHERE Exam_ID = @Exam_ID;
            
            PRINT 'Update operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Exam_ID.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the update operation.';
    END CATCH
END;

GO

----- SP DELETE 
CREATE PROCEDURE DeleteExam
    @Exam_ID INT
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Exam WHERE Exam_ID = @Exam_ID)
        BEGIN
            DELETE FROM Exam WHERE Exam_ID = @Exam_ID;
            PRINT 'Delete operation completed successfully.';
        END
        ELSE
        BEGIN
            PRINT 'No records found with the specified Exam_ID.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the delete operation.';
    END CATCH
END;

GO

-------------------------------------**Table Topic**---------------------------------------------
--1- select
CREATE PROCEDURE SelectTopic @topID int
AS
SELECT * 
FROM ITI_GP..Topic
where Topic_ID = @topID

--Execute SelectTopic 80
GO
--2- Insert
CREATE PROCEDURE InsertTopic @topID int, @topName varchar(50)
AS
INSERT INTO ITI_GP..Topic
VALUES (@topID,@topName)

--Execute InsertTopic 80, 'DevOps'
GO
--3- Update
CREATE PROCEDURE UpdateTopic @topID int,@TopName varchar(50)
AS
UPDATE ITI_GP..Topic
SET Topic_Name = @TopName
WHERE Topic_ID=@topID

--EXECUTE UpdateTopic 10,'Programming'
GO
--4- Delete
CREATE PROCEDURE DeleteTopic @topID int
AS
DELETE FROM ITI_GP..Topic
WHERE Topic_ID = @topID

--EXECUTE DeleteTopic 80 
GO


-------------------------------------**Table Track**---------------------------------------------
--1- select
CREATE PROCEDURE SelectTrack @TrackID int
AS
SELECT * 
FROM ITI_GP..Track
where Track_ID = @TrackID

--Execute SelectTrack 15
GO

--2- Insert
CREATE PROCEDURE InsertTrack @TrackID int, @TrackName varchar(50), @SupID int
AS
IF NOT EXISTS (SELECT Instructor_ID FROM ITI_GP..Instructor WHERE Instructor_ID=@SupID)
	BEGIN
	INSERT INTO ITI_GP..Track
	VALUES (@TrackID, @TrackName, @SupID )
	END

--Execute InsertTrack 15, 'DevOps',16
GO
--3- Update
CREATE PROCEDURE UpdateTrack @TrackID int, @TrackName varchar(50), @SupID int
AS
IF NOT EXISTS (SELECT Instructor_ID FROM ITI_GP..Instructor WHERE Instructor_ID=@SupID)
	BEGIN
	UPDATE ITI_GP..Track
	SET Track_Name = @TrackName , Supervisor_ID = @SupID
	WHERE Track_ID = @TrackID
	END
--EXECUTE UpdateTrack 6,'Programming',20
GO
--4- Delete
CREATE PROCEDURE DeleteTrack @trackID int
AS
DELETE FROM ITI_GP..Track
WHERE Track_ID= @trackID

--EXECUTE DeleteTrack 15 
GO

-------------------------------------**Table Track_Course**---------------------------------------------

--1- Select
CREATE PROCEDURE SelectTrackCourses @trackID int
AS
SELECT TC.*, C.Course_Name
FROM ITI_GP..Track_Course TC JOIN ITI_GP..Course C
ON TC.Course_ID = C.Course_ID
WHERE TC.Track_ID = @trackID

--EXECUTE SelectTrackCourses 1
GO
--1- Insert
CREATE PROCEDURE InsertTtrackCourse @trackID int, @CrsID int
AS 
IF EXISTS (SELECT Track_ID FROM ITI_GP..Track WHERE Track_ID = @trackID)
	BEGIN
	IF EXISTS (SELECT Course_ID FROM ITI_GP..Course WHERE Course_ID=@CrsID)
		BEGIN
			INSERT INTO ITI_GP..Track_Course 
			VALUES(@trackID, @CrsID)
		END
	ELSE SELECT 'TRACK OR COURSE ID NOT FOUND' AS ERROR
	END

--EXECUTE InsertTtrackCourse 3,1
GO

--2- UPDATE
CREATE PROCEDURE UpdateTrackCourse @trackID int, @courseID int, @newCourseID int
AS 
BEGIN
    IF EXISTS (SELECT Track_ID FROM ITI_GP..Track WHERE Track_ID = @trackID)
    BEGIN
        IF  EXISTS (SELECT 1 FROM ITI_GP..Course WHERE Course_ID = @newCourseID)
			UPDATE ITI_GP..Track_Course 
			SET Course_ID = @newCourseID
			WHERE Track_ID = @trackID AND Course_ID = @courseID
    END
END

--EXECUTE UpdateTrackCourse 1,11,3
GO
--3- DELETE
CREATE PROCEDURE DeleteTtrackCourse @trackID int, @CrsID int
AS
DELETE FROM ITI_GP..Track_Course
WHERE Track_ID=@trackID AND Course_ID=@CrsID

--EXECUTE DeleteTtrackCourse 3,1
GO

-------------------------------------**Table Track_Course**---------------------------------------------
--1- SELECT
CREATE PROCEDURE SelectStudentExam @StudentID int
AS 
SELECT * FROM ITI_GP..Student_Exam WHERE ST_ID=@StudentID

--EXECUTE SelectStudentExam 1
GO

--2- INSERT
CREATE PROCEDURE InsertStudentExam @sid int, @examID int, @QID int, @QGrade int, @StAnswer varchar(255)
AS 
	IF EXISTS ( SELECT ST_ID FROM ITI_GP..Student WHERE ST_ID=@sid)
		IF EXISTS(SELECT Exam_ID FROM ITI_GP..Exam WHERE Exam_ID=@examID)
			IF EXISTS(SELECT Question_ID FROM ITI_GP..Question WHERE Question_ID=@QID)
				INSERT INTO ITI_GP..Student_Exam
				VALUES( @sid, @examID, @QID, @QGrade, @StAnswer)
	ELSE 
		SELECT 'An error occured in student, exam or question ID' AS Error
--EXECUTE InsertStudentExam 1,1,52,1,'True'
GO

--3- UPDATE
CREATE PROCEDURE UpdateStudentExam @sid int, @examID int, @QID int, @QGrade int, @StAnswer varchar(255)
AS 
	IF EXISTS ( SELECT ST_ID FROM ITI_GP..Student WHERE ST_ID=@sid)
		IF EXISTS(SELECT Exam_ID FROM ITI_GP..Exam WHERE Exam_ID=@examID)
			IF EXISTS(SELECT Question_ID FROM ITI_GP..Question WHERE Question_ID=@QID)
				UPDATE ITI_GP..Student_Exam
				SET Question_Grade= @QGrade, Student_Answer= @StAnswer
				WHERE ST_ID=@sid AND Exam_ID=@examID AND Question_ID=@QID
	ELSE 
		SELECT 'An error occured in student, exam or question ID' AS Error
-- EXECUTE UpdateStudentExam 1,1,52, 0, 'FALSE'
GO

--4- DELETE
CREATE PROCEDURE DeleteStudentExam @sid int, @examID int, @QID int
AS
	DELETE FROM ITI_GP..Student_Exam
	WHERE ST_ID=@sid AND Exam_ID=@examID AND Question_ID= @QID

--EXECUTE DeleteStudentExam 1,1,52




