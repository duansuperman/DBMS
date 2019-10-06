--PHẦN 10: Bài tập về cursor
--Câu 58:
GO
DECLARE Indanhsachcauthu_cursor CURSOR FOR SELECT MACT,HOTEN,VITRI FROM dbo.CAUTHU

OPEN Indanhsachcauthu_cursor 
DECLARE @mact INT
DECLARE @hoten NVARCHAR(20) 
DECLARE @vitri NVARCHAR(20)

FETCH NEXT FROM Indanhsachcauthu_cursor INTO @mact,@hoten,@vitri
WHILE(@@FETCH_STATUS =0)
BEGIN
	PRINT CAST(@mact AS NVARCHAR)+' '+ @hoten+ ' ' +@vitri
	FETCH NEXT FROM Indanhsachcauthu_cursor INTO @mact,@hoten,@vitri
END
CLOSE Indanhsachcauthu_cursor
DEALLOCATE Indanhsachcauthu_cursor
--Câu 59:
GO

DECLARE InCLB_cursor CURSOR FOR SELECT c.MACLB,c.TENCLB,s.TENSAN FROM  dbo.CAULACBO c, dbo.SANVD s WHERE c.MASAN=s.MASAN 
OPEN InCLB_cursor
DECLARE @maclb NVARCHAR(20)
DECLARE @tenclb NVARCHAR(20)
DECLARE @tensan NVARCHAR(20)
FETCH NEXT FROM InCLB_cursor INTO @maclb,@tenclb,@tensan
WHILE(@@FETCH_STATUS=0)
BEGIN
	PRINT @maclb+'  '+@tenclb+'  '+@tensan
	FETCH NEXT FROM InCLB_cursor INTO @maclb,@tenclb,@tensan
END
CLOSE InCLB_cursor
DEALLOCATE InCLB_cursor

--Câu 60:
GO
DECLARE IndanhsachCLB_CT_cursor CURSOR FOR SELECT c.TENCLB,COUNT(*) FROM dbo.CAULACBO c, dbo.CAUTHU ct 
WHERE c.MACLB=ct.MACLB AND ct.MAQG!='VN'
GROUP BY c.MACLB,c.TENCLB
DECLARE @tenclb NVARCHAR(20)
DECLARE @count INT
OPEN IndanhsachCLB_CT_cursor
FETCH NEXT FROM IndanhsachCLB_CT_cursor INTO @tenclb,@count
WHILE(@@FETCH_STATUS=0)
BEGIN	
	PRINT @tenclb+' '+CAST(@count AS NVARCHAR)
	FETCH NEXT FROM IndanhsachCLB_CT_cursor INTO @tenclb,@count
END
--Câu 61:
GO
DECLARE InHLV_NN_cursor CURSOR FOR SELECT cl.TENCLB,COUNT(*) FROM dbo.HUANLUYENVIEN h, dbo.HLV_CLB hc , dbo.CAULACBO cl 
									WHERE  hc.MACLB = cl.MACLB AND hc.MAHLV=h.MAHLV AND h.MAQG!='VN'
									GROUP BY cl.MACLB,cl.TENCLB

OPEN InHLV_NN_cursor 
DECLARE @tenclb NVARCHAR(20)
DECLARE @count int
FETCH NEXT FROM InHLV_NN_cursor INTO  @tenclb,@count
WHILE(@@FETCH_STATUS=0)
BEGIN
	PRINT @tenclb +'   '+CAST(@count AS NVARCHAR)
	FETCH NEXT FROM InHLV_NN_cursor INTO @tenclb,@count
END

CLOSE InHLV_NN_cursor
DEALLOCATE InHLV_NN_cursor
GO
SELECT * FROM dbo.HUANLUYENVIEN h WHERE h.MAQG!='VN' 
--Câu 62:
--Phần 11: Bài tập về Function
--Câu 63:
GO
SELECT * FROM dbo.THAMGIA
--a
GO
alter FUNCTION UF_TongSoTrai()
RETURNS TABLE
AS 
RETURN SELECT t.MACT,SUM(t.SOTRAI) AS 'SoTrai' FROM dbo.THAMGIA t 
		GROUP BY t.MACT
