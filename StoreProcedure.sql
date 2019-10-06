-- Store procedure là một chương trình hay thủ tục không có giá trị trả về ( khác với function)
-- đặc điểm 
-- Đông ; có thể chỉnh sửa khối lệnh và tái sử dụng nhiều lần
-- Nhanh hơn ; Tự phân tích cú pháp tối ưu
-- Bảo mật : Gioi hạn quyền user
-- Giarm bandwith : Với các gói transaction lớn. thì dung store đảm bảo hơn.

GO
CREATE PROC usp_Test 
@magv CHAR(10), @Luong float
AS
BEGIN 
	SELECT * FROM dbo.GIAOVIEN WHERE MAGV=@magv AND luong>=@luong
END

GO
EXEC dbo.usp_Test @magv=N'002',@luong=2500

GO
DECLARE @t TABLE

 EXEC dbo.usp_Test '001',2500
    


