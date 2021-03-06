use [gift_shop]
go

--3 insert (���., �� ���., ���. ���-��) 
--3 update (�� ��, ��� ����, �� ����� �������� ������, ������ ���-�� � ���. ��������)
--delete 


--create view supply as 
--    select [������_�_���������].[��� ��������],[�������� ����������],[���� ��������],[������������ ������],
--	[�������� ������ ������],[�������� ������-�������������],[������� ���������],[���� ��� �������],
--	[���������� ������������� ������] 
--	from [������_�_�������] inner join [������_�_��������] on [������_�_�������].[��� ������] = ������_�_��������.[��� ������] 
--	     inner join [������_�_���������] on [������_�_��������].[��� ��������] = ������_�_���������.[��� ��������] 
--		 inner join [������_�_�����������] on ������_�_���������.[��� ����������] = ������_�_�����������.[��� ����������]
--		 inner join [������_�_�������_�������] on [������_�_�������].[��� ������ ������] = ������_�_�������_�������.[��� ������ ������]
--		 inner join [������_�_�������-��������������] on ������_�_�������.[��� ������-�������������] = [������_�_�������-��������������].[��� ������-�������������]
--go

select*from supply
go


create trigger [dbo].[ins_trig_supply] 
on supply 
instead of insert
as 
begin
  merge 
	into [������_�_�������] as t
	using inserted as ins
	on t.[������������ ������] = ins.[������������ ������] 
	and t.[��� ������ ������] = 
	     (select  [��� ������ ������] from [������_�_�������_�������] 
	        where [�������� ������ ������] = ins.[�������� ������ ������] )
	and t.[��� ������-�������������] = 
	     (select  [��� ������-�������������] from [������_�_�������-��������������] 
	        where [�������� ������-�������������] = ins.[�������� ������-�������������])

	when matched then
      update set t.[���� ��� �������] = ins.[���� ��� �������], t.[������� ���������] = ins.[������� ���������]

	when not matched then 
    insert ([������������ ������],[��� ������ ������],[��� ������-�������������],[������� ���������],[���� ��� �������])
    values (ins.[������������ ������],
	       (select  [��� ������ ������] from [������_�_�������_�������] 
	           where [�������� ������ ������] = ins.[�������� ������ ������]),
		   (select  [��� ������-�������������] from [������_�_�������-��������������] 
	           where [�������� ������-�������������] = ins.[�������� ������-�������������]), 
		    ins.[������� ���������], ins.[���� ��� �������]);

	merge 
	  into [������_�_���������] as p
	  using inserted as ins
	  on p.[��� ��������] = ins.[��� ��������]

	when  matched then
	  update set p.[���� ��������] = ins.[���� ��������], p.[��� ����������] = 
	    (select [��� ����������] from [������_�_�����������] where [�������� ����������] = ins.[�������� ����������])

	  when not matched then 
      insert ([��� ����������],[���� ��������])  
	  values ((select [��� ����������] from [������_�_�����������] 
	             where [�������� ����������] = ins.[�������� ����������]),ins.[���� ��������]);

	  merge 
	  into [������_�_��������] as t
	  using inserted as ins
	  on t.[��� ��������] = ins.[��� ��������] 
	     and t.[��� ������] = (select [��� ������] from [������_�_�������] where [������������ ������] = ins.[������������ ������])

	  when  matched then
	  update set t.[���������� ������������� ������] += ins.[���������� ������������� ������]

	  when not matched then 
      insert ([��� ��������], [��� ������], [���������� ������������� ������])  
	  values (ins.[��� ��������], (select [��� ������] from [������_�_�������]
	                                 where [������������ ������] = ins.[������������ ������]),
			 ins.[���������� ������������� ������]); 
end
go

create trigger [dbo].[del_trig_supply] 
on supply 
instead of delete
as 
begin
  merge 
	[������_�_�������] as t
	using deleted as del
	on t.[������������ ������] = del.[������������ ������] 
	and t.[��� ������ ������] =
	     (select  [��� ������ ������] from [������_�_�������_�������] 
	        where [�������� ������ ������] = del.[�������� ������ ������] )
	and t.[��� ������-�������������] = 
	     (select  [��� ������-�������������] from [������_�_�������-��������������] 
	           where [�������� ������-�������������] = del.[�������� ������-�������������]) 
    and t.[������� ���������] = del.[������� ���������]
	 
	when matched then delete;

	merge 
	  [������_�_���������] as p
	  using deleted as del
	  on p.[��� ��������] = del.[��� ��������] 
	  and p.[��� ����������] = (select [��� ����������] from [������_�_�����������] 
	             where [�������� ����������] = del.[�������� ����������])

	  when matched then delete;

	  merge 
	  [������_�_��������] as t
	  using deleted as del
	  on t.[��� ��������] = del.[��� ��������] 
	  and t.[��� ������] = (select [��� ������] from [������_�_�������]
		                     where [������������ ������] = del.[������������ ������])

	  when  matched then delete;
