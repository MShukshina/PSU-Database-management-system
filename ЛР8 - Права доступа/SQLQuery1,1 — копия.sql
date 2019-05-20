use [opendata-pk]
go


create login [Awesome Login] with password = '456789CVB2$@'
go

create user [Astonishing User] for login [Awesome Login];
go

select 'Изначальный пользователь', suser_name(), user_name()
go

execute as login = 'Awesome Login'
go

select 'Смененный пользователь', suser_name(), user_name()
go

begin try
  select * from [MunicipalUnits]
end try

begin catch
  select '', error_message() as ''
  ;throw
  end catch
  go


   --возвращение в стандартному доступу
  revert
  go

  select '',suser_name(),user_name()
  grant select on [dbo].[MunicipalUnits] ([Name] to [Astonishing User])

  --возвращение в стандартному доступу
  revert
  go

  create table [UserMunicipalUnits](
   [Username] [nvarchar] (50),
   [MunicipalUnitsID0 [int]
    ---
 ) 


  create view [MubicipalUnitsView] as 
     select * from [municipalUnits]there [ID] in (select [UserMunicipalUnits] where [Username] = 'текущий пользователь')
  go

deny select on [MunicipalUnits]

execute

select 'Чтение из представления от', suser_name(), user_name()
select * from [MunicipalUnitsView]
revert
go

drop view[MunicipalUnitsView]
drop table[UserMunicipalUnits]
drop user[Astonishing user]
drop login[Awesome Login]