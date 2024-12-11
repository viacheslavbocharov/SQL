--WomeWork 4

--DONE Створити базу даних за дiаграмою (у вкладеннi зображення)
--DONE Додати контент у таблицi з файла "insert_scripts_with_data_for_teams_db.sql"
--Зробити 7-10 будь-яких запитiв зi списку у файлi "список_запитiв_до_бази_дз_4.txt"
--Додатково: зробити всi 15 запитiв зi списку у файлi "список_запитiв_до_бази_дз_4.txt"


--Task 1: Створити базу даних за дiаграмою (у вкладеннi зображення)
CREATE DATABASE TeamsDB
GO

USE TeamsDB
GO
-- использовал пошаговую инструкцию с поясениями процесса от GPT без готового кода
-- 1 создаю таблицы без связей
-- 4 вместо использования ALTER TABLE переписал скрипт чтобы свзи добавлялись на этапе создания
-- 5 поменял порядок создания таблиц, чтобы создавались вначале Continent и Currency, а потом Country.
CREATE TABLE Currency (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL
);

CREATE TABLE Continent (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL
);

CREATE TABLE Language (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL
);

CREATE TABLE Country (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL,
    ContinentId INT NOT NULL,
	Capital NVARCHAR(50) NOT NULL,
	Territory FLOAT NOT NULL,
	CurrencyId INT NOT NULL,
	Debut INT NOT NULL,
	Champion INT NOT NULL,

	CONSTRAINT FK_Country_Continent 
	FOREIGN KEY (ContinentId) 
	REFERENCES Continent(Id),

	CONSTRAINT FK_Country_Currency 
	FOREIGN KEY (CurrencyId) 
	REFERENCES Currency(Id)
);

CREATE TABLE CountryLanguage (
    Id INT PRIMARY KEY IDENTITY(1,1),
    CountryId INT NOT NULL,
	LanguageId INT NOT NULL,

	CONSTRAINT FK_CountryLanguage_Country 
	FOREIGN KEY (CountryId) 
	REFERENCES Country(Id)
	ON DELETE CASCADE,

	CONSTRAINT FK_CountryLanguage_Language 
	FOREIGN KEY (LanguageId) 
	REFERENCES Language(Id)
	ON DELETE CASCADE
);


-- 2 добавляю связь ALTER TABLE
--ALTER TABLE Country 
--ADD CONSTRAINT FK_Country_Continent 
--FOREIGN KEY (ContinentId) 
--REFERENCES Continent(Id);
--GO

--ALTER TABLE Country 
--ADD CONSTRAINT FK_Country_Currency 
--FOREIGN KEY (CurrencyId) 
--REFERENCES Currency(Id);
--GO

--ALTER TABLE CountryLanguage 
--ADD CONSTRAINT FK_CountryLanguage_Country 
--FOREIGN KEY (CountryId) 
--REFERENCES Country(Id)
--ON DELETE CASCADE
--GO

--ALTER TABLE CountryLanguage 
--ADD CONSTRAINT FK_CountryLanguage_Language 
--FOREIGN KEY (LanguageId) 
--REFERENCES Language(Id);
--GO

--3 по совету GPT добавил CASCADE к CountryLanguage




--Task2: Додати контент у таблицi з файла "insert_scripts_with_data_for_teams_db.sql"
-- данные для [dbo].[Continent]
INSERT [dbo].[Continent] ([Name]) VALUES
(N'Европа'),
(N'Африка'),
(N'Азия'),
(N'Южная Америка'),
(N'Центральная Америка'),
(N'Северная Америка'),
(N'Австралия')

-- данные для [dbo].[Currency]
INSERT [dbo].[Currency] ([Name]) VALUES 
(N'евро'),
(N'костариканский колон'),
(N'злотый'),
(N'доллар США'),
(N'фунт стерлингов'),
(N'гуарани'),
(N'доллар Тринидад и Тобаго'),
(N'шведская крона'),
(N'аргентинский песо'),
(N'франк'),
(N'динар'),
(N'мексиканский песо'),
(N'риал'),
(N'кванза'),
(N'чеди'),
(N'чешская крона'),
(N'бразильский реал'),
(N'швейцарский франк'),
(N'куна'),
(N'австралийский доллар'),
(N'иена'),
(N'вона'),
(N'гривня'),
(N'тунисский динар'),
(N'саудовский риал')

