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
   IF (@tek is not null)
     begin
	    SET @res = @tek + 1
		--обновляем данные во вспомогательной таблице
	    UPDATE Stores_pr SET tek_max = @res WHERE name_table = @name_t  AND name_column = @name_c
	 end
   ELSE 
	 BEGIN
	 --находим максиальное значение в нужном столбце нужной таблицы
	 DECLARE  @tek1 nvarchar(max)
     SET @tek1 = 'SELECT @RES = MAX(' + QUOTENAME(@name_c) + ') FROM ' + QUOTENAME(@name_t)
	 EXECUTE sp_executesql @tek1, N'@RES INT OUTPUT', @RES = @res OUTPUT
	 DECLARE @trig nvarchar (max)
	 SET @trig = '
	 CREATE TRIGGER' + QUOTENAME((@name_t) + CAST(NEWID() AS nvarchar(128))) +
	 'ON ' + QUOTENAME(@name_t) + 'AFTER INSERT, UPDATE, DELETE
     AS
     BEGIN
     --находим новое макимальное знчение в таблице @name_t в столбце @name_c 
     DECLARE  @max int, @max1 int 
     SELECT @max = MAX(' + QUOTENAME(@name_c) + ') FROM' + QUOTENAME(@name_t) + '
     --если максимальное значение в таблице @name_t в столбце @name_c изменилось, 
     --то мы должны обновить данные в таблице Stores_pr
     UPDATE Stores_pr SET tek_max = @max WHERE name_table = ' + QUOTENAME(@name_t, '''') + 'AND name_column = ' + QUOTENAME(@name_c, '''') +
     'END'
	 EXEC(@trig)
	 --находим максимальное значение во вспомогательной таблице
	 DECLARE @result1 int
	 EXECUTE [dbo].[Store_p] 'Stores_pr', 'id', @result1 OUTPUT
	 DECLARE  @inf int  
     SELECT @inf = count(*) FROM Stores_pr  WHERE name_table = @name_t  AND name_column = @name_c
	 SELECT @inf
	 if (@RES is not null)
	   begin
		 	 SET @res = @RES + 1
			 --записываем результат во вспомогательную таблицу
	         INSERT INTO Stores_pr VALUES (@result1, @name_t, @name_c, @res)
	   end
	 else 
	   begin
		 if (@inf > 0)
	       begin
		   --обновляем данные во вспомогательной таблице
	       UPDATE Stores_pr SET tek_max = 1 WHERE name_table = @name_t  AND name_column = @name_c	
		   SET @res = 1
		   end
		 else 
		   begin --записываем результат во вспомогательную таблицу
			 INSERT INTO Stores_pr VALUES (@result1, @name_t, @name_c, 1)
	         SET @res = 1
		   end
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
num int NULL
)
GO

DECLARE @result int
EXECUTE [dbo].[Store_p] 'test', 'num', @result OUTPUT
SELECT @result AS MAXIMUM
GO

SELECT * FROM Stores_pr
SELECT * FROM test

INSERT INTO test VALUES (27);
INSERT INTO test VALUES (30);
UPDATE test SET num = 40 WHERE num = 25
DELETE FROM test WHERE num = 30
DELETE FROM test WHERE num = 27

ALTER TABLE test ADD num2 int NULL  

DECLARE @result int
EXECUTE [dbo].[Store_p] 'test', 'num2', @result OUTPUT
SELECT @result AS MAXIMUM
GO

SELECT * FROM Stores_pr
SELECT * FROM test

INSERT INTO test VALUES (15,12);
INSERT INTO test VALUES (35,11);
INSERT INTO test VALUES (40,20);
UPDATE test SET num = 50 WHERE num > 15 
DELETE FROM test WHERE num = 50


DROP TABLE test
DROP TABLE Stores_pr
DROP PROC [dbo].[Store_p]