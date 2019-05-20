USE [Universities]
GO

CREATE TABLE Stores_pr(
id	INT	NOT NULL PRIMARY KEY,
name_table	nvarchar(50) NOT NULL,
name_column	nvarchar(50) NOT NULL,
tek_max	INT	,
)

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
	 end
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

INSERT INTO test VALUES (10); 

SELECT * FROM test

DECLARE @result int
EXECUTE [dbo].[Store_p] 'test', 'id', @result OUTPUT
SELECT @result AS MAXIMUM
GO


CREATE TABLE test2(
numValue1 nvarchar(50) NOT NULL,
numValue2 nvarchar(50) NOT NULL
)

DECLARE @result int
EXECUTE [dbo].[Store_p] 'test2', 'numValue1', @result OUTPUT
SELECT @result AS MAXIMUM
GO

INSERT INTO test2 VALUES (20,13); 
SELECT * FROM test2

DECLARE @result int
EXECUTE [dbo].[Store_p] 'test2', 'numValue2', @result OUTPUT
SELECT @result AS MAXIMUM
GO


DROP TABLE test2, test, Stores_pr
DROP PROC [dbo].[Store_p]

