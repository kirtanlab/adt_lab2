-- Connect to SQL Server in Docker
-- First, let's create the required database (replace FirstName with your name)
CREATE DATABASE KirtanADTLab3;
GO

USE KirtanADTLab3;
GO

-- Create the Student table
CREATE TABLE KirtanStudents (
    StudentID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100),
    TotalCredits INT
);
GO

-- Create the Course table
CREATE TABLE KirtanCourses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Instructor VARCHAR(100),
    CourseCredits INT,
    AvailableSeats INT
);
GO

-- Create the StudentRegistration table
CREATE TABLE KirtanStudentRegistration (
    RegistrationID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT FOREIGN KEY REFERENCES KirtanStudents(StudentID),
    CourseID INT FOREIGN KEY REFERENCES KirtanCourses(CourseID)
);
GO

-- Insert sample data into Students table
INSERT INTO KirtanStudents (StudentID, FullName, Email, TotalCredits)
VALUES 
    (1, 'Peter Johnson', 'peter.johnson@example.com', 0),
    (2, 'Tony Park', 'tony.park@example.com', 0),
    (3, 'Sarah Adams', 'sarah.adams@example.com', 0);
GO

-- Insert sample data into Courses table
INSERT INTO KirtanCourses (CourseID, CourseName, Instructor, CourseCredits, AvailableSeats)
VALUES 
    (1, 'Physics', 'Professor Smith', 1, 5),
    (2, 'Chemistry', 'Professor Clark', 3, 30),
    (3, 'Computer Science', 'Professor Williams', 2, 15);
GO

-- Create the stored procedure for student registration
CREATE OR ALTER PROCEDURE Kirtan_spInsertStudentRegistration
    @StudentID INT,
    @CourseID INT
AS
BEGIN
    -- Start transaction
    BEGIN TRANSACTION;
    
    DECLARE @AvailableSeats INT;
    DECLARE @CourseCredits INT;
    
    -- Check seat availability
    SELECT @AvailableSeats = AvailableSeats, @CourseCredits = CourseCredits 
    FROM KirtanCourses 
    WHERE CourseID = @CourseID;
    
    -- If no seats available, roll back transaction
    IF @AvailableSeats <= 0
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Course is full. Registration failed';
        RETURN;
    END
    
    -- Update available seats in course
    UPDATE KirtanCourses
    SET AvailableSeats = AvailableSeats - 1
    WHERE CourseID = @CourseID;
    
    -- Update student total credits
    UPDATE KirtanStudents
    SET TotalCredits = TotalCredits + @CourseCredits
    WHERE StudentID = @StudentID;
    
    -- Insert registration record
    INSERT INTO KirtanStudentRegistration (StudentID, CourseID)
    VALUES (@StudentID, @CourseID);
    
    -- Commit the transaction
    COMMIT TRANSACTION;
    PRINT 'Registration successful';
END;
GO

-- Test the stored procedure with the provided test cases
-- a. Peter Johnson registers for Chemistry
EXEC Kirtan_spInsertStudentRegistration 1, 2;
GO

-- After each registration, check the data in all three tables
SELECT * FROM KirtanStudents;
SELECT * FROM KirtanCourses;
SELECT * FROM KirtanStudentRegistration;
GO

-- b. Sara Adams registers for Computer Science
EXEC Kirtan_spInsertStudentRegistration 3, 3;
GO

-- c. Tony Park registers for Chemistry
EXEC Kirtan_spInsertStudentRegistration 2, 2;
GO

-- d. Sarah Adams for Physics
EXEC Kirtan_spInsertStudentRegistration 3, 1;
GO

-- e. Peter Johnson registers for Computer Science
EXEC Kirtan_spInsertStudentRegistration 1, 3;
GO

-- f. Sarah Adams for Chemistry
EXEC Kirtan_spInsertStudentRegistration 3, 2;
GO