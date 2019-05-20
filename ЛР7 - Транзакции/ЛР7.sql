use [gift_shop]
go

--1.1--
DECLARE @errorMessage nvarchar(4000), @errorSeverity int
begin transaction ins
   begin try
		insert into [������_�_�������] values ('���1',5,2, '��',789)

		select * from [������_�_�������]

   end try
   begin catch 
	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
     raiserror (@errorMessage, @errorSeverity, 1)
  end catch

--commit

rollback transaction

rollback transaction ins
select * from [������_�_�������]

--1.2--
DECLARE @errorMessage nvarchar(4000), @errorSeverity int
begin transaction up
    begin try
		update [������_�_�������] set [��� ������ ������] = 1 
		     where [������������ ������] = '�����' OR [������������ ������] = '����'

		select * from [������_�_�������]

	end try
    begin catch 
	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
     raiserror (@errorMessage, @errorSeverity, 1)
    end catch

rollback transaction up
select * from [������_�_�������]

--1.3--
DECLARE @errorMessage nvarchar(4000), @errorSeverity int
begin transaction ins_up
	begin try
        insert into [������_�_�������] values ('�������',5,2, '��',789)

		select * from [������_�_�������]

		update [������_�_�������] set [��� ������ ������] = 1 
		     where [������������ ������] = '�����' OR [������������ ������] = '����'

		select * from [������_�_�������]

	end try
    begin catch 
     if @@TRANCOUNT > 0 rollback
	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
     raiserror (@errorMessage, @errorSeverity, 1)
  end catch

rollback transaction ins_up
select * from [������_�_�������]


--2.1--
 ALTER TABLE [dbo].[������_�_�������]  WITH CHECK ADD CONSTRAINT [FK_������_�_�������_����_���_�������] CHECK ([���� ��� �������] >= 0) 
 
 DECLARE @errorMessage nvarchar(4000), @errorSeverity int
 begin transaction ins_zero
  begin try
        insert into [������_�_�������] values ('�������',5,2, '��', -1)

		select * from [������_�_�������]
	commit
   end try
   begin catch 
     if @@TRANCOUNT > 0 rollback transaction ins_zero
	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
     raiserror (@errorMessage, @errorSeverity, 1)
   end catch


--3--
DECLARE @errorMessage nvarchar(4000), @errorSeverity int
 begin transaction ins_up_del
  begin try
        
		insert into [������_�_�������] values ('��� � "',2,1, '��', 25)

		select * from [������_�_�������]
		
		WAITFOR DELAY '00:00:10'

		select * from [������_�_�������]
	commit transaction ins_up_del
   end try
   begin catch 
     if @@TRANCOUNT > 0 rollback  transaction ins_up_del
	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
     raiserror (@errorMessage, @errorSeverity, 1)
   end catch

select * from [������_�_�������]

SHUTDOWN WITH NOWAIT


DBCC USEROPTIONS

--���������� ����������-- 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

DECLARE @errorMessage nvarchar(4000), @errorSeverity int
--begin transaction ins_up_sl
--	begin try
--	    WAITFOR DELAY '00:00:05'
--	    update [������_�_�������] set [������������ ������] = '������' 
--		     where [������������ ������] = '����'
--		select * from [������_�_�������] 
--	end try
--    begin catch 
--     if @@TRANCOUNT > 0 rollback  transaction ins_up_sl
--	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
--     raiserror (@errorMessage, @errorSeverity, 1)
--  end catch

-- select * from [������_�_�������]
-- rollback transaction

begin transaction ins_up1
	begin try
	    update [������_�_�������] set [������������ ������] = '��� � ��������' 
		     where [������������ ������] = '��� � c��������'
		select * from [������_�_�������]
		commit transaction ins_up1
	end try
    begin catch 
     if @@TRANCOUNT > 0 rollback
	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
     raiserror (@errorMessage, @errorSeverity, 1)
  end catch

rollback transaction ins_up1
select * from [������_�_�������]

--�������� ������--
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @errorMessage nvarchar(4000), @errorSeverity int
--begin transaction ins_up_sl
--	begin try
--	    declare @price int

--		select @price = [���� ��� �������] from [������_�_�������] where [������������ ������] = '��������'
        
--		update [������_�_�������] set [���� ��� �������] = @price + 50
--		     where [������������ ������] = '��������'
	    
--		waitfor delay '00:00:10'

--		rollback transaction  ins_up_sl
--		select * from [������_�_�������]
--	end try
--    begin catch 
--     if @@TRANCOUNT > 0 rollback transaction ins_up_sl
--	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
--     raiserror (@errorMessage, @errorSeverity, 1)
--  end catch

begin transaction ins_up1
	begin try

	   declare @price int

		select @price = [���� ��� �������] from [������_�_�������] where [������������ ������] = '�����'
		update [������_�_�������] set [���� ��� �������] = @price + 50
		     where [������������ ������] = '�����'

		commit transaction ins_up
		select * from [������_�_�������]

	end try
    begin catch 
     if @@TRANCOUNT > 0 rollback
	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
     raiserror (@errorMessage, @errorSeverity, 1)
  end catch

--��������������� ������--
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

DECLARE @errorMessage nvarchar(4000), @errorSeverity int
--begin transaction up
--	begin try
--	    select * from [������_�_�������]

--		waitfor delay '00:00:10'

--		select * from [������_�_�������]

--	    commit transaction up
--	end try
--    begin catch 
--     if @@TRANCOUNT > 0 rollback transaction up
--	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
--     raiserror (@errorMessage, @errorSeverity, 1)
--  end catch

begin transaction up
	begin try   
		update [������_�_�������] set [��� ������ ������] = 2 
		     where [������������ ������] = '����'
		commit transaction
	end try
    begin catch 
     if @@TRANCOUNT > 0 rollback
	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
     raiserror (@errorMessage, @errorSeverity, 1)
  end catch


--��������� ������--
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

 DECLARE @errorMessage nvarchar(4000), @errorSeverity int
 --begin transaction ins
 -- begin try
	--	select SUM([���� ��� �������]) from [������_�_�������] where [��� ������ ������] = 2

	--	WAITFOR DELAY '00:00:10'

	--	select SUM([���� ��� �������]) from [������_�_�������] where [��� ������ ������] = 2

	--	commit transaction ins
 --  end try
 --  begin catch 
 --    if @@TRANCOUNT > 0 rollback transaction ins
	-- select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
 --    raiserror (@errorMessage, @errorSeverity, 1)
 --  end catch

 begin transaction ins
  begin try
		insert into [������_�_�������] values ('������', 2, 2, '��' ,1200)
		commit transaction
   end try
   begin catch 
     if @@TRANCOUNT > 0 rollback
	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
     raiserror (@errorMessage, @errorSeverity, 1)
   end catch

   delete from ������_�_������� where [������������ ������] = '������'
