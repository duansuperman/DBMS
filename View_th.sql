USE HowKteam

GO 
SELECT * FROM GIAOVIEN 

GO
SELECT MAGV,HOTEN INTO [Th�ng tin gi�o vi�n] FROM GIAOVIEN

GO
SELECT * from [Th�ng tin gi�o vi�n]

GO
DROP TABLE [Th�ng tin gi�o vi�n]

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
CREATE VIEW [Th�ng tin gi�o vi�n] AS
SELECT * FROM GIAOVIEN

GO
SELECT * FROM [Th�ng tin gi�o vi�n]


GO
UPDATE GIAOVIEN SET luong = 100 where MAGV ='001'

GO
DROP VIEW [dbo].[Th�ng tin gi�o vi�n]