-- данные для [dbo].[Language]
INSERT [dbo].[Language] ([Name]) VALUES
(N'украинский'),
(N'французский'),
(N'арабский'),
(N'английский'),
(N'немецкий'),
(N'португальский'),
(N'японский'),
(N'испанский'),
(N'итальянский'),
(N'корейский'),
(N'польский'),
(N'шведский'),
(N'сербский'),
(N'нидерландский'),
(N'персидский'),
(N'чешский'),
(N'хорватский');



-- данные для [dbo].[Country]
INSERT [dbo].[Country] ([Name], [ContinentId], [Capital], [Territory], [CurrencyId], [Debut], [Champion]) VALUES 
(N'Украина', 1, N'Киев', 603.7, 23, 1, 0),
(N'Франция', 1, N'Париж', 545.63, 1, 0, 1),
(N'Тунис', 2, N'Тунис', 155.36, 24, 0, 0),
(N'Ангола', 2, N'Луанда', 1246.7, 14, 1, 0),
(N'Япония', 3, N'Токио', 374.744, 21, 0, 0),
(N'Бразилия', 4, N'Бразилиа', 8456.51, 17, 0, 5),
(N'Испания', 1, N'Мадрид', 499.542, 1, 0, 0),
(N'Италия', 1, N'Рим', 294.02, 1, 0, 4),
(N'Тринидад и Тобаго', 5, N'Порт-оф-Спейн', 5.1, 7, 1, 0),
(N'Германия', 1, N'Берлин', 349.223, 1, 0, 3),
(N'Аргентина', 4, N'Буэнос-Айрес', 2736.69, 9, 0, 2),
(N'Парагвай', 4, N'Асунсьон', 397.3, 6, 0, 0),
(N'Южная Корея', 3, N'Сеул', 98.19, 22, 0, 0),
(N'Коста-Рика', 5, N'Сан-Хосе', 50.66, 2, 0, 0),
(N'Польша', 1, N'Варшава', 304.465, 3, 0, 0),
(N'США', 6, N'Вашингтон', 9158.96, 4, 0, 0),
(N'Португалия', 1, N'Лиссабон', 91.951, 1, 0, 0),
(N'Саудовская Аравия', 3, N'Эр-Рияд', 1960.582, 25, 0, 0),
(N'Англия', 1, N'Лондон', 129.634, 5, 0, 1),
(N'Швеция', 1, N'Стокгольм', 410.934, 8, 0, 0),
(N'Эквадор', 4, N'Кито', 276.84, 4, 0, 0),
(N'Хорватия', 1, N'Загреб', 56.414, 19, 0, 0),
(N'Мексика', 5, N'Мехико', 1923.04, 12, 0, 0),
(N'Кот-д''Ивуар', 2, N'Ямусукро', 322.5, 10, 1, 0),
(N'Нидерланды', 1, N'Амстердам', 41.5, 1, 0, 0),
(N'Швейцария', 1, N'Берн', 41.3, 18, 0, 0),
(N'Того', 2, N'Ломе', 56.6, 10, 1, 0),
(N'Иран', 3, N'Тегеран', 1650, 13, 0, 0),
(N'Австралия', 7, N'Канберра', 7700, 20, 0, 0),
(N'Сербия и Черногория', 1, N'Белград', 102.2, 11, 0, 0),
(N'Гана', 2, N'Аккра', 238.5, 15, 1, 0),
(N'Чехия', 1, N'Прага', 78.9, 16, 0, 0)

-- данные для [dbo].[CountryLanguage]
INSERT [dbo].[CountryLanguage] ([CountryId], [LanguageId]) VALUES 
(29, 4),
(19, 4),
(4, 6),
(11, 8),
(6, 6),
(31, 4),
(10, 5),
(28, 15),
(7, 8),
(8, 9),
(14, 8),
(24, 2),
(23, 8),
(25, 14),
(12, 8),
(15, 11),
(17, 6),
(18, 3),
(30, 13),
(16, 4),
(27, 2),
(9, 4),
(3, 2),
(3, 3),
(1, 1),
(2, 2),
(22, 17),
(32, 16),
(26, 9),
(26, 5),
(26, 2),
(20, 12),
(21, 8),
(13, 10),
(5, 7)

