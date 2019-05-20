USE [Universities]
GO

CREATE TABLE Stores_pr(
id	INT	NOT NULL PRIMARY KEY,
name_table	nvarchar(50) NOT NULL,
name_column	nvarchar(50) NOT NULL,
tek_max	INT	,
)
GO

INSERT INTO Stores_pr VALUES (1,'Stores_pr', 'id', 1); 

CREATE PROCEDURE [dbo].[Store_p]
@name_t VARCHAR(50), @name_c VARCHAR(50), @res int OUTPUT
AS
BEGIN
  DECLARE  @tek int 
  SELECT @tek = tek_max FROM Stores_pr  WHERE name_table = @name_t  AND name_column = @name_c
  SELECT @tek
   IF (@tek is not null)
     begin
	    SET @res = @tek + 1
		--обновляем данные во вспомогательной таблице
	    UPDATE Stores_pr SET tek_max = @res WHERE name_table = @name_t  AND name_column = @name_c
	 end
   ELSE 
	 begin
	  --находим максиальное значение в нужном столбце нужной таблицы
	 DECLARE  @tek1 nvarchar(max)
     SET @tek1 = 'SELECT @RES = MAX(' + QUOTENAME(@name_c) + ') FROM ' + QUOTENAME(@name_t)
	 EXECUTE sp_executesql @tek1, N'@RES INT OUTPUT', @RES = @res OUTPUT
	 --DECLARE @trig nvarchar (max)
	 --SET @trig = '
	 --CREATE TRIGGER' + QUOTENAME('GO_' + (@name_t) + CAST(NEWID() AS nvarchar(128))) +
	 --'ON ' + QUOTENAME(@name_t) + 'AFTER INSERT, UPDATE, DELETE
  --    AS
  --    BEGIN
  --      --находим новое макимальное знчение в таблице @name_t в столбце @name_c 
		-- DECLARE  @max int, @max1 int 
		-- SELECT @max = MAX(' + QUOTENAME(@name_c) + ') FROM' + QUOTENAME(@name_t) + '
  --      --если максимальное значение в таблице @name_t в столбце @name_c изменилось, 
  --      --то мы должны обновить данные в таблице Stores_pr
	 --   UPDATE Stores_pr SET tek_max = @max WHERE name_table = ' + QUOTENAME(@name_t, '''') + 'AND name_column = ' + QUOTENAME(@name_c, '''') +
  --  ' END'
	 -- EXEC(@trig)
	 --находим максимальное значение во вспомогательной таблице
	 DECLARE @result1 int
	 EXECUTE [dbo].[Store_p] 'Stores_pr', 'id', @result1 OUTPUT
	 IF (@RES is not null)
	     begin
			 SET @res = @RES + 1
			 --записываем результат во вспомогательную таблицу
	         INSERT INTO Stores_pr VALUES (@result1, @name_t, @name_c, @res)
		  end
	   ELSE 
		 begin
			 --записываем результат во вспомогательную таблицу
			 INSERT INTO Stores_pr VALUES (@result1, @name_t, @name_c, 1)
	         SET @res = 1
		 end 
	 END
END
GO

DECLARE @result int
EXECUTE [dbo].[Store_p] 'Stores_pr', 'id', @result OUTPUT
SELECT @result AS MAXIMUM
GO

SELECT * FROM Stores_pr

CREATE TABLE test(
id	INT	NOT NULL PRIMARY KEY
)
GO

INSERT INTO test1 VALUES (10); 

SELECT * FROM test1

DECLARE @result int
EXECUTE [dbo].[Store_p] 'test1', 'id', @result OUTPUT
SELECT @result AS MAXIMUM


CREATE TABLE test2(
numValue1 nvarchar(50) NOT NULL,
numValue2 nvarchar(50) NOT NULL
)
GO

DECLARE @result int
EXECUTE [dbo].[Store_p] 'test2', 'numValue1', @result OUTPUT
SELECT @result AS MAXIMUM


INSERT INTO test2 VALUES (20,13); 

SELECT * FROM test2

DECLARE @result int
EXECUTE [dbo].[Store_p] 'test2', 'numValue2', @result OUTPUT
SELECT @result AS MAXIMUM
GO

CREATE TABLE test(
num int NULL
)
GO

DECLARE @result int
EXECUTE [dbo].[Store_p] 'test', 'num', @result OUTPUT
SELECT @result AS MAXIMUM
GO

SELECT * FROM Stores_pr

INSERT INTO test VALUES (25);
INSERT INTO test VALUES (30);
UPDATE test SET num = 40 WHERE num = 25
DELETE FROM test WHERE num = 40

SELECT * FROM test

ALTER TRIGGER Trig
ON test FOR INSERT
AS
IF @@ROWCOUNT > 0
--в таблицу test добавляется новая запись 
BEGIN
    --находим новое макимальное знчение в столбце 'num' таблицы 'test'
    DECLARE @max int, @maxs int
    SELECT @max = MAX(inserted.num) FROM  inserted 
    --если максимальное значение в таблице 'test1' в столбце 'num' изменилось, 
    --то мы должны обновить данные в таблице 'Stores_pr'
	SELECT @maxs = (SELECT tek_max FROM Stores_pr WHERE name_column = 'num' AND name_table = 'test')
    IF @max+1 <> @maxs
       --обновляем данные во вспомогательной таблице 'Stores_pr'
	   UPDATE Stores_pr SET tek_max = @max+1 WHERE name_table = 'test'  AND name_column = 'num'
END
GO

CREATE TRIGGER Trig2
ON test FOR INSERT
AS
IF @@ROWCOUNT > 0
--в таблицу test добавляется новая запись 
BEGIN
    --находим новое макимальное знчение в столбце 'num2' таблицы 'test'
    DECLARE @max int, @maxs int
    SELECT @max = MAX(inserted.num2) FROM  inserted 
    --если максимальное значение в таблице 'test' в столбце 'num2' изменилось, 
    --то мы должны обновить данные в таблице 'Stores_pr'
	SELECT @maxs = (SELECT tek_max FROM Stores_pr WHERE name_column = 'num2' AND name_table = 'test')
    IF @max+1 <> @maxs
       --обновляем данные во вспомогательной таблице 'Stores_pr'
	   UPDATE Stores_pr SET tek_max = @max+1 WHERE name_table = 'test'  AND name_column = 'num2'
END
GO

ALTER TABLE test ADD num2 int NULL  

DECLARE @result int
EXECUTE [dbo].[Store_p] 'test', 'num2', @result OUTPUT
SELECT @result AS MAXIMUM
GO

SELECT * FROM Stores_pr

INSERT INTO test VALUES (15,12);

SELECT * FROM test

DROP TABLE test1
DROP TABLE Stores_pr
DROP TABLE test2
DROP TABLE test
DROP PROC [dbo].[Store_p]
DROP TRIGGER Trig