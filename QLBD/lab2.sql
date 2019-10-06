
--Phần 6: Bài tập về Rule

--Câu 23:
GO 
CREATE RULE Vitri
AS @vitri IN(N'Thủ Môn', N'Tiền Đạo',N'Tiền Vệ',N'Hậu vệ',N'Trung vệ')

GO
sp_bindrule 'Vitri','CAUTHU.VITRI'

--Câu 24 :
GO
CREATE RULE Vaitro
AS @vaitro IN (N'HLV chính', N'HLV phụ',N'HLV thể lực',N'HLV thủ môn')

GO
sp_bindrule 'Vaitro', 'HLV_CLB.VAITRO'
--Câu 25 :
GO
CREATE RULE Namsinh
AS YEAR(GETDATE()) - YEAR(@nam)>=18

GO
sp_bindrule 'Namsinh', 'CAUTHU.NGAYSINH'

GO
INSERT dbo.CAUTHU(HOTEN,NGAYSINH,SO,VITRI,MACLB,MAQG) VALUES(N'Nguyễn Tấn Anh','05-07-1995',99,N'Tiền vệ','BBD','ANH')

GO
SELECT * FROM dbo.CAUTHU

--Câu 26:
GO
CREATE RULE Traibong
AS @trai >0 
GO
sp_bindrule 'Traibong','THAMGIA.SOTRAI'


--Phần 7: Bài tập về View

--Câu 27:
GO
	CREATE VIEW Cauthu_view
	AS SELECT MACT,HOTEN,NGAYSINH, DIACHI,VITRI FROM cauthu WHERE MACLB='SDN'AND MAQG='BRA' 
GO
SELECT * FROM Cauthu_view

--Câu 28:
GO
	CREATE VIEW Tran_view
	AS SELECT td.MATRAN, s.TENSAN , c1.TENCLB CLB1,c2.TENCLB CLB2,td.KETQUA FROM dbo.TRANDAU td, dbo.CAULACBO c1, dbo.CAULACBO c2, dbo.SANVD s
	WHERE td.MACLB1= c1.MACLB AND td.MACLB2=c2.MACLB AND td.VONG=3 AND td.NAM=2009 AND td.MASAN=s.MASAN
GO
	SELECT* FROM Tran_view
GO 
DROP VIEW dbo.Tran_view

--Câu 29:
GO

CREATE VIEW HLV_view
AS SELECT h.MAHLV,h.TENHLV,h.NGAYSINH, h.DIACHI, hc.VAITRO,c.TENCLB  FROM dbo.HUANLUYENVIEN h, dbo.HLV_CLB hc, dbo.CAULACBO c
WHERE h.MAHLV=hc.MAHLV AND h.MAQG='VN' AND hc.MACLB=c.MACLB

GO
SELECT * FROM HLV_view


--Câu 30:
GO
CREATE VIEW Caulacbo_view
as
	SELECT c.MACLB,c.TENCLB,s.TENSAN,s.DIACHI,COUNT(ct.MACT) Soluong FROM dbo.CAULACBO c, dbo.CAUTHU ct,dbo.SANVD s
	WHERE c.MACLB=ct.MACLB AND c.MASAN=s.MASAN AND ct.MAQG!='VN'
	GROUP BY c.MACLB,c.TENCLB,s.TENSAN,s.DIACHI
	HAVING COUNT(ct.MACT)>=2
GO
	SELECT * FROM dbo.Caulacbo_view
--Câu 31:
GO
CREATE VIEW Tinh_view
AS SELECT t.TENTINH, COUNT(ct.MACT) Soluong FROM dbo.CAULACBO c, dbo.TINH t, dbo.CAUTHU ct
	WHERE c.MATINH=t.MATINH AND ct.MACLB=c.MACLB AND ct.VITRI=N'Tiền đạo'
	GROUP BY t.TENTINH
 GO
	SELECT * FROM Tinh_view
--Câu 32:
GO
	CREATE VIEW CLB_tinh_view
	AS SELECT c.TENCLB,t.TENTINH FROM dbo.CAULACBO c,dbo.TINH t, dbo.BANGXH b
	WHERE c.MATINH=t.MATINH AND b.MACLB=c.MACLB AND b.VONG=3 AND b.NAM=2009 AND b.HANG=1
GO
	SELECT * FROM dbo.CLB_tinh_view