GO
SELECT * FROM dbo.UF_TongSoTrai()
--b
alter FUNCTION UF_Vuaphaluoi()
RETURNS TABLE
AS
RETURN SELECT  c.HOTEN,SUM(t.SOTRAI)  AS 'So Trai' FROM  dbo.THAMGIA t, dbo.CAUTHU c 
		WHERE t.MACT=c.MACT
		GROUP BY c.MACT,c.HOTEN
		HAVING sum(t.SOTRAI) = (SELECT TOP(1) SUM(tg.SOTRAI) FROM dbo.THAMGIA tg 
								GROUP BY tg.MACT ORDER BY SUM(TG.SOTRAI)DESC )
GO
SELECT * FROM dbo.UF_Vuaphaluoi()
--Câu 64:
--a
GO
CREATE FUNCTION UF_Tongsotrandau(@mact int)
RETURNS INT
AS
BEGIN
	DECLARE @count INT 
	SELECT @count =COUNT(*) FROM dbo.THAMGIA t WHERE t.MACT=@mact 
	RETURN @count							
END
GO
SELECT dbo.UF_Tongsotrandau(15) AS 'Tong so tran dau'
GO
SELECT * FROM dbo.THAMGIA

--b
GO  UF_ThongtincauthuTrandau
create FUNCTION UF_Thongtincauthu(@mact int)
RETURNS TABLE
AS
RETURN SELECT ct.HOTEN, COUNT(*) AS 'So tran' FROM dbo.THAMGIA t, dbo.CAUTHU ct WHERE  t.MACT = @mact AND ct.MACT=t.MACT
										GROUP BY t.MACT,ct.HOTEN
GO
SELECT * FROM dbo.UF_Thongtincauthu(16) 
GO
DROP FUNCTION UF_ThongtincauthuTrandau
--Câu 65:
--a
GO
CREATE FUNCTION UF_TiSoBanThang(@matd int)
RETURNS TABLE
AS

RETURN 	SELECT t.MACLB1,t.MACLB2, CAST(SUBSTRING(t.KETQUA,1,CHARINDEX('-',t.KETQUA)-1) AS INT ) AS 'CLB1' , CAST(SUBSTRING(t.KETQUA,CHARINDEX('-',t.KETQUA)+1,LEN(t.KETQUA)) AS int ) AS 'CLB2'
	FROM dbo.TRANDAU t WHERE t.MATRAN=@matd

GO
SELECT * FROM dbo.TRANDAU
GO
SELECT * FROM dbo.UF_TiSoBanThang(2)
--b
CREATE FUNCTION UF_TiSoBanThang(@matd int)
RETURNS TABLE
AS

RETURN 	SELECT t.MATRAN, CAST(SUBSTRING(t.KETQUA,1,CHARINDEX('-',t.KETQUA)-1) AS INT ) - CAST(SUBSTRING(t.KETQUA,CHARINDEX('-',t.KETQUA)+1,LEN(t.KETQUA)) AS int ) AS 'Ti so'
	FROM dbo.TRANDAU t WHERE t.MATRAN=@matd

GO

--Câu 66:
--a
GO
alter FUNCTION UF_Danhsachcauthu(@matd int)
RETURNS TABLE 
AS

RETURN SELECT ct.HOTEN FROM dbo.CAUTHU ct 
WHERE ct.MACLB IN (SELECT td.MACLB1  FROM dbo.TRANDAU td WHERE td.MATRAN=@matd ) 
OR ct.MACLB IN (SELECT td.MACLB2  FROM dbo.TRANDAU td WHERE td.MATRAN=@matd )

GO
SELECT * FROM dbo.TRANDAU
GO
SELECT * FROM dbo.CAUTHU
GO
SELECT * FROM UF_Danhsachcauthu(1)
--b
CREATE FUNCTION UF_Danhsachcauthu1(@maclb varchar(10))
RETURNS TABLE 
AS
RETURN SELECT ct.HOTEN  FROM dbo.CAUTHU ct, dbo.CAULACBO cl WHERE cl.MACLB=@maclb AND ct.MACLB=cl.MACLB
GO
SELECT * FROM dbo.UF_Danhsachcauthu1('BBD')