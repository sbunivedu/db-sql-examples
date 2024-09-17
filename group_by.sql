-- Sample Data

-- Create Tables
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Major VARCHAR(50),
    GPA DECIMAL(3,2)
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50),
    Department VARCHAR(50),
    Credits INT
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Semester VARCHAR(20),
    Grade CHAR(1),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Insert Sample Data
INSERT INTO Students (StudentID, Name, Major, GPA) VALUES
(1, 'Alice Johnson', 'Computer Science', 3.8),
(2, 'Bob Smith', 'Mathematics', 3.5),
(3, 'Charlie Brown', 'Physics', 3.2),
(4, 'Diana Ross', 'Computer Science', 3.9),
(5, 'Edward Lee', 'Mathematics', 3.6);

INSERT INTO Courses (CourseID, CourseName, Department, Credits) VALUES
(101, 'Introduction to Programming', 'Computer Science', 3),
(102, 'Data Structures', 'Computer Science', 4),
(201, 'Calculus I', 'Mathematics', 4),
(202, 'Linear Algebra', 'Mathematics', 3),
(301, 'Quantum Mechanics', 'Physics', 4);

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, Semester, Grade) VALUES
(1, 1, 101, 'Fall 2023', 'A'),
(2, 1, 102, 'Spring 2024', 'B'),
(3, 2, 201, 'Fall 2023', 'A'),
(4, 2, 202, 'Spring 2024', 'A'),
(5, 3, 301, 'Fall 2023', 'B'),
(6, 4, 101, 'Fall 2023', 'A'),
(7, 4, 102, 'Spring 2024', 'A'),
(8, 5, 201, 'Fall 2023', 'B'),
(9, 5, 202, 'Spring 2024', 'A');