--Câu 33:
GO
	CREATE VIEW HLV_NoSDT
	AS SELECT h.TENHLV FROM dbo.HUANLUYENVIEN h, dbo.HLV_CLB hc
	WHERE h.MAHLV=hc.MAHLV AND h.DIENTHOAI IS NULL
GO
SELECT * FROM dbo.HLV_NoSDT

--Phần 8: Bài tập về Store Procedure

--Câu 35:
GO
	alter PROC usp_Ten
		@ten NVARCHAR(20)
	AS 
	BEGIN 
		PRINT 'Xin chào '+@ten
	END
GO
DECLARE @ten NVARCHAR(10) = N'Duẩn'
EXEC dbo.usp_Ten @ten
PRINT @ten

--Câu 36: 
GO
	 alter PROC usp_Tong
		@s1 INT ,
		@s2 INT 
	 AS
     BEGIN
		PRINT 'Tong @tg = '+CAST(@s1 + @s2 AS NVARCHAR)
	 END 
GO
DECLARE @s1 INT = 1
DECLARE @s2 INT = 2
EXEC dbo.usp_Tong @s1 ,@s2

--Câu 37:
GO
	alter PROC usp_TongXuat
		@s1 INT ,
		@s2 INT ,
		@tong int out
	AS
    BEGIN 
		SET @tong = @s1+@s2;
	
	END 

GO
DECLARE @s1 int = 1
DECLARE @s2 INT = 2
DECLARE @tong INT 
EXEC dbo.usp_TongXuat @s1, @s2,@tong out

PRINT @tong
--Câu 38:
GO
	alter PROC usp_Max
	 @s1 INT , @s2 INT 
	AS
    BEGIN
		DECLARE @max INT

		IF(@s1>@s2)
		BEGIN 
			SET @max = @s1
		END
        ELSE SET @max = @s2;
        

		PRINT N'Gía trị lớn nhất của @s1 và @s2 Max '+CAST(@max AS char)
	END 
GO
DECLARE @s1 INT =1
DECLARE @s2 INT =2 
EXEC dbo.usp_Max @s1, @s2

--Câu 39:
GO
	CREATE PROC usp_Maxout
		@s1 INT , @s2 INT ,@max INT out
	AS
    BEGIN
		IF(@s1<@s2)
		BEGIN
			SET @max = @s2
        END
        ELSE SET @max = @s1
	END
GO
DECLARE @s1 INT =1
DECLARE @s2 INT = 2
DECLARE @max int
EXEC dbo.usp_Maxout @s1,@s2,@max OUT
PRINT @max

--Câu 40:
GO
	alter PROC usp_Tong_n
		@n INT 
	AS
    BEGIN
		DECLARE @tong INT =0
		DECLARE @i INT  =1; 
		WHILE(@i<=@n)
		BEGIN
			SET @tong +=@i
			SET @i +=1;
        end
		PRINT @tong
	END
GO
DECLARE @n INT =10
EXEC dbo.usp_Tong_n @n

--Câu 41:
GO
CREATE PROC usp_Tong_n_chan
	@n INT 
as
BEGIN 
	DECLARE @i INT =1
	DECLARE @tong INT =0
	DECLARE @dem int = 0;
	WHILE(@i<= @n)
	BEGIN
		SET @tong +=@i
		IF(@i%2=0)
		BEGIN 
			SET @dem+=1
		end
		SET @i+=1
    END
    PRINT @tong
	PRINT @dem
end

GO
DECLARE @n INT =10
EXEC dbo.usp_Tong_n_chan @n

GO
PRINT SUBSTRING('abc',1,2)

--Câu 42:
GO
	alter PROC usp_Trandau_hoa
	AS
	BEGIN
		SELECT COUNT(*) FROM dbo.TRANDAU t 
		WHERE CAST(SUBSTRING(t.KETQUA,1,CHARINDEX('-',t.KETQUA)-1) AS int)= CAST(SUBSTRING(t.KETQUA,CHARINDEX('-',t.KETQUA)+1,LEN(t.KETQUA)) AS INT)
		AND t.vong=3 AND t.nam=2009
	END
GO
	EXEC usp_Trandau_hoa
--Câu 43:
GO
	--Dựa vào truy vấn phần view để in kết quả
--Câu 44:
GO
	CREATE PROC usp_InsertSan
		@masan VARCHAR(5),@ten NVARCHAR(100),@diachi NVARCHAR(100)
	AS
    BEGIN
		INSERT dbo.SANVD VALUES(@masan,@ten,@diachi)  
	END
