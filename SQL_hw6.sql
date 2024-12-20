--Homework 6

--1. Створіть наступні функції користувача (Functions): 

--■ Функція користувача повертає вітання в стилі «Hello, ІМ'Я!» Де ІМ'Я передається як параметр. Наприклад, якщо передали Nick, то буде Hello, Nick! 
CREATE FUNCTION GreetUser(@Name NVARCHAR(50))
RETURNS NVARCHAR(100)
AS
BEGIN
    RETURN 'Hello, ' + @Name + '!';
END
GO --GPT подсказал что нужно разделять функции с GO

SELECT dbo.GreetUser('Nick'); --Вызов
GO


--■ Функція користувача повертає інформацію про поточну кількість хвилин; 
CREATE FUNCTION GetCurrentMinutes()
RETURNS INT
AS
BEGIN
    RETURN DATEPART(MINUTE, GETDATE());
END;
GO

SELECT dbo.GetCurrentMinutes();--Вызов
GO


--■ Функція користувача повертає інформацію про поточний рік; 
CREATE FUNCTION GetCurrentYear()
RETURNS INT
AS
BEGIN
    RETURN DATEPART(YEAR, GETDATE());
END
GO

SELECT dbo.GetCurrentYear(); --Вызов
GO

--■ Функція користувача повертає інформацію про те: парний або непарний рік; 
--■ Функція користувача приймає число і повертає yes, якщо число просте і no, якщо число не просте; 

--■ Функція користувача приймає як параметри п'ять чисел. Повертає суму мінімального та максимального значення з переданих п'яти параметрів;
CREATE FUNCTION SumOfMinAndMax(
    @Num1 INT,
    @Num2 INT,
    @Num3 INT,
    @Num4 INT,
    @Num5 INT
)
RETURNS INT
AS
BEGIN
    DECLARE @MinValue INT, @MaxValue INT;
    
    -- Мин значение
    SET @MinValue = (SELECT MIN(Value) 
                     FROM (VALUES (@Num1), (@Num2), (@Num3), (@Num4), (@Num5)) AS TempTable(Value)); --Подсказывал GPT как делать через временную
    
    -- Макс значение
    SET @MaxValue = (SELECT MAX(Value) 
                     FROM (VALUES (@Num1), (@Num2), (@Num3), (@Num4), (@Num5)) AS TempTable(Value));
    
    -- Возврат суммы
    RETURN @MinValue + @MaxValue;
END;
GO

SELECT dbo.SumOfMinAndMax(10, 20, 5, 30, 15);
GO


-- 2. Створіть наступні збережені процедури (Stored procedures): 

--■ Збережена процедура виводить «Hello, world!»; 
CREATE PROCEDURE SayHelloWorld
AS
BEGIN
    PRINT 'Hello, world!';
END;
GO

EXEC SayHelloWorld;
GO

--■ Збережена процедура повертає інформацію про поточний час; 
CREATE PROCEDURE GetCurrentTime
AS
BEGIN
	SELECT CONVERT(VARCHAR(8), GETDATE(), 108) AS CurrentTime;
END;
GO

EXEC GetCurrentTime;
GO


--■ Збережена процедура повертає інформацію про поточну дату; 
CREATE PROCEDURE GetCurrentDate
AS
BEGIN
    SELECT CONVERT(DATE, GETDATE()) AS CurrentDate;
END;
GO

EXEC GetCurrentDate;
GO

--■ Збережена процедура приймає три числа і повертає їхню суму; 
CREATE PROCEDURE GetSumOfThreeNumbers
    @Num1 INT,
    @Num2 INT,
    @Num3 INT
AS
BEGIN
    SELECT @Num1 + @Num2 + @Num3 AS SumOfNumbers;
END;
GO

EXEC GetSumOfThreeNumbers 10, 20, 30;
GO

--■ Збережена процедура приймає три числа і повертає середньоарифметичне трьох чисел; 
CREATE PROCEDURE GetAverageOfThreeNumbers
    @Num1 INT,
    @Num2 INT,
    @Num3 INT
AS
BEGIN
    SELECT CAST((@Num1 + @Num2 + @Num3) AS FLOAT) / 3 AS Average;
END;
GO

EXEC GetAverageOfThreeNumbers 10, 20, 30;
GO

--■ Збережена процедура приймає три числа і повертає максимальне значення;
CREATE PROCEDURE GetMaxOfThreeNumbers
    @Num1 INT,
    @Num2 INT,
    @Num3 INT
AS
BEGIN
    SELECT MAX(Value) AS MaxValue
    FROM (VALUES (@Num1), (@Num2), (@Num3)) AS TempTable(Value);
END;
GO

EXEC GetMaxOfThreeNumbers 10, 20, 30;
GO

--■ Збережена процедура приймає три числа і повертає мінімальне значення; 
CREATE PROCEDURE GetMinOfThreeNumbers
    @Num1 INT,
    @Num2 INT,
    @Num3 INT
AS
BEGIN
    SELECT MIN(Value) AS MinValue
    FROM (VALUES (@Num1), (@Num2), (@Num3)) AS TempTable(Value);
END;
GO

EXEC GetMinOfThreeNumbers 10, 20, 30;
GO

-- ■ Збережена процедура приймає число та символ. 
-- В результаті роботи збереженої процедури відображається  лінія довжиною, що дорівнює числу. Лінія побудована із символу, вказаного у другому параметрі. 
-- Наприклад, якщо було передано 5 та #, ми отримаємо лінію такого виду #####; 
