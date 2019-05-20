USE [Universities]
GO

CREATE TABLE Stores_pr(
id	INT	NOT NULL PRIMARY KEY,
name_table	nvarchar(50) NOT NULL,
name_column	nvarchar(50) NOT NULL,
tek_max	INT	,
)
GO

delete from Stores_pr WHERE name_column = 'num'
delete from Stores_pr WHERE name_column = 'num2'

INSERT INTO Stores_pr VALUES (1,'Stores_pr', 'id', 1); 

Create PROCEDURE [dbo].[Store_p]
@name_t VARCHAR(50), @name_c VARCHAR(50), @res int OUTPUT
AS
BEGIN
  declare @object_t int, @object_t_f nvarchar(max), @tek int , @tek1 nvarchar(max), @object_type nvarchar, @object_type_f nvarchar(max),  @trigger_name nvarchar(max)
  declare @inf int, @trig nvarchar (max),@result1 int, @object_c int, @object_c_f nvarchar(max), @trig_number int, @trig_number_f  nvarchar(max), @trig_name int,@trig_name_f nvarchar(max)
  --���������� ������� �� ������� � ���� ������ 
  SET @object_t_f = 'SELECT @col = object_id FROM sys.objects WHERE name =' + QUOTENAME(@name_t,'''')
  EXECUTE sp_executesql @object_t_f, N'@col INT OUTPUT', @col = @object_t OUTPUT
  --���������� ������� �� ������� � �������
  SET @object_c_f = 'SELECT @col1 = sys.objects.object_id FROM sys.objects, sys.columns 
                     WHERE sys.objects.name =' + QUOTENAME(@name_t,'''') + 'AND
				     sys.columns.name = '+ QUOTENAME(@name_c,'''')
  EXECUTE sp_executesql @object_c_f, N'@col1 INT OUTPUT', @col1 = @object_c OUTPUT
  --���������� ��� �������� � �������
  SET @object_type_f = 'SELECT @type_col = DATA_TYPE FROM information_schema.COLUMNS 
                     WHERE TABLE_NAME =' + QUOTENAME(@name_t,'''') + 'AND
				     COLUMN_NAME = '+ QUOTENAME(@name_c,'''') 			 
  EXECUTE sp_executesql @object_type_f, N'@type_col nvarchar OUTPUT', @type_col = @object_type OUTPUT
  if (@object_t is not null)
   begin
    if (@object_c is not null)
	begin
	  if (@object_type = 'i')
      begin  
       --���������� ������������ �������� � ������ ������ ����������� �������
       SELECT @tek = tek_max FROM Stores_pr  WHERE name_table = @name_t  AND name_column = @name_c
       --���� ����� ������ ����,��������� ������
       if(@tek is not null)
        begin
	     SET @res = @tek + 1
		 --��������� ������ �� ��������������� �������
	     UPDATE Stores_pr SET tek_max = @res WHERE name_table = @name_t  AND name_column = @name_c
	    end
       else 
	   --���� ����� ������ ��� � ����. ������� 
	    begin
	    --������� ����������� �������� � ������ ������� ������ �������
        SET @tek1 = 'SELECT @RES = MAX(' + QUOTENAME(@name_c) + ') FROM ' + QUOTENAME(@name_t)
	    EXECUTE sp_executesql @tek1, N'@RES INT OUTPUT', @RES = @res OUTPUT
	    SET @trig_number_f = 'SELECT @t_namb = COUNT(*) FROM sys.triggers, sys.objects 
                              WHERE sys.objects.name =' + QUOTENAME(@name_t,'''')
	    EXECUTE sp_executesql @trig_number_f, N'@t_namb INT OUTPUT', @t_namb = @trig_number OUTPUT
	    SET @trig_number = @trig_number + 1
		
		--���������, ���� �� ������� � ����� ������
		set @trig_name = 1
		WHILE (@trig_name > 0)
		begin
		set @trigger_name = @name_t + '_' + @name_c  + '_' + CAST(@trig_number AS nvarchar(10))
		SELECT  @trig_name = COUNT(*) FROM sys.objects  WHERE sys.objects.name = @trigger_name
		if (@trig_name > 0)
		set @trig_number = @trig_number + 1;
		end 
		
	    --������� ������� ��� ������� ������� ��������� 
	    SET @trig = 'CREATE TRIGGER' + QUOTENAME(@name_t + '_' + @name_c  + '_' + CAST(@trig_number AS nvarchar(10))) +
	        	  'ON ' + QUOTENAME(@name_t) + 'AFTER INSERT, UPDATE, DELETE
				  AS
				  BEGIN
				  --������� ����� ����������� ������� � ������� @name_t � ������� @name_c 
				  DECLARE  @max int, @max1 int 
				  SELECT @max = MAX(' + QUOTENAME(@name_c) + ') FROM' + QUOTENAME(@name_t) + 
				  '--���� ������������ �������� � ������� @name_t � ������� @name_c ����������, 
				  --�� �� ������ �������� ������ � ������� Stores_pr
				  UPDATE Stores_pr SET tek_max = @max WHERE name_table = ' + QUOTENAME(@name_t, '''') + 'AND name_column = ' + QUOTENAME(@name_c, '''') +
				 'END'
	  EXEC(@trig)
	  --������� ������������ �������� �� ��������������� �������
	  EXECUTE [dbo].[Store_p] 'Stores_pr', 'id', @result1 OUTPUT  
      SELECT @inf = count(*) FROM Stores_pr  WHERE name_table = @name_t  AND name_column = @name_c
	  if (@RES is not null)
	   begin
		 	 SET @res = @RES + 1
			 --���������� ��������� �� ��������������� �������
	         INSERT INTO Stores_pr VALUES (@result1, @name_t, @name_c, @res)
	   end
	  else 
	   begin
		 if (@inf > 0)
	       begin
		   --��������� ������ �� ��������������� �������
	       UPDATE Stores_pr SET tek_max = 1 WHERE name_table = @name_t  AND name_column = @name_c	
		   SET @res = 1
		   end
		 else 
		   begin --���������� ��������� �� ��������������� �������
			 INSERT INTO Stores_pr VALUES (@result1, @name_t, @name_c, 1)
	         SET @res = 1
		   end
	   end 
     end
      end
	  else THROW 50003, 'The culumn is not integer type.', 1
	end
    else THROW 50002, 'The column does not exist.', 1
   end
  else THROW 50001, 'The table does not exist.', 1
END
GO

CREATE TRIGGER test_num_2
ON test AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  --������� ����� ����������� ������� � ������� @name_t � ������� @name_c 
   DECLARE  @max int, @max1 int 
   SELECT @max = MAX(test) FROM num
  --���� ������������ �������� � ������� @name_t � ������� @name_c ����������, 
  --�� �� ������ �������� ������ � ������� Stores_pr
	UPDATE Stores_pr SET tek_max = @max WHERE name_table = 'test' AND name_column = 'num'
END

 Select name FROM sys.objects WHERE sys.objects.type = 'TR'

DECLARE @result int
EXECUTE [dbo].[Store_p] 'Stores_pr', 'id', @result OUTPUT
SELECT @result AS MAXIMUM
GO

SELECT * FROM Stores_pr

DECLARE @result int
EXECUTE [dbo].[Store_p] 'test', 'num', @result OUTPUT
SELECT @result AS MAXIMUM
GO

CREATE TABLE test(
num int NULL
)
GO

ALTER TABLE test ADD num2 int NULL    

DECLARE @result int
EXECUTE [dbo].[Store_p] 'test', 'num2', @result OUTPUT
SELECT @result AS MAXIMUM
GO

ALTER TABLE test ADD num3 varchar NULL

DECLARE @result int
EXECUTE [dbo].[Store_p] 'test', 'num3', @result OUTPUT
SELECT @result AS MAXIMUM
GO

DROP TABLE test
DROP TABLE Stores_pr
DROP PROC [dbo].[Store_p]