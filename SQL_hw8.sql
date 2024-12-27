-- Homework 8

-- ЧАСТЬ 1: создаю БД барбершопа

CREATE DATABASE Barbershop;
GO

USE Barbershop;
GO

-- Таблица для хранения данных барберов
CREATE TABLE Barbers (
    BarberID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Gender NVARCHAR(10) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    Email NVARCHAR(100),
    BirthDate DATE,
    HireDate DATE NOT NULL,
    Position NVARCHAR(20) CHECK (Position IN ('Chief-Barber', 'Senior-Barber', 'Junior-Barber')) NOT NULL
);

-- Таблица для хранения услуг
CREATE TABLE Services (
    ServiceID INT PRIMARY KEY IDENTITY(1,1),
    ServiceName NVARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    DurationMinutes INT NOT NULL
);

-- Таблица связи услуг с барберами
CREATE TABLE BarberServices (
    BarberServiceID INT PRIMARY KEY IDENTITY(1,1),
    BarberID INT NOT NULL FOREIGN KEY REFERENCES Barbers(BarberID),
    ServiceID INT NOT NULL FOREIGN KEY REFERENCES Services(ServiceID)
);

-- Таблица для хранения отзывов и оценок барберов
CREATE TABLE BarberFeedback (
    FeedbackID INT PRIMARY KEY IDENTITY(1,1),
    BarberID INT NOT NULL FOREIGN KEY REFERENCES Barbers(BarberID),
    ClientID INT NOT NULL,
    Rating NVARCHAR(20) CHECK (Rating IN ('Very Bad', 'Bad', 'Okay', 'Good', 'Excellent')) NOT NULL,
    FeedbackText NVARCHAR(MAX)
);

-- Таблица для хранения данных клиентов
CREATE TABLE Clients (
    ClientID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    Email NVARCHAR(100)
);

-- Таблица для хранения отзывов клиентов
CREATE TABLE ClientFeedback (
    FeedbackID INT PRIMARY KEY IDENTITY(1,1),
    ClientID INT NOT NULL FOREIGN KEY REFERENCES Clients(ClientID),
    BarberID INT NOT NULL FOREIGN KEY REFERENCES Barbers(BarberID),
    Rating NVARCHAR(20) CHECK (Rating IN ('Very Bad', 'Bad', 'Okay', 'Good', 'Excellent')) NOT NULL,
    FeedbackText NVARCHAR(MAX)
);

-- Таблица для хранения расписания барберов
CREATE TABLE BarberSchedule (
    ScheduleID INT PRIMARY KEY IDENTITY(1,1),
    BarberID INT NOT NULL FOREIGN KEY REFERENCES Barbers(BarberID),
    AvailableDate DATE NOT NULL,
    AvailableTime TIME NOT NULL
);

-- Таблица для записи клиентов на услуги
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY IDENTITY(1,1),
    ClientID INT NOT NULL FOREIGN KEY REFERENCES Clients(ClientID),
    BarberID INT NOT NULL FOREIGN KEY REFERENCES Barbers(BarberID),
    ServiceID INT NOT NULL FOREIGN KEY REFERENCES Services(ServiceID),
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL
);

-- Таблица для хранения архива посещений
CREATE TABLE VisitArchive (
    VisitID INT PRIMARY KEY IDENTITY(1,1),
    ClientID INT NOT NULL FOREIGN KEY REFERENCES Clients(ClientID),
    BarberID INT NOT NULL FOREIGN KEY REFERENCES Barbers(BarberID),
    ServiceID INT NOT NULL FOREIGN KEY REFERENCES Services(ServiceID),
    VisitDate DATE NOT NULL,
    TotalCost DECIMAL(10, 2) NOT NULL,
    Rating NVARCHAR(20) CHECK (Rating IN ('Very Bad', 'Bad', 'Okay', 'Good', 'Excellent')),
    FeedbackText NVARCHAR(MAX)
);

-- ЧАСТЬ 2: Заполнение таблиц фейковыми данными
-- GPT помог подправить скрипт для генерация фейковых данных барберов
WITH BarberData AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNum,
        CONCAT('Barber', ROW_NUMBER() OVER (ORDER BY (SELECT NULL))) AS FullName,
        CASE WHEN (ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) % 2) = 0 THEN 'Male' ELSE 'Female' END AS Gender,
        CONCAT('+123456789', ROW_NUMBER() OVER (ORDER BY (SELECT NULL))) AS Phone,
        CONCAT('barber', ROW_NUMBER() OVER (ORDER BY (SELECT NULL)), '@example.com') AS Email,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 36525), GETDATE()) AS BirthDate, -- Случайные даты рождения в пределах 100 лет
        DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 7300), GETDATE()) AS HireDate -- Случайные даты найма в пределах 20 лет
    FROM sys.objects s1
    CROSS JOIN sys.objects s2
)
INSERT INTO Barbers (FullName, Gender, Phone, Email, BirthDate, HireDate, Position)
SELECT
    FullName,
    Gender,
    Phone,
    Email,
    BirthDate,
    HireDate,
    CASE 
        WHEN (RowNum % 3) = 0 THEN 'Chief-Barber'
        WHEN (RowNum % 3) = 1 THEN 'Senior-Barber'
        ELSE 'Junior-Barber'
    END AS Position
FROM BarberData
WHERE RowNum <= 1000000;


-- Генерация фейковых данных для услуг
INSERT INTO Services (ServiceName, Price, DurationMinutes)
VALUES
    ('Haircut', 20.00, 30),
    ('Beard Trim', 15.00, 20),
    ('Shaving', 25.00, 40),
    ('Hair Coloring', 50.00, 60),
    ('Hair Treatment', 30.00, 45);

-- Генерация фейковых данных для клиентов
WITH ClientData AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNum,
        CONCAT('Client', ROW_NUMBER() OVER (ORDER BY (SELECT NULL))) AS FullName,
        CONCAT('+987654321', ROW_NUMBER() OVER (ORDER BY (SELECT NULL))) AS Phone,
        CONCAT('client', ROW_NUMBER() OVER (ORDER BY (SELECT NULL)), '@example.com') AS Email
    FROM sys.objects s1
    CROSS JOIN sys.objects s2
)
INSERT INTO Clients (FullName, Phone, Email)
SELECT
    FullName,
    Phone,
    Email
FROM ClientData
WHERE RowNum <= 1000000;



SELECT * FROM Clients
