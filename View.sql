USE HowKteam
GO

SELECT * FROM dbo.GIAOVIEN

-- Tạo ra một bảng lưu thông tin Giáo viên, tên bộ môn và lương của giáo viên đó
SELECT HOTEN, TENBM, LUONG INTO LuongGiaoVien FROM dbo.GIAOVIEN, dbo.BOMON
WHERE BOMON.MABM = GIAOVIEN.MABM

SELECT * FROM luonggiaovien

UPDATE dbo.GIAOVIEN SET LUONG = 90000
WHERE MAGV = '006'

SELECT * FROM dbo.GIAOVIEN

-- View là bảng ảo
-- Cập nhật dữ liệu theo bảng mà view truy vấn tới mỗi khi lấy view ra sài

-- Tạo ra view TestView từ câu truy vấn
CREATE VIEW TestView as
SELECT * FROM dbo.GIAOVIEN

SELECT * FROM testview

UPDATE dbo.GIAOVIEN SET LUONG = 90
WHERE MAGV = '006'

SELECT * FROM TestView

-- xóa view
DROP VIEW TestView

-- update view
Alter VIEW TestView as
SELECT HOTEN FROM dbo.GIAOVIEN

-- tạo view có dấu
CREATE VIEW [Giáo dục miễn phí] AS
SELECT * FROM dbo.KHOA

SELECT * FROM [Giáo dục miễn phí]