--Câu 45:
GO
	alter PROC usp_Cauthu
		@mact int
	AS
    BEGIN
		SELECT DISTINCT t.MATRAN,t.NGAYTD FROM dbo.CAULACBO c1,dbo.CAULACBO c2, dbo.TRANDAU t, dbo.CAUTHU ct
		WHERE ct.MACT =@mact AND ((ct.MACLB = t.MACLB1) OR(ct.MACLB=t.MACLB2))
	END
GO
EXEC dbo.usp_Cauthu 1 -- int

--Câu 46:
GO
	CREATE PROC usp_Thamgia
		@matd int
	AS 
	BEGIN
		SELECT c.HOTEN FROM  dbo.CAUTHU c, dbo.THAMGIA t
		WHERE t.MATD = @matd AND t.MACT = c.MACT
	END
GO
	EXEC dbo.usp_Thamgia @matd = 1-- int
--Câu 47:
GO
CREATE PROC usp_Trandau_hoanhau
AS
BEGIN
	SELECT COUNT(*) FROM dbo.TRANDAU t 
	WHERE cast(SUBSTRING(t.KETQUA,1,CHARINDEX('-',t.KETQUA)-1) AS int) = CAST(SUBSTRING(t.KETQUA,CHARINDEX('-',t.KETQUA)+1,LEN(t.KETQUA)) AS int)
END

GO
EXEC dbo.usp_Trandau_hoanhau
--Câu 48:
GO
alter TRIGGER UTG_Insertcauthu ON dbo.CAUTHU FOR INSERT
AS
BEGIN
	DECLARE @count INT 
	SELECT @count = COUNT(*) FROM inserted WHERE VITRI IN (N'Thủ môn',N'Tiền đạo',N'Tiền vệ',N'Hậu vệ',N'Trung vệ')
	PRINT @count
	IF(@count >0)
		PRINT'insert success'
	ELSE ROLLBACK tran
END

GO
SELECT * FROM dbo.CAUTHU
GO

INSERT dbo.CAUTHU
        ( HOTEN ,
          VITRI ,
          NGAYSINH ,
          DIACHI ,
          MACLB ,
          MAQG ,
          SO
        )
VALUES  ( N'fđj' , -- HOTEN - nvarchar(100)
          N'Hậu vệ' , -- VITRI - nvarchar(50)
          GETDATE() , -- NGAYSINH - datetime
          N'rghggjj' , -- DIACHI - nvarchar(200)
          'BBD' , -- MACLB - varchar(5)
          'VN' , -- MAQG - varchar(5)
          17  -- SO - int
        )


--Câu 49:
GO
alter TRIGGER  UTG_Kiemtrasoao ON CAUTHU FOR INSERT
AS
BEGIN
	DECLARE @count INT
	SELECT @count = COUNT(*) FROM inserted i , dbo.CAUTHU c 
	WHERE i.MACLB =c.MACLB AND i.SO = c.SO 
	IF(@count>=2)
		ROLLBACK TRAN
	ELSE PRINT'insert success'
end
GO
DELETE FROM dbo.CAUTHU WHERE MACT =48
GO
sp_unbindrule 'CAUTHU.NGAYSINH'
--Câu 50 :
GO
CREATE TRIGGER UTG_Insertcauthu ON CAUTHU FOR INSERT
AS
BEGIN
	
	PRINT N'Đã thêm cầu thủ mới'
END
--Câu 51:
GO
CREATE TRIGGER UTG_Insertcauthu ON dbo.CAUTHU FOR INSERT
AS
BEGIN
	DECLARE @count INT 
	SELECT  @count = COUNT(*) FROM dbo.CAUTHU c, Inserted i
	WHERE c.MAQG !='VN' AND i.MACLB = c.MACLB
	IF(@count >8)
		ROLLBACK TRAN
	ELSE PRINT 'Insert success'
END
--Câu 52:
GO

CREATE TRIGGER UTG_Insertquocgia ON dbo.QUOCGIA FOR INSERT
AS
BEGIN
	DECLARE @count int
	SELECT @count =  COUNT(*) FROM dbo.QUOCGIA q, inserted i WHERE i.TENQG = q.TENQG
	IF(@count>1)
		ROLLBACK TRAN
	ELSE PRINT N'Insert success'
