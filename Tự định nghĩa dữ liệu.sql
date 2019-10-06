--Định nghĩa dữ liệu trong sql 
EXEC sp_addtype 'NNAME', 'nvarchar(5)', 'not null'

--Xóa định nghĩa 
EXEC sp_droptype 'NNAMe'
