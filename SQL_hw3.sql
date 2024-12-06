﻿CREATE DATABASE [WorldCup]
GO
USE [WorldCup]
GO
CREATE TABLE [dbo].[Teams](
	[Id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[country] [nvarchar](50) NULL,
	[Continent] [nvarchar](50) NULL,
	[Capital] [nvarchar](50) NULL,
	[Territory] [float] NULL,
	[Currency] [nvarchar](50) NULL,
	[Language] [nvarchar](50) NULL,
	[Debut] [bit] NULL,
	[Champion] [int] NULL
) ON [PRIMARY]
GO

INSERT [dbo].[Teams] ([country], [Continent], [Capital], [Territory], [Currency], [Language], [Debut], [Champion]) 
VALUES (N'Украина', N'Европа', N'Киев', 603.7, N'гривна', N'украинский', 1, 0),
(N'Франция', N'Европа', N'Париж', 545.63, N'евро', N'французский', 0, 1),
(N'Тунис', N'Африка', N'Тунис', 155.36, N'тунисский динар', N'арабский', 0, 0),
(N'Ангола', N'Африка', N'Луанда', 1246.7, N'кванза', N'португальский', 1, 0),
(N'Япония', N'Азия', N'Токио', 374.744, N'иена', N'японский', 0, 0),
(N'Бразилия', N'Южная Америка', N'Бразилиа', 8456.51, N'бразильский реал', N'португальский', 0, 5),
(N'Испания', N'Европа', N'Мадрид', 499.542, N'евро', N'испанский', 0, 0),
(N'Италия', N'Европа', N'Рим', 294.02, N'евро', N'итальянский', 0, 4),
(N'Тринидад и Тобаго', N'Центральная Америка', N'Порт-оф-Спейн', 5.1, N'доллар Тринидад и Тобаго', N'английский', 1, 0),
(N'Германия', N'Европа', N'Берлин', 349.223, N'евро', N'немецкий', 0, 3),
(N'Аргентина', N'Южная Америка', N'Буэнос-Айрес', 2736.69, N'аргентинский песо', N'испанский', 0, 2),
(N'Парагвай', N'Южная Америка', N'Асунсьон', 397.3, N'гуарани', N'испанский', 0, 0),
(N'Южная Корея', N'Азия', N'Сеул', 98.19, N'вона', N'корейский', 0, 0),
(N'Коста-Рика', N'Центральная Америка', N'Сан-Хосе', 50.66, N'колон', N'испанский', 0, 0),
(N'Польша', N'Европа', N'Варшава', 304.465, N'злотый', N'польский', 0, 0),
(N'США', N'Северная Америка', N'Вашингтон', 9158.96, N'доллар США', N'английский', 0, 0),
(N'Португалия', N'Европа', N'Лиссабон', 91.951, N'евро', N'португальский', 0, 0),
(N'Саудовская Аравия', N'Азия', N'Эр-Рияд', 1960.582, N'саудовский риал', N'арабский', 0, 0),
(N'Англия', N'Европа', N'Лондон', 129.634, N'фунт стерлингов', N'английский', 0, 1),
(N'Швеция', N'Европа', N'Стокгольм', 410.934, N'шведская крона', N'шведский', 0, 0),
(N'Эквадор', N'Южная Америка', N'Кито', 276.84, N'доллар США', N'испанский', 0, 0),
(N'Хорватия', N'Европа', N'Загреб', 56.414, N'куна', N'хорватский', 0, 0),
(N'Мексика', N'Центральная Америка', N'Мехико', 1923.04, N'мексиканский песо', N'испанский', 0, 0),
(N'Кот-д''Ивуар', N'Африка', N'Ямусукро', 322.5, N'франк', N'французский', 1, 0),
(N'Нидерланды', N'Европа', N'Амстердам', 41.5, N'евро', N'нидерландский', 0, 0),
(N'Швейцария', N'Европа', N'Берн', 41.3, N'швейцарский франк', N'немецкий', 0, 0),
(N'Того', N'Африка', N'Ломе', 56.6, N'франк', N'французский', 1, 0),
(N'Иран', N'Азия', N'Тегеран', 1650, N'риал', N'персидский', 0, 0),
(N'Австралия', N'Австралия', N'Канберра', 7700, N'австралийский доллар', N'английский', 0, 0),
(N'Сербия и Черногория', N'Европа', N'Белград', 102.2, N'динар', N'сербский', 0, 0),
(N'Гана', N'Африка', N'Аккра', 238.5, N'седи', N'английский', 1, 0),
(N'Чехия', N'Европа', N'Прага', 78.9, N'крона', N'чешский', 0, 0)

----------------------
-- Обязательно: выполнить любые 5 запросов
-- Дополнительно: выполнить все 10 запросов

SELECT * FROM Teams
--1. Определить количество стран-участниц чемпионата мира.
SELECT COUNT(country) AS [Qty of countries]
FROM Teams

--2. Определить количество стран, становившихся чемпионами мира.
--my version:
SELECT COUNT(country) AS [Qty of countries who were champion]
--GPT adviced when I checked:
--SELECT COUNT(DISTINCT country) AS [Qty of countries who were champion]
FROM Teams
WHERE Champion > 0

--3. Определить количество стран-участниц чемпионата мира, в которых официальным языком является испанский язык.
-- the same principe as in 2 only other condition
SELECT COUNT(country) AS [Qty of Spanish speaking countries]
FROM Teams
WHERE [Language] = N'испанский'

--4. Определить количество дебютантов чемпионата мира.
SELECT COUNT(country) AS [Qty of debute countries]
FROM Teams
WHERE Debut > 0

--5. Определить наибольшую территорию из всех стран-участниц. (2 варианта)
--v1:
SELECT TOP 1 Territory AS [Biggest territory]
FROM Teams
ORDER BY Territory DESC
--v2:
SELECT MAX(Territory) AS [Biggest territory]
FROM Teams


--6. Определить наибольшую территорию из всех европейских стран-участниц. (2 варианта)
--v1:
SELECT TOP 1 Territory AS [Biggest territory in Europe]
FROM Teams
WHERE Continent = N'Европа'
ORDER BY Territory DESC
--v2:
SELECT MAX(Territory) AS [Biggest territory in Europe]
FROM Teams
WHERE Continent = N'Европа'

--7. Определить суммарное количество чемпионских титулов, выигранных странами участницами.
SELECT SUM(Champion) AS [Summary qty of champions titles]
FROM Teams

--8. Определить суммарное количество чемпионских титулов, выигранных европейскими странами участницами.
SELECT SUM(Champion) AS [Summary qty of champions titles won by Europe contries]
FROM Teams
WHERE Continent = N'Европа'

--9. Определить наименьшую территорию из всех американских стран-участниц. (2 варианта)
--v1:
SELECT MIN(Territory) AS [Min territory in America contries]
FROM Teams
WHERE Continent LIKE N'%Америка%'
--v2:
SELECT TOP 1 Territory AS [Min territory in America contries]
FROM Teams
WHERE Continent LIKE N'%Америка%'
ORDER BY Territory

--10. Определить среднее значение территории среди африканских стран.
SELECT AVG(Territory) AS [Average territory among Africans countries]
FROM Teams
WHERE Continent LIKE N'Африка'