END

--Câu 53:
GO
CREATE TRIGGER  UTG_Insertthemtinh ON dbo.TINH  FOR INSERT
AS
BEGIN 
	DECLARE @count int
	SELECT @count = COUNT(*) FROM dbo.TINH t, inserted i
	WHERE i.TENTINH = t.TENTINH
	IF(@count>1)
		ROLLBACK TRAN
	ELSE PRINT'Insert success'
END	
--Câu 54:
GO
CREATE TRIGGER UTG_Updatetrandau ON dbo.TRANDAU FOR UPDATE
AS
BEGIN
	IF(UPDATE(KETQUA))
		ROLLBACK
	
END
GO
UPDATE dbo.TRANDAU SET KETQUA ='0-0'
--Câu 55:
--a
GO
CREATE TRIGGER UTG_InsertHLV_CLB ON dbo.HLV_CLB FOR INSERT
AS
BEGIN
	DECLARE @count int
	SELECT @count = COUNT(*) FROM inserted WHERE Inserted.VAITRO IN (N'HLV chính',N'HLV phụ',N'HLV thể lực',N'HLV thủ môn')
	IF(@count >0)
		PRINT 'Insert success'
	ELSE ROLLBACK TRAN
END
--b :
GO
CREATE TRIGGER UTG_InsertHLV_CLB ON HLV_CLB FOR INSERT
AS
BEGIN
	DECLARE @count int
	SELECT @count = COUNT(*) FROM dbo.HLV_CLB h, Inserted  i WHERE i.MACLB = h.MACLB  AND h.VAITRO = N'HLV chính' 
	IF(@count>2)
		ROLLBACK TRAN
	ELSE PRINT 'Insert success'
END

--Câu 56 :
--a
GO
CREATE TRIGGER UTG_InsertCLB ON dbo.CAULACBO FOR INSER
AS
BEGIN
	DECLARE @count int
	SELECT @count = COUNT(*) FROM inserted i, CAULACBO c  WHERE i.TENCLB = c.TENCLB
	PRINT @count
	IF(@count>1)
		PRINT N'having exist a name CLB'
    ELSE PRINT'Insert success'
END

--b
GO
CREATE TRIGGER UTG_InsertCLB ON dbo.CAULACBO FOR INSER
AS
BEGIN
	DECLARE @count int
	SELECT @count = COUNT(*) FROM inserted i, CAULACBO c  WHERE i.TENCLB = c.TENCLB
	PRINT @count
	IF(@count>1)
		ROLLBACK TRAN
    ELSE PRINT'Insert success'
END
 
--Câu 57 :
--a 
GO
alter TRIGGER UTG_Updatecauthu ON dbo.CAUTHU FOR UPDATE
AS
BEGIN
	SELECT COUNT(*) FROM Deleted
	ROLLBACK tran
END
GO
UPDATE dbo.CAUTHU SET HOTEN = N'Nguyễn Tấn Duẩn' WHERE MACT>=34
GO
UPDATE dbo.CAUTHU SET HOTEN =N'abc' WHERE MACT=34
--b 
GO
CREATE TRIGGER UTG_Updatecauthu ON dbo.CAUTHU FOR UPDATE
AS
BEGIN
	SELECT MACT,HOTEN  FROM inserted
	
END
--c
GO
CREATE TRIGGER UTG_Updatecauthu ON dbo.CAUTHU FOR UPDATE
AS
BEGIN
	SELECT c.MACT,c.HOTEN  FROM CAUTHU c, Inserted i WHERE i.MACT = c.MACT
	
END 

-- d
GO
CREATE TRIGGER UTG_Updatecauthu ON dbo.CAUTHU FOR UPDATE
AS
BEGIN
	SELECT c.MACT,c.HOTEN,i.HOTEN  FROM CAUTHU c, Inserted i WHERE i.MACT = c.MACT
	
END 
--e
GO
CREATE TRIGGER UTG_Updatecauthu ON dbo.CAUTHU FOR UPDATE
AS
BEGIN
	SELECT N'Vừa in mã câu thủ '+ CAST(MACT AS NVARCHAR) FROM Inserted
	
END 



GO
IF((SELECT MACLB FROM dbo.CAULACBO ) = (SELECT MACLB FROM dbo.CAULACBO ))
	PRINT '1'

GO
UPDATE dbo.CAUTHU SET DIACHI='kmn'  