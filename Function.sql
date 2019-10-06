--Tạo function không tham số
GO
alter FUNCTION UF_Giaovien()
RETURNS TABLE
AS
RETURN SELECT * FROM dbo.GIAOVIEN
--Sử dụng function không tham số
GO
SELECT * FROM dbo.UF_Giaovien()

--Sử dụng function có tham số
GO
alter FUNCTION UF_Getluong(@magv NVARCHAR(10))
RETURNS FLOAT
AS
BEGIN 
	DECLARE @luong FLOAT	
	--SELECT @luong= LUONG FROM dbo.GIAOVIEN WHERE MAGV=@magv
	RETURN (SELECT  LUONG FROM dbo.GIAOVIEN WHERE MAGV=@magv)
END

--Sử dụng function có tham số
GO
SELECT dbo.UF_Getluong('001') AS luong

--Bài tập xác truyền vào một số xác định tính chẵn lẻ
GO
CREATE FUNCTION UF_Chanle(@so int)
RETURNS NVARCHAR(10)
AS
BEGIN
	IF(@so%2=0)
		RETURN N'Chẵn'
	ELSE RETURN N'Lẻ'
	RETURN ''
END
GO
SELECT dbo.UF_Chanle(0) AS ketqua

--Xác đinh tuổi của giáo viên
alter FUNCTION UF_Gettuoi(@year date)
RETURNS INT
AS
BEGIN
	DECLARE @tuoi INT 
	RETURN   YEAR(GETDATE()) - YEAR(@year)
	
END

GO
SELECT dbo.UF_Gettuoi(ngsinh) AS tuoi, dbo.UF_Chanle(dbo.UF_Gettuoi(ngsinh)) as ketqua FROM dbo.GIAOVIEN
