--Homework 7

--Написати такі тригери: 

--Щоб під час узяття певної книги, її кількість зменшувалася на 1. 
CREATE TRIGGER trg_DecreaseBookQuantity
ON [dbo].[S_Cards]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Уменьшаем количество книг на 1
    UPDATE [dbo].[Books]
    SET Quantity = Quantity - 1
    FROM [dbo].[Books]
    INNER JOIN inserted i ON [dbo].[Books].Id = i.Id_Book;

    -- Проверяем, чтобы количество книг не стало отрицательным
    IF EXISTS (
        SELECT 1
        FROM [dbo].[Books]
        WHERE Quantity < 0
    )
    BEGIN
        -- Если количество меньше 0, транзакция отменяется
        RAISERROR ('Не можно выдать книгу, которой нет в библиотеке', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO


--Щоб при поверненні певної книги, її кількість збільшувалася на 1. 
CREATE TRIGGER trg_IncreaseBookQuantity
ON [dbo].[S_Cards]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Проверяем, если поле DateIn было обновлено (книга возвращена)
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN deleted d ON i.Id = d.Id
        WHERE i.DateIn IS NOT NULL AND d.DateIn IS NULL
    )
    BEGIN
        -- Увеличиваем количество книг на 1
        UPDATE [dbo].[Books]
        SET Quantity = Quantity + 1
        FROM [dbo].[Books]
        INNER JOIN inserted i ON [dbo].[Books].Id = i.Id_Book;
    END
END;
GO


--Щоб не можна було видати книжку, якої вже немає в бібліотеці (за кількістю). 
CREATE TRIGGER trg_ProhibitIfNoBooks
ON [dbo].[S_Cards]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Проверяем, есть ли книги в наличии
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN [dbo].[Books] b ON i.Id_Book = b.Id
        WHERE b.Quantity <= 0
    )
    BEGIN
        -- Если книги нет в наличии, транзакция отменяется
        RAISERROR ('Эта книга уже закончилась в библиотеке', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        -- Если книги есть, разрешаем вставку записи
        INSERT INTO [dbo].[S_Cards] (Id_Student, Id_Book, DateOut, DateIn, Id_Lib)
        SELECT Id_Student, Id_Book, DateOut, DateIn, Id_Lib
        FROM inserted;
    END
END;
GO


--Щоб не можна було видати більше трьох книг одному студенту.
--Щоб при видаленні книги, дані про неї копіювалися в таблицю Видалені (створити цю таблицю). 
CREATE TABLE [dbo].[Deleted_Books] (
    [Id] INT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Pages] INT NOT NULL,
    [YearPress] INT NOT NULL,
    [Id_Themes] INT NOT NULL,
    [Id_Category] INT NOT NULL,
    [Id_Author] INT NOT NULL,
    [Id_Press] INT NOT NULL,
    [Comment] NVARCHAR(50) NULL,
    [Quantity] INT NOT NULL,
    [DeletedAt] DATETIME DEFAULT GETDATE()
);
GO

CREATE TRIGGER trg_CopyDeletedBook
ON [dbo].[Books]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Добавляем книгу в таблицу Deleted_Books
    INSERT INTO [dbo].[Deleted_Books] 
    (Id, Name, Pages, YearPress, Id_Themes, Id_Category, Id_Author, Id_Press, Comment, Quantity, DeletedAt)
    SELECT 
        Id, Name, Pages, YearPress, Id_Themes, Id_Category, Id_Author, Id_Press, Comment, Quantity, GETDATE()
    FROM deleted;
END;
GO


--Якщо книжка додається в базу, вона має бути видалена з таблиці Видалені.
-- Тригер видаляє записи з таблиці Deleted_Books, якщо книга знову додається у таблицю Books
CREATE TRIGGER trg_RemoveFromDeletedOnInsert
ON [dbo].[Books]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Удаляем книгу из таблицы
    DELETE FROM [dbo].[Deleted_Books]
    WHERE Id IN (SELECT Id FROM inserted);
END;
GO
