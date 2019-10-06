USE HowKteam

GO 
SELECT * FROM GIAOVIEN 

GO
SELECT MAGV,HOTEN INTO [Thông tin giáo viên] FROM GIAOVIEN

GO
SELECT * from [Thông tin giáo viên]

GO
DROP TABLE [Thông tin giáo viên]

GO
GO
SELECT * INTO [Thongtingiaovien] FROM GIAOVIEN

GO
UPDATE GIAOVIEN SET luong = 900 where MAGV ='001'

GO 
DROP TABLE [Thongtingiaovien]
GO
SELECT * FROM [Thongtingiaovien]

GO
CREATE VIEW [Thông tin giáo viên] AS
SELECT * FROM GIAOVIEN

GO
SELECT * FROM [Thông tin giáo viên]


GO
UPDATE GIAOVIEN SET luong = 100 where MAGV ='001'

GO
DROP VIEW [dbo].[Thông tin giáo viên]
