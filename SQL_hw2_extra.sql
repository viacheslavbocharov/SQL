USE [master]
GO
CREATE DATABASE [Database_Books]
GO
USE [Database_Books]
GO
CREATE TABLE [dbo].[books](
	[Id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Name] [nvarchar](100) NULL,
	[Pages] [int] NULL,
	[YearPress] [int] NULL,
	[Themes] [nvarchar](50) NULL,
	[Author] [nvarchar](50) NULL,
	[Press] [nvarchar](50) NULL,
	[Comment] [nvarchar](50) NULL,
	[Quantity] [int] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[books] ([Name], [Pages], [YearPress], [Themes], [Author], [Press], [Comment], [Quantity]) VALUES 
(N'SQL', 816, 2001, N'Базы данных', N'Грофф', N'BHV', N'2-е издание', 2)
,(N'3D Studio Max 3', 640, 2000, N'Графические пакеты', N'Маров', N'Питер', N'Учебный курс', 3)
,(N'100 компонентов общего назначения библиотеки Delphi 5', 272, 1999, N'Программирование', N'Архангельский', N'Бином', N'Компоненты', 1)
,(N'Курс математического анализа', 328, 1990, N'Высшая математика', N'Никольский', N'Наука', N'1-й том', 1)
,(N'Библиотека C++ Builder 5: 70 компонентов ввода/вывода информации', 288, 2000, N'Программирование', N'Архангельский', N'Бином', N'Компоненты', 1)
,(N'Интегрированная среда разработки', 272, 2000, N'Программирование', N'Архангельский', N'Бином', N'Среда разработки', 2)
,(N'Visual Basic 6.0 for Application', 488, 2000, N'Программирование', N'Король', N'DiaSoft', N'Справочник с примерами', 3)
,(N'Visual Basic 6', 576, 2000, N'Программирование', N'Петрусос', N'BHV', N'Руководство разработчика 1-й том', 1)
,(N'Mathcad 2000', 416, 2000, N'Математические пакеты', N'Херхагер', N'BHV', N'Полное руководство', 1)
,(N'Novell GroupWise 5.5 система электронной почты и коллективной работы', 480, 2000, N'Сети', N'Гарбар', N'BHV', N'Сетевые пакеты', 2)
,(N'Реестр Windows 2000', 352, 2000, N'Операционные системы', N'Кокорева', N'BHV', N'Руководство для профессионалов', 4)
,(N'Самоучитель Visual FoxPro 6.0', 512, 1999, N'Базы данных', N'Омельченко', N'BHV', N'Самоучитель', 1)
,(N'Самоучитель FrontPage 2000', 512, 1999, N'Web-дизайн', N'Омельченко', N'BHV', N'Самоучитель', 1)
,(N'Самоучитель Perl', 432, 2000, N'Программирование', N'Матросов', N'BHV', N'Самоучитель', 2)
,( N'HTML 3.2', 1040, 2000, N'Web-дизайн', N'Браун', N'BHV', N'Руководство', 5)

-- Написать запросы:

-- 1. Отобразить список авторов книг без повторений. Отсортировать по возрастанию.
SELECT DISTINCT Author 
FROM books
ORDER BY Author ASC

-- 2. Отобразить книги по программированию издательств «Наука» и «BHV».
SELECT * FROM books
-- изначально была ошибка, GPT подсказал  использовать Unicode (с префиксом N)
--v1: 
--WHERE Themes = N'Программирование' AND (Press = N'Бином' OR Press = N'BHV')
--v2:
WHERE Themes = N'Программирование' AND (Press IN (N'Наука', N'BHV'))

-- 3. Отобразить все книги, у которых количество страниц лежит в пределах от 200 до 600.
SELECT * FROM books
--v1: 
--WHERE Pages > 200 AND Pages < 600
--v2:
WHERE Pages BETWEEN 200 AND 600


-- 4. Отобразить все книги, имена авторов которых лежат в диапазоне от буквы 'В' до 'О'. Отсортировать по возрастанию (по авторам).
-- ПРОБЛЕМА: в таком синтаксисе, квэри не работает, не пойсу почему
SELECT * FROM books
WHERE Author LIKE '[В-О]%'
-- advice from GPT doesn't work too: 
-- WHERE Author COLLATE Cyrillic_General_CI_AS LIKE '[В-О]%'
ORDER BY Author ASC;

-- 5. Выбрать книги, относящиеся к программированию или к базам данных, и издательства которых не 'Наука' и не 'Бином'.
SELECT * FROM books
WHERE 
(Themes = N'Программирование' OR Themes = N'Базы данных') 
AND 
Press NOT IN (N'Наука', N'Бином')

-- 6. Выбрать из таблицы тех авторов (без повторений), у которых в имени и фамилии не менее двух букв 'а'.
SELECT DISTINCT Author 
FROM books
-- ПРОБЛЕМА: в таком синтаксисе, квэри не работает, не пойсу почему
WHERE Author LIKE '%a%a%'
-- advice from GPT doesn't work too: 
--WHERE Author COLLATE Cyrillic_General_CI_AS LIKE '%а%а%';

-- 7. Отобразить всех авторов и их книги. Авторов отсортировать по возрастанию, а названия книг (по авторам) по убыванию (вторичная сортировка).
SELECT Author, [Name] AS 'Book name'
FROM books
ORDER BY Author ASC, [Name] DESC

-- 8. Выбрать из таблицы книги, названия которых начинаются с цифры.
SELECT [Name] AS 'Book name'
FROM books
WHERE [Name] LIKE '[0-9]%'

-- 9. Выбрать из таблицы книги, названия которых заканчиваются на четыре цифры.
SELECT [Name] AS 'Book name'
FROM books
WHERE [Name] LIKE '%[0-9][0-9][0-9][0-9]'

-- 10. Выбрать из таблицы книги, в названиях которых ровно две цифры.
SELECT [Name] AS 'Book name'
FROM books
WHERE [Name] LIKE '%[0-9]%[0-9]'
-- GPT подсказал что нужно исключать
AND [Name] NOT LIKE '%[0-9]%[0-9]%[0-9]%';

-- 11. Выбрать из таблицы книги, которые имеются в наличии в единственном экземпляре. Отсортировать по возрастанию.
SELECT [Name] AS 'Book name', Quantity 
FROM books
WHERE Quantity = 1
ORDER BY [Name] ASC


-- 12. Выбрать из таблицы книги по программированию, не относящиеся к издательству «BHV», в названиях которых есть слово «Visual».
SELECT [Name] AS 'Book name'
FROM books
WHERE Themes = N'Программирование' AND Press NOT IN (N'BHV') AND [Name] LIKE '%Visual%'

-- 13. Отобразить книги по программированию и Web-дизайну, которые относятся к издательствам «BHV» и «Бином».
SELECT [Name] AS 'Book name', Themes, Press
FROM books
WHERE Themes IN (N'Программирование', N'Web-дизайн') AND Press IN (N'BHV', N'Бином')

-- 14. Выбрать книги, являющиеся справочниками или руководством.
SELECT [Name] AS 'Book name', Comment
--ПРОБЛЕМА: я что-то делаю неправильно с кирилицей, поиск не осуществляется, бытался прилепит N, это не помогло
FROM books
--v1 совет GPT, моя версия была без COLLATE Cyrillic_General_CI_AS
--WHERE Comment COLLATE Cyrillic_General_CI_AS LIKE '%руковод%'
   --OR Comment COLLATE Cyrillic_General_CI_AS LIKE '%справоч%';
--v2 v1 совет GPT,
WHERE LOWER(Comment) LIKE '%руковод%'
   OR LOWER(Comment) LIKE '%справоч%';


-- 15. Отобразить книги, названия которых начинаются на английскую букву.
SELECT [Name] AS 'Book name'
FROM books
WHERE [Name] LIKE '[A-Z]%'
