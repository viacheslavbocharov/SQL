CREATE DATABASE Students
GO

USE Students
-- GPT adviced yo separate commands by "GO", I don't really understand for what
GO

CREATE TABLE StudentsGrades
--create table according to the lecture notes
(
    Id INT PRIMARY KEY IDENTITY (1, 1),
    FirstName NVARCHAR(20) NOT NULL,
	PatronymicName NVARCHAR(20) NULL,
    LastName NVARCHAR(20) NOT NULL,
	City NVARCHAR(20) NOT NULL,
	Country NVARCHAR(20) NOT NULL,
	DateOfBirth DATE NOT NULL,
    Email VARCHAR(40) UNIQUE,
    Phone VARCHAR(20) UNIQUE,
	GroupName NVARCHAR(20) NULL,
	AllSubjectAverageYearGrade FLOAT NULL,
	SubjectNameWithMinAverageYearGrade NVARCHAR(30) NULL,
	SubjectNameWithMaxAverageYearGrade NVARCHAR(30) NULL
);
-- GPT adviced yo separate commands by "GO", I don't really understand for what
GO

-- at first I did "INSERT INTO StudentsGrades", but it was wrong because I uased increnent(GPT advise), so I was needed to declare fields 
INSERT INTO StudentsGrades 
(
    FirstName,
    PatronymicName,
    LastName,
    City,
    Country,
    DateOfBirth,
    Email,
    Phone,
    GroupName,
    AllSubjectAverageYearGrade,
    SubjectNameWithMinAverageYearGrade,
    SubjectNameWithMaxAverageYearGrade
)
-- incert dasta according to the lecture notes
VALUES
-- created random data by ChatGPT
('John', 'Michael', 'Doe', 'New York', 'USA', '1995-05-10', 'john.doe@gmail.com', '+1234567890', 'A1', 85.4, 'Mathematics', 'Physics'),
('Jane', NULL, 'Smith', 'London', 'UK', '1998-03-15', 'jane.smith@gmail.com', '+9876543210', 'B1', 78.9, 'Biology', 'Chemistry'),
('Emily', 'Ann', 'Brown', 'Toronto', 'Canada', '1997-11-23', 'emily.brown@gmail.com', '+1122334455', 'C2', 90.5, 'History', 'English'),
('Daniel', NULL, 'Wilson', 'Sydney', 'Australia', '1996-07-01', 'daniel.wilson@gmail.com', '+6677889900', 'D3', 88.3, 'Geography', 'Physics'),
('Sophia', 'Marie', 'Johnson', 'Paris', 'France', '1999-12-19', 'sophia.johnson@gmail.com', '+4455667788', 'E4', 91.2, 'Art', 'Mathematics');
-- GPT adviced yo separate commands by "GO", I don't really understand for what
GO

-- display table as it was shown at the lesson
SELECT * FROM StudentsGrades;
-- GPT adviced yo separate commands by "GO", I don't really understand for what
GO
