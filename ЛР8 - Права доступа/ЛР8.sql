use [gift_shop]
go

--������ ����� � ������ ��� ������������ - "��������"--
create login [seller] with password = 'G-F_seller_1'
go

--������ ����� � ������ ��� ������������ - "���������"--
create login [merchant] with password = 'G-F_merchant_1'
go

--������ ����� � ������ ��� ������������ - "�������������"--
create login [administrator] with password = 'G-F_administrator_1'
go

--������� ������������ - "��������"--
create user [Seller] for login [seller];
go

--������� ������������ - "���������"--
create user [Merchant] for login [merchant];
go

--������� ������������ - "�������������"--
create user [Administrator] for login [administrator];
go

select '����������� ������������', suser_name(), user_name()
go

--�������� � ������� ������������ - "���������"--
execute as login = 'Merchant'
go

--�������� � ������� ������������ - "�������������"--
execute as login = 'Administrator'
go

--�������� � ������� ������������ - "��������"--
execute as login = 'Seller'
go

select '��������� ������������', suser_name(), user_name()
go

begin try
  select * from [������_�_�������]
end try
begin catch
  select '� ��� ������������ ���� �������!', error_message();throw
  end catch
  go

--����������� � ������������ �������--
revert
go

--�������� �������������, ������� ���������� ������ � �������--
create view product as 
    select [������������ ������], [�������� ������ ������], [�������� ������-�������������],[������� ���������], [���� ��� �������]
	from ������_�_�������, [������_�_�������-��������������], ������_�_�������_�������
	where ������_�_�������.[��� ������ ������] = ������_�_�������_�������.[��� ������ ������] AND 
	      ������_�_�������.[��� ������-�������������] = [������_�_�������-��������������].[��� ������-�������������]
go

--�������� �������������, ������� ���������� ������ � �����������
create view provider as 
    select [�������� ����������], [����� ����������], [�������� �����],[����.����]
	from ������_�_�����������, [������_�_������]
	where ������_�_�����������.[��� �����] = ������_�_������.[��� �����] 
go

--�������� �������������, ������� ���������� ������ � ����������
create view worker as 
    select [�������], [���], [��������],[���� ��������], [���������], [�������� �����], [����� �����], �������
	from ������_�_����������, [������_�_������], ������_�_����������
	where ������_�_����������.[��� �����] = ������_�_������.[��� �����] AND  ������_�_����������.[��� ���������] = ������_�_����������.[��� ���������]
go

--�������� �������������, ������� ���������� ������ � ��������
create view sale as 
    select ([�������] + ' ' + [���] + ' ' + [��������]) as ���, [���� �������], [������������ ������], [���������� ���������� ������], [������_�_����].[���� ��� �������]
	from ������_�_������� inner join ������_�_���� on ������_�_����.[��� ������] = ������_�_�������.[��� ������] 
	     inner join ������_�_�������� on ������_�_��������.[����� ����] = ������_�_����.[����� ����]
		 inner join  ������_�_���������� on  ������_�_����������.[��� ���������] = ������_�_��������.[��� ��������]	  
go

--��������� ����� ������� ��� ������������ "���������"--
grant select, update, delete, insert on [dbo].[product] to [Merchant]
  grant select, update, delete, insert on [dbo].[supply] to [Merchant]
  grant select, update, delete, insert on [dbo].[sale] to [Merchant]
  grant select, update, delete, insert on [dbo].[provider] to [Merchant]
  go

--��������� ����� ������� ��� ������������ "��������"--
grant select on [dbo].[product] to [Seller]
  grant select on [dbo].[������_�_�������_�������] to [Seller]
  grant select on [dbo].[������_�_�������-��������������] to [Seller]
  grant select, update, delete, insert on [dbo].[sale] to [Seller]
  go

--��������� ����� ������� ��� ������������ "�������������"--
grant select, update, delete, insert on [dbo].[worker] to [Administrator]
  grant select, update, delete, insert on [dbo].[������_�_����������] to [Administrator]
  grant select, update, delete, insert on [dbo].[������_�_������] to [Administrator]
go

select * from ������_�_�������
select * from product
select * from worker

insert into [dbo].[product] ([�������� ������ ������])values ('��������')

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