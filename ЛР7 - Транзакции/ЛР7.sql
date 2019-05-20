use [gift_shop]
go

--1.1--
DECLARE @errorMessage nvarchar(4000), @errorSeverity int
begin transaction ins
   begin try
		insert into [Данные_о_товарах] values ('Фея1',5,2, 'шт',789)

		select * from [Данные_о_товарах]

   end try
   begin catch 
	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
     raiserror (@errorMessage, @errorSeverity, 1)
  end catch

--commit

rollback transaction

rollback transaction ins
select * from [Данные_о_товарах]

--1.2--
DECLARE @errorMessage nvarchar(4000), @errorSeverity int
begin transaction up
    begin try
		update [Данные_о_товарах] set [код группы товара] = 1 
		     where [наименование товара] = 'Кошка' OR [наименование товара] = 'Слон'

		select * from [Данные_о_товарах]

	end try
    begin catch 
	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
     raiserror (@errorMessage, @errorSeverity, 1)
    end catch

rollback transaction up
select * from [Данные_о_товарах]

--1.3--
DECLARE @errorMessage nvarchar(4000), @errorSeverity int
begin transaction ins_up
	begin try
        insert into [Данные_о_товарах] values ('Русалка',5,2, 'шт',789)

		select * from [Данные_о_товарах]

		update [Данные_о_товарах] set [код группы товара] = 1 
		     where [наименование товара] = 'Кошка' OR [наименование товара] = 'Слон'

		select * from [Данные_о_товарах]

	end try
    begin catch 
     if @@TRANCOUNT > 0 rollback
	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
     raiserror (@errorMessage, @errorSeverity, 1)
  end catch

rollback transaction ins_up
select * from [Данные_о_товарах]


--2.1--
 ALTER TABLE [dbo].[Данные_о_товарах]  WITH CHECK ADD CONSTRAINT [FK_Данные_о_товарах_цена_для_продажи] CHECK ([цена для продажи] >= 0) 
 
 DECLARE @errorMessage nvarchar(4000), @errorSeverity int
 begin transaction ins_zero
  begin try
        insert into [Данные_о_товарах] values ('Русалка',5,2, 'шт', -1)

		select * from [Данные_о_товарах]
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
        
		insert into [Данные_о_товарах] values ('Шар с "',2,1, 'шт', 25)

		select * from [Данные_о_товарах]
		
		WAITFOR DELAY '00:00:10'

		select * from [Данные_о_товарах]
	commit transaction ins_up_del
   end try
   begin catch 
     if @@TRANCOUNT > 0 rollback  transaction ins_up_del
	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
     raiserror (@errorMessage, @errorSeverity, 1)
   end catch

select * from [Данные_о_товарах]

SHUTDOWN WITH NOWAIT


DBCC USEROPTIONS

--потерянное обновление-- 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

DECLARE @errorMessage nvarchar(4000), @errorSeverity int
--begin transaction ins_up_sl
--	begin try
--	    WAITFOR DELAY '00:00:05'
--	    update [Данные_о_товарах] set [наименование товара] = 'Слоник' 
--		     where [наименование товара] = 'Слон'
--		select * from [Данные_о_товарах] 
--	end try
--    begin catch 
--     if @@TRANCOUNT > 0 rollback  transaction ins_up_sl
--	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
--     raiserror (@errorMessage, @errorSeverity, 1)
--  end catch

-- select * from [Данные_о_товарах]
-- rollback transaction

begin transaction ins_up1
	begin try
	    update [Данные_о_товарах] set [наименование товара] = 'Шар с запиской' 
		     where [наименование товара] = 'Шар с cюрпризом'
		select * from [Данные_о_товарах]
		commit transaction ins_up1
	end try
    begin catch 
     if @@TRANCOUNT > 0 rollback
	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
     raiserror (@errorMessage, @errorSeverity, 1)
  end catch

rollback transaction ins_up1
select * from [Данные_о_товарах]

--«грязное» чтение--
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @errorMessage nvarchar(4000), @errorSeverity int
--begin transaction ins_up_sl
--	begin try
--	    declare @price int

--		select @price = [цена для продажи] from [Данные_о_товарах] where [наименование товара] = 'Слонишка'
        
--		update [Данные_о_товарах] set [цена для продажи] = @price + 50
--		     where [наименование товара] = 'Слонишка'
	    
--		waitfor delay '00:00:10'

--		rollback transaction  ins_up_sl
--		select * from [Данные_о_товарах]
--	end try
--    begin catch 
--     if @@TRANCOUNT > 0 rollback transaction ins_up_sl
--	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
--     raiserror (@errorMessage, @errorSeverity, 1)
--  end catch

begin transaction ins_up1
	begin try

	   declare @price int

		select @price = [цена для продажи] from [Данные_о_товарах] where [наименование товара] = 'Кошка'
		update [Данные_о_товарах] set [цена для продажи] = @price + 50
		     where [наименование товара] = 'Кошка'

		commit transaction ins_up
		select * from [Данные_о_товарах]

	end try
    begin catch 
     if @@TRANCOUNT > 0 rollback
	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
     raiserror (@errorMessage, @errorSeverity, 1)
  end catch

--неповторяющееся чтение--
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

DECLARE @errorMessage nvarchar(4000), @errorSeverity int
--begin transaction up
--	begin try
--	    select * from [Данные_о_товарах]

--		waitfor delay '00:00:10'

--		select * from [Данные_о_товарах]

--	    commit transaction up
--	end try
--    begin catch 
--     if @@TRANCOUNT > 0 rollback transaction up
--	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
--     raiserror (@errorMessage, @errorSeverity, 1)
--  end catch

begin transaction up
	begin try   
		update [Данные_о_товарах] set [код группы товара] = 2 
		     where [наименование товара] = 'Дева'
		commit transaction
	end try
    begin catch 
     if @@TRANCOUNT > 0 rollback
	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
     raiserror (@errorMessage, @errorSeverity, 1)
  end catch


--фантомное чтение--
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

 DECLARE @errorMessage nvarchar(4000), @errorSeverity int
 --begin transaction ins
 -- begin try
	--	select SUM([цена для продажи]) from [Данные_о_товарах] where [код группы товара] = 2

	--	WAITFOR DELAY '00:00:10'

	--	select SUM([цена для продажи]) from [Данные_о_товарах] where [код группы товара] = 2

	--	commit transaction ins
 --  end try
 --  begin catch 
 --    if @@TRANCOUNT > 0 rollback transaction ins
	-- select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
 --    raiserror (@errorMessage, @errorSeverity, 1)
 --  end catch

 begin transaction ins
  begin try
		insert into [Данные_о_товарах] values ('Лунтик', 2, 2, 'шт' ,1200)
		commit transaction
   end try
   begin catch 
     if @@TRANCOUNT > 0 rollback
	 select @errorMessage = ERROR_MESSAGE(), @errorSeverity = ERROR_SEVERITY()
     raiserror (@errorMessage, @errorSeverity, 1)
   end catch

   delete from Данные_о_товарах where [наименование товара] = 'Лунтик'
