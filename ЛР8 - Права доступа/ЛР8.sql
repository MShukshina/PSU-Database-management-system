use [gift_shop]
go

--задаем логин и пароль для пользователя - "Продавец"--
create login [seller] with password = 'G-F_seller_1'
go

--задаем логин и пароль для пользователя - "Товаровед"--
create login [merchant] with password = 'G-F_merchant_1'
go

--задаем логин и пароль для пользователя - "Администратор"--
create login [administrator] with password = 'G-F_administrator_1'
go

--создаем пользователя - "Продавец"--
create user [Seller] for login [seller];
go

--создаем пользователя - "Товаровед"--
create user [Merchant] for login [merchant];
go

--создаем пользователя - "Администратор"--
create user [Administrator] for login [administrator];
go

select 'Изначальный пользователь', suser_name(), user_name()
go

--перейдем к доступу пользователя - "Товаровед"--
execute as login = 'Merchant'
go

--перейдем к доступу пользователя - "Администратор"--
execute as login = 'Administrator'
go

--перейдем к доступу пользователя - "Продавец"--
execute as login = 'Seller'
go

select 'Смененный пользователь', suser_name(), user_name()
go

begin try
  select * from [Данные_о_товарах]
end try
begin catch
  select 'У вас недостаточно прав доступа!', error_message();throw
  end catch
  go

--возвращение в стандартному доступу--
revert
go

--создадим представление, которое отображает данные о товарах--
create view product as 
    select [наименование товара], [название группы товара], [название страны-производителя],[единица измерения], [цена для продажи]
	from Данные_о_товарах, [Данные_о_странах-производителях], Данные_о_группах_товаров
	where Данные_о_товарах.[код группы товара] = Данные_о_группах_товаров.[код группы товара] AND 
	      Данные_о_товарах.[код страны-производителя] = [Данные_о_странах-производителях].[код страны-производителя]
go

--создадим представление, которое отображает данные о поставщиках
create view provider as 
    select [название поставщика], [адрес поставщика], [название банка],[корр.счет]
	from Данные_о_поставщиках, [Данные_о_банках]
	where Данные_о_поставщиках.[код банка] = Данные_о_банках.[код банка] 
go

--создадим представление, которое отображает данные о работниках
create view worker as 
    select [фамилия], [имя], [отчество],[дата рождения], [должность], [название банка], [номер карты], телефон
	from Данные_о_работниках, [Данные_о_банках], Данные_о_должностях
	where Данные_о_работниках.[код банка] = Данные_о_банках.[код банка] AND  Данные_о_работниках.[код должности] = Данные_о_должностях.[код должности]
go

--создадим представление, которое отображает данные о продажах
create view sale as 
    select ([фамилия] + ' ' + [имя] + ' ' + [отчество]) as ФИО, [дата продажи], [наименование товара], [количество проданного товара], [Товары_в_чеке].[цена для продажи]
	from Данные_о_товарах inner join Товары_в_чеке on Товары_в_чеке.[код товара] = Данные_о_товарах.[код товара] 
	     inner join Данные_о_продажах on Данные_о_продажах.[номер чека] = Товары_в_чеке.[номер чека]
		 inner join  Данные_о_работниках on  Данные_о_работниках.[код работника] = Данные_о_продажах.[код рабоника]	  
go

--обозначим права доступа для пользователя "Товаровед"--
grant select, update, delete, insert on [dbo].[product] to [Merchant]
  grant select, update, delete, insert on [dbo].[supply] to [Merchant]
  grant select, update, delete, insert on [dbo].[sale] to [Merchant]
  grant select, update, delete, insert on [dbo].[provider] to [Merchant]
  go

--обозначим права доступа для пользователя "Продавец"--
grant select on [dbo].[product] to [Seller]
  grant select on [dbo].[Данные_о_группах_товаров] to [Seller]
  grant select on [dbo].[Данные_о_странах-производителях] to [Seller]
  grant select, update, delete, insert on [dbo].[sale] to [Seller]
  go

--обозначим права доступа для пользователя "Администратор"--
grant select, update, delete, insert on [dbo].[worker] to [Administrator]
  grant select, update, delete, insert on [dbo].[Данные_о_должностях] to [Administrator]
  grant select, update, delete, insert on [dbo].[Данные_о_банках] to [Administrator]
go

select * from Данные_о_товарах
select * from product
select * from worker

insert into [dbo].[product] ([название группы товара])values ('Герлянда')

drop view [product]
drop view [provider]
drop view [worker]
drop view [sale]
drop user[Seller]
drop login[seller]
drop user[Administrator]
drop login[administrator]
drop user[Merchant]
drop login[merchant]