SELECT * FROM Continent
SELECT * FROM Country
SELECT * FROM Currency
SELECT * FROM Language
SELECT* FROM CountryLanguage
--USE master;
--DROP DATABASE TeamsDB;

--Task3: Зробити 7-10 будь-яких запитiв зi списку у файлi "список_запитiв_до_бази_дз_4.txt"
--1. Отобразить страну, которая чаще других становилась чемпионом мира.
SELECT Name AS [страна, которая чаще других становилась чемпионом мира], Champion
FROM Country
WHERE Champion = (SELECT MAX(Champion) FROM Country)

--2. Отобразить количество стран, представленное каждым континентом на чемпионате мира.
SELECT Continent.Name AS Continent, COUNT(Country.Id) AS [Country qty]
FROM Continent
JOIN Country ON Continent.Id = Country.ContinentId
GROUP BY Continent.Name

--3. Отобразить европейскую страну, которая чаще других становилась чемпионом мира.
SELECT TOP 1 Country.Name AS [европейская страна, которая чаще других становилась чемпионом мира], Country.Champion AS [Qty]
FROM Country
JOIN Continent ON Country.ContinentId = Continent.Id
WHERE Continent.Name = N'Европа'
ORDER BY Country.Champion DESC;

--4. Отобразить страну, территория которой наибольшая.
SELECT TOP 1 Name, Territory 
FROM Country
ORDER BY Territory DESC;

--5. Отобразить европейскую страну, территория которой наибольшая.
SELECT TOP 1 Country.Name, Country.Territory 
FROM Country
JOIN Continent ON Country.ContinentId = Continent.Id
WHERE Continent.Name = N'Европа'
ORDER BY Country.Territory DESC;


--6. Отобразить по каждому континенту количество стран, которые становились чемпионами мира.
SELECT Continent.Name AS [Continent], COUNT(Country.Id) AS [Champion Country Qty]
FROM Continent
JOIN Country ON Continent.Id = Country.ContinentId
WHERE Country.Champion > 0
GROUP BY Continent.Name;

--7. Отобразить для каждого континента суммарное количество чемпионских титулов.
SELECT Continent.Name AS [Continent], SUM(Country.Champion) AS [Total Championship Titles]
FROM Continent
JOIN Country ON Continent.Id = Country.ContinentId
WHERE Country.Champion > 0 -- Учитываются только те страны, которые становились чемпионами мира
GROUP BY Continent.Name;

--8. Определить по каждому континенту среднее значение территории для стран, входящих в этот континент.
SELECT Continent.Name AS [Continent], AVG(Country.Territory) AS [Average Territory]
FROM Continent
JOIN Country ON Continent.Id = Country.ContinentId
GROUP BY Continent.Name;

--9. Отобразить количество стран-дебютантов для каждого континента.
SELECT Continent.Name AS [Continent], COUNT(Country.Id) AS [Debut Countries Qty]
FROM Continent
JOIN Country ON Continent.Id = Country.ContinentId
WHERE Country.Debut = 1
GROUP BY Continent.Name;

--10. Отобразить для каждого языка количество стран, в которых этот язык является официальным.
SELECT Language.Name AS [Language], COUNT(CountryLanguage.CountryId) AS [Country Qty]
FROM Language
JOIN CountryLanguage ON Language.Id = CountryLanguage.LanguageId
GROUP BY Language.Name
ORDER BY [Country Qty] DESC;

--11. Отобразить африканскую страну, территория которой наименьшая.
SELECT TOP 1 Country.Name AS [Country], Country.Territory AS [Territory]
FROM Country
JOIN Continent ON Country.ContinentId = Continent.Id
WHERE Continent.Name = N'Африка'
ORDER BY Country.Territory ASC;

--12. Отобразить для каждой валюты количество стран, в которых эта валюта является национальной.
SELECT Currency.Name AS [Currency], COUNT(Country.Id) AS [Country Count]
FROM Currency
JOIN Country ON Currency.Id = Country.CurrencyId
GROUP BY Currency.Name
ORDER BY [Country Count] DESC;

--13. Отобразить наиболее распространенный язык и указать количество стран, в которых он является официальным.
--14. Отобразить континент, у которого самый высокий суммарный показатель по чемпионским титулам.
--15. Отобразить наиболее распространенный язык среди стран европейского и африканского континентов.