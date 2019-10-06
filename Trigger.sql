--Trigger sẽ được gọi khi có thay đổi thông tin dữ liệu
--Có 2 bảng chủ yếu 
--Inserted chứa những trường đã insert or update 
--Deleted chứa những trường đa delete

GO
SELECT * FROM dbo.GIAOVIEN

--Tạo trigger bắt sự kiện không cho insert 
alter TRIGGER UTG_Insertgiaovien ON dbo.GIAOVIEN FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @count INT
	SELECT @count = COUNT(*) FROM inserted
	IF(@count>=1)
		ROLLBACK TRAN 
	ELSE PRINT 'insert success'
	
END

GO
INSERT dbo.GIAOVIEN
	        ( MAGV ,
	          HOTEN ,
	          LUONG ,
	          PHAI ,
	          NGSINH ,
	          DIACHI ,
	          GVQLCM ,
	          MABM
	        )
	VALUES  ( N'013' , -- MAGV - nchar(3)
	          N'njfgjkgk' , -- HOTEN - nvarchar(50)
	          3500 , -- LUONG - float
	          N'Nam' , -- PHAI - nchar(3)
	          GETDATE() , -- NGSINH - date
	          N'jfhfk' , -- DIACHI - nchar(50)
	          null , -- GVQLCM - nchar(3)
	          N'MMT'  -- MABM - nchar(4)
	        )
GO

--Tạo trigger không cho insert các giáo viên nhỏ hơn 30 tuổi
alter TRIGGER UTG_Insertgiaoviennhohon30 ON GIAOVIEN FOR INSERT
AS
BEGIN
	DECLARE @count INT
	SELECT @count = COUNT(*) FROM inserted WHERE (YEAR(GETDATE()) - year(ngsinh)) <=30
	PRINT @count
	IF(@count>0)
		ROLLBACK TRAN
	ELSE PRINT 'insert success'
END

GO
drop TRIGGER UTG_Insertgiaovien
INSERT dbo.GIAOVIEN
	        ( MAGV ,
	          HOTEN ,
	          LUONG ,
	          PHAI ,
	          NGSINH ,
	          DIACHI ,
	          GVQLCM ,
	          MABM
	        )
	VALUES  ( N'016' , -- MAGV - nchar(3)
	          N'kmjfkfgh' , -- HOTEN - nvarchar(50)
	          3500 , -- LUONG - float
	          N'Nam' , -- PHAI - nchar(3)
	          '19980705' , -- NGSINH - date
	          N'jfhfk' , -- DIACHI - nchar(50)
	          null , -- GVQLCM - nchar(3)
	          N'MMT'  -- MABM - nchar(4)
	        )

go

--Bắt sự kiện delete không cho xóa các recore có tuổi lớn hơn 1
CREATE TRIGGER UTG_Deletegiaovien ON GIAOVIEN FOR DELETE 
AS 
BEGIN
	DECLARE @count INT 
	SELECT @count = COUNT(*) FROM deleted WHERE year(GETDATE()) - year(ngsinh) >=1
	IF(@count>0)
		ROLLBACK TRAN
	ELSE PRINT 'Delete success'
 END
 
 GO
 DELETE dbo.GIAOVIEN WHERE MAGV ='0112'

 GO
 DECLARE @i INT = 2
 WHILE(@i<=6)
 BEGIN 
	DELETE FROM dbo.GIAOVIEN WHERE MAGV = '01'+cast(@i AS CHAR)
	SET @i+=1
 END
 
 GO
 DROP TRIGGER dbo.UTG_Deletegiaovien 

 --Luyện tập
 --Câu 1: Insert một giáo viên với điều kiện không được trùng tên với giáo viên hiện có
 GO
alter TRIGGER UTG_Insertgiaovien ON dbo.GIAOVIEN for INSERT
 AS
 BEGIN
	
	DECLARE @count INT
	SELECT @count = COUNT(*) FROM GIAOVIEN  g, Inserted i WHERE i.NGSINH = g.NGSINH
	--PRINT @count
	 IF(@count=1)
	begin	PRINT '1'
		ROLLBACK TRAN
	end
	 ELSE IF(@count=2)
	 begin
		PRINT'2'
		ROLLBACK TRAN
	end
	 ELSE
		PRINT 'ok'
	
 END
 
 GO
 SELECT * FROM dbo.GIAOVIEN
 GO
 SELECT COUNT(*) FROM dbo.GIAOVIEN 
 GO
 
 INSERT dbo.GIAOVIEN 
         ( MAGV ,
           HOTEN ,
           LUONG ,
           PHAI ,
           NGSINH ,
           DIACHI ,
           GVQLCM ,
           MABM
         )
 VALUES  ( N'012' , -- MAGV - nchar(3)
           N'Nguyen Van B' , -- HOTEN - nvarchar(50)
           0.0 , -- LUONG - float
           N'Nữ ' , -- PHAI - nchar(3)
           '1980-12-12' , -- NGSINH - date
           N'khong co' , -- DIACHI - nchar(50)
           N'007' , -- GVQLCM - nchar(3)
           N'HPT '  -- MABM - nchar(4)
         )
GO
--DROP TRIGGER UTG_Insertgiaovien
--DROP TRIGGER dbo.UTG_Insertgiaoviennhohon30
--DROP TRIGGER dbo.UTG_Deletegiaovien
DROP TRIGGER UTG_Insertgiaovien
--Câu 2:
alter TRIGGER UTG_Insertgiaovien ON dbo.GIAOVIEN for INSERT
 AS
 BEGIN
	DECLARE @i int
	SELECT @i=COUNT(*) from inserted
	PRINT @i
	DECLARE @count INT
	SELECT @count = COUNT(*) FROM GIAOVIEN
	--PRINT @count
	 IF(@count=17)
	begin	PRINT '17'
		ROLLBACK TRAN
	end
	 ELSE IF(@count=2)
	 begin
		PRINT'2'
		ROLLBACK TRAN
	end
	 ELSE
		PRINT 'ok'
	
 END
 
 GO
 INSERT dbo.GIAOVIEN 
         ( MAGV ,
           HOTEN ,
           LUONG ,
           PHAI ,
           NGSINH ,
           DIACHI ,
           GVQLCM ,
           MABM
         )
 VALUES  ( N'017' , -- MAGV - nchar(3)
           N'Nguyen Van E1' , -- HOTEN - nvarchar(50)
           0.0 , -- LUONG - float
           N'Nữ ' , -- PHAI - nchar(3)
           '1980-12-12' , -- NGSINH - date
           N'khong co' , -- DIACHI - nchar(50)
           N'007' , -- GVQLCM - nchar(3)
           N'HPT '  -- MABM - nchar(4)
         )
--Câu 3:Update 
GO

alter TRIGGER UTG_UpdateGiaovien ON GIAOVIEN FOR UPDATE
AS
BEGIN
	DECLARE @count INT 
	SELECT * FROM Inserted
	SELECT @count=COUNT(*) FROM Inserted WHERE Inserted.LUONG>=1500
	PRINT @count
	IF(@count=0)
		ROLLBACK TRAN
END
GO
UPDATE dbo.GIAOVIEN SET luong = 1200
GO
SELECT COUNT(*) FROM dbo.GIAOVIEN WHERE LUONG=0
GO
SELECT * FROM dbo.GIAOVIEN
