-- khi có nhu cầu duyệt tứng record của bảng, với mỗi record có kết quả xử lý riêng thì dúng cursor
-- Declare <tên con trỏ> cursor for <câu lệnh select>
-- Open <tên con trỏ>

-- Fetch next from <tên con trỏ> into <danh sách các biến tương ứng kêt quả truy vấn>


-- While fetch_status = 0
-- Begin
-- Câu lệnh thực hiện
-- Fetch next lại lần nữa
-- Fetch next from <tên con trỏ> into <danh sách các biến tương ứng kêt quả truy vấn>

-- End

-- Close <tên con trỏ>
-- Deallocate <tên con trỏ>

-----------------------------------------------------------------------------------------

-- Từ tuổi của giáo viên 
-- Nếu lớn hơn 40 thì lương 2500
-- Nếu nhỏ hơn 40 và lớn hơn 30 cho lương 2000
-- Ngược lại lương 1500

--c1 :
SELECT * FROM dbo.GIAOVIEN
GO
UPDATE dbo.GIAOVIEN SET luong = 9999
 WHERE YEAR(GETDATE()) - YEAR(NGSINH)  >= 30

 --c2 : Sử dụng con trỏ 
 DECLARE giaoviencursor CURSOR FOR SELECT MAGV, YEAR(GETDATE()) - YEAR(NGSINH) FROM dbo.GIAOVIEN --Khởi tạo con troe dựa trên câu select

 OPEN giaoviencursor

 DECLARE @magv NVARCHAR(10)
 DECLARE @tuoi INT 

 FETCH NEXT FROM giaoviencursor INTO @magv,@tuoi

 WHILE(@@FETCH_STATUS=0)
 BEGIN
	IF(@tuoi>=40)
	BEGIN
		UPDATE dbo.GIAOVIEN set luong = 3500 WHERE MAGV=@magv
    END
    ELSE IF(@tuoi<40 AND @tuoi>30)
	BEGIN
		UPDATE dbo.GIAOVIEN SET luong = 2000 WHERE MAGV =@magv
    END
    ELSE
    BEGIN
		UPDATE dbo.GIAOVIEN SET luong = 1800 WHERE MAGV =@magv
    END
     FETCH NEXT FROM giaoviencursor INTO @magv,@tuoi
 END

 CLOSE giaoviencursor

 DEALLOCATE giaoviencursor


 --Text
 DECLARE @i INT =5;
 WHILE(@i>=1)
 BEGIN 
 PRINT 1;
 SET @i-=1;
 END
 



 
