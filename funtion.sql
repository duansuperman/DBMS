
--FUNCTION 
alter function func_TinhTong
(@a int , @b int )
returns int 
as 
begin
	declare @result int = @a + @b
	set @result = @result +1
	return @result
end 
go
print dbo.func_TinhTong(1,2)
