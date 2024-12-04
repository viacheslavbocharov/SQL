---- Homework 1 ----
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





---- Homework 2 ----
--Створіть наступні запити для таблиці з оцінками студентів із попереднього дз: 
-- DONE Відображення всієї інформації з таблиці зі студентами та оцінками.
-- DONE Відображення ПІБ усіх студентів.
-- DONE Відображення усіх середніх оцінок.
-- DONE Показати країни студентів. Назви країн мають бути унікальними.
-- DONE Показати міста студентів. Назви міст мають бути унікальними.
-- DONE Показати назви груп. Назви груп мають бути унікальними.

--clear all rows and increment to insert new data which need for next proper sorting
TRUNCATE TABLE StudentsGrades;

-- incert new data genered by ChatGPT
INSERT INTO StudentsGrades 
VALUES
-- Группа 1: США, Нью-Йорк (5 студентов)
('John', 'Michael', 'Doe', 'New York', 'USA', '1995-05-10', 'john.doe@gmail.com', '+1234567890', 'A1', 85.4, 'Mathematics', 'Physics'),
('Emily', NULL, 'Smith', 'New York', 'USA', '1997-03-22', 'emily.smith@gmail.com', '+1234567891', 'A1', 79.8, 'English', 'History'),
('Daniel', 'Andrew', 'Brown', 'New York', 'USA', '1996-08-11', 'daniel.brown@gmail.com', '+1234567892', 'A1', 88.5, 'Biology', 'Physics'),
('Sophia', 'Marie', 'Johnson', 'New York', 'USA', '1998-04-05', 'sophia.johnson@gmail.com', '+1234567893', 'B1', 92.3, 'Art', 'Mathematics'),
('Michael', NULL, 'Wilson', 'New York', 'USA', '1999-06-15', 'michael.wilson@gmail.com', '+1234567894', 'B1', 81.2, 'Geography', 'History'),

-- Группа 2: Великобритания, Лондон (5 студентов)
('Jane', 'Ann', 'Taylor', 'London', 'UK', '1995-12-12', 'jane.taylor@gmail.com', '+9876543210', 'C1', 78.9, 'Biology', 'Chemistry'),
('Oliver', NULL, 'Williams', 'London', 'UK', '1997-07-08', 'oliver.williams@gmail.com', '+9876543211', 'C1', 85.5, 'English', 'Physics'),
('Charlotte', 'Rose', 'Moore', 'London', 'UK', '1996-03-20', 'charlotte.moore@gmail.com', '+9876543212', 'C1', 89.7, 'Mathematics', 'Art'),
('Harry', 'Edward', 'Davis', 'London', 'UK', '1998-09-11', 'harry.davis@gmail.com', '+9876543213', 'D1', 84.3, 'History', 'Geography'),
('Isabella', 'Grace', 'Clark', 'London', 'UK', '1999-01-29', 'isabella.clark@gmail.com', '+9876543214', 'D1', 91.5, 'Physics', 'Mathematics'),

-- Группа 3: Канада, Торонто (5 студентов)
('Emily', 'Ann', 'Brown', 'Toronto', 'Canada', '1997-11-23', 'emily.brown@gmail.com', '+1122334455', 'C2', 90.5, 'History', 'English'),
('Noah', NULL, 'Taylor', 'Toronto', 'Canada', '1995-03-15', 'noah.taylor@gmail.com', '+1122334456', 'C2', 86.2, 'Physics', 'Mathematics'),
('Emma', 'Sophia', 'White', 'Toronto', 'Canada', '1998-06-18', 'emma.white@gmail.com', '+1122334457', 'D2', 87.9, 'Art', 'Geography'),
('Liam', NULL, 'Lee', 'Toronto', 'Canada', '1996-04-23', 'liam.lee@gmail.com', '+1122334458', 'D2', 83.4, 'Chemistry', 'Biology'),
('Ava', 'Rose', 'Martin', 'Toronto', 'Canada', '1999-02-11', 'ava.martin@gmail.com', '+1122334459', 'E2', 88.8, 'English', 'History'),

-- Группа 4: Франция, Париж (5 студентов)
('Lucas', 'Ethan', 'Smith', 'Paris', 'France', '1996-05-25', 'lucas.smith@gmail.com', '+4455667788', 'E4', 82.1, 'Physics', 'Art'),
('Mia', 'Marie', 'Clark', 'Paris', 'France', '1998-07-30', 'mia.clark@gmail.com', '+4455667789', 'E4', 90.7, 'Mathematics', 'Chemistry'),
('James', 'Alexander', 'Brown', 'Paris', 'France', '1995-10-13', 'james.brown@gmail.com', '+4455667790', 'F1', 84.6, 'English', 'Physics'),
('Amelia', NULL, 'Wilson', 'Paris', 'France', '1997-12-21', 'amelia.wilson@gmail.com', '+4455667791', 'F1', 92.2, 'History', 'Biology'),
('Ethan', 'Henry', 'Jones', 'Paris', 'France', '1999-03-19', 'ethan.jones@gmail.com', '+4455667792', 'F2', 85.9, 'Geography', 'Art'),

-- Группа 5: Австралия, Сидней (5 студентов)
('Daniel', 'Andrew', 'Wilson', 'Sydney', 'Australia', '1996-07-01', 'daniel.wilson@gmail.com', '+6677889900', 'D3', 88.3, 'Geography', 'Physics'),
('Olivia', NULL, 'Davis', 'Sydney', 'Australia', '1998-01-22', 'olivia.davis@gmail.com', '+6677889901', 'D3', 89.4, 'Art', 'History'),
('Alexander', 'William', 'Clark', 'Sydney', 'Australia', '1995-11-02', 'alexander.clark@gmail.com', '+6677889902', 'E3', 85.1, 'Mathematics', 'Chemistry'),
('Sophia', NULL, 'Taylor', 'Sydney', 'Australia', '1997-09-10', 'sophia.taylor@gmail.com', '+6677889903', 'E3', 87.6, 'Biology', 'Physics'),
('Lucas', 'James', 'Brown', 'Sydney', 'Australia', '1999-05-16', 'lucas.brown@gmail.com', '+6677889904', 'F3', 90.2, 'English', 'History');

--■ Відображення всієї інформації з таблиці зі студентами та оцінками.
SELECT * FROM StudentsGrades

--■ Відображення ПІБ усіх студентів.
-- изначально сделал так, но возникла проблема с отображением NUll у тех студентов у которых небыло отчества
SELECT LastName + ' ' + FirstName + ' ' + PatronymicName AS [ПIБ] FROM StudentsGrades
-- GPT подскалаз решение через проверку ISNULL или COALESCE
SELECT LastName + ' ' + FirstName + ISNULL(' ' + PatronymicName,'') AS [ПIБ] FROM StudentsGrades

--■ Відображення усіх середніх оцінок.
SELECT 
LastName + ' ' + FirstName + ISNULL(' ' + PatronymicName,'') AS [ПIБ], AllSubjectAverageYearGrade AS [Сер.Оц.] 
FROM StudentsGrades

--■ Показати країни студентів. Назви країн мають бути унікальними.
SELECT DISTINCT 
Country AS [List of student's countries]
FROM StudentsGrades 

--■ Показати міста студентів. Назви міст мають бути унікальними.
-- тот же принцып что и предыдущем запросе
SELECT DISTINCT 
City AS [List of student's cityes]
FROM StudentsGrades 

--■ Показати назви груп. Назви груп мають бути унікальними.-- тот же принцып что и предыдущем запросе
SELECT DISTINCT 
GroupName AS [List of student's groups]
FROM StudentsGrades 