use [opendata-pk]
go

--begin tran [saction]
-- [transaction name | @transaction name variable
-- [with mark [description]]]

--commit [tran [saction]
--  [transaction_name | @tran_name_variable]]

--rollback [tran [saction]  [transaction_name | @tran_name_variable
--  | savepoint_name | @ savepoint_variable]]

begin transaction

--������� ������� �������
Delete Resources

--commit transaction

select * from Resources

--������� ����������
rollback transaction

--��������� ����������
save tran ins_complete

--�� ����������� ���. select, ����� , �� ��������� ����� ������

 