end
go

alter trigger [dbo].[up_trig_supply] 
on supply 
instead of update
as 
begin
  merge 
	[������_�_�������] as t
	using inserted as sup--(select [������������ ������],[�������� ������ ������],[�������� ������-�������������],[������� ���������],[���� ��� �������] 
	--from inserted as i) as sup
	on t.[������������ ������] = sup.[������������ ������] 
	   AND t.[��� ������ ������] = 
	        (select [��� ������ ������] from [������_�_�������_�������] 
			  where [������_�_�������_�������].[�������� ������ ������] = sup.[�������� ������ ������])
       AND t.[��� ������-�������������] = 
	        (select [��� ������-�������������] from [������_�_�������-��������������] 
              where [������_�_�������-��������������].[�������� ������-�������������] = sup.[�������� ������-�������������])
    
	when matched then 
	 update set t.[������� ���������] = sup.[������� ���������], t.[���� ��� �������] = sup.[���� ��� �������]

	when not matched then
	 insert ([������������ ������],[��� ������ ������],[��� ������-�������������],[������� ���������],[���� ��� �������])
	 values (sup.[������������ ������],
			(select [��� ������ ������] from [������_�_�������_�������] 
			    where [������_�_�������_�������].[�������� ������ ������] = sup.[�������� ������ ������]),
		    (select [��� ������-�������������] from [������_�_�������-��������������] 
			    where [������_�_�������-��������������].[�������� ������-�������������] = sup.[�������� ������-�������������]),
			sup.[������� ���������], sup.[���� ��� �������]);

	merge 
	  [������_�_���������] as p
	  using (select distinct [��� ��������],[�������� ����������],[���� ��������] from [supply]) as sup
	  on p.[��� ��������] = sup.[��� ��������]

	  when matched then
	   update set p.[��� ����������] =
	                            (select [��� ����������] from [������_�_�����������] 
		                           where [�������� ����������] = sup.[�������� ����������]),
		 p.[���� ��������] = sup.[���� ��������]
	  
	  when not matched then 
	    insert ([��� ����������], [���� ��������]) 
		values ((select [��� ����������] from [������_�_�����������]
		            where [�������� ����������] = sup.[�������� ����������]),
		 sup.[���� ��������]);

	  merge 
	  [������_�_��������] as p
	  using (select [��� ��������], [������������ ������], [���������� ������������� ������] from [supply]) as sup
	  on  p.[��� ��������] = sup.[��� ��������] AND p.[��� ������] =
	          (select [��� ������] from [������_�_�������] 
			  where [������������ ������] = sup.[������������ ������])

	  when matched then
	    update set [���������� ������������� ������] = sup.[���������� ������������� ������]
	    
	  when not matched then 
         insert ([��� ��������],[��� ������],[���������� ������������� ������]) 
		 values (sup.[��� ��������],(select [��� ������] from [������_�_�������] 
			                          where [������������ ������] = sup.[������������ ������]),
			     sup.[���������� ������������� ������]);
end
go

insert into [dbo].[supply] ([��� ��������],[�������� ����������],[���� ��������],[������������ ������],[�������� ������ ������],[�������� ������-�������������],[������� ���������],[���� ��� �������],[���������� ������������� ������])
values (8,'������','02-03-2018','����','����������','����������','��',250, 6)

insert into [dbo].[supply] ([��� ��������],[�������� ����������],[���� ��������],[������������ ������],[�������� ������ ������],[�������� ������-�������������],[������� ���������],[���� ��� �������],[���������� ������������� ������])
values (29,'��������� ���','26-03-2018','���-������ �������','����','������','��',36, 50)

insert into [dbo].[supply] ([��� ��������],[�������� ����������],[���� ��������],[������������ ������],[�������� ������ ������],[�������� ������-�������������],[������� ���������],[���� ��� �������],[���������� ������������� ������])
values (29,'��������� ���','26-03-2018','���-������ �������','����','�����','��',960, 50)

delete from supply where  [������������ ������] = '���-������ �������'

update [dbo].[supply] set [���� ��������] = '22-03-2018' where [��� ��������] = 8

update [dbo].[supply] set [������������ ������] = '�����', [�������� ������ ������] = '������ �������', [�������� ������-�������������] = '�����', [������� ���������] = '��', [���� ��� �������] = 125 where [��� ��������] = 8 

update [dbo].[supply] set [���������� ������������� ������] = 5 where [��� ��������] = 8 AND [������������ ������] = '����'



select * from supply
select * from [������_�_�������]
select * from [������_�_���������]
select * from [������_�_��������]


drop [dbo].[ins_trig_supply]
drop [dbo].[del_trig_supply]
drop [dbo].[up_trig_supply]
drop [dbo].[supply]
