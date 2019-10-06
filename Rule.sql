--Định nghĩa lương cho tất cả các table bằng rule

CREATE RULE Luong 
AS @Luongcoban > 300


-- Gán thuộc tính rule vừa tạo cho table 
GO
sp_bindrule 'Luong', 'Test_Rule.luong'

-- Xóa thuộc tính rule vừa gán
sp_unbindrule 'Test_Rule.luong'


CREATE TABLE Test_Rule(
	luong INT 
)

GO
INSERT dbo.Test_Rule VALUES(400)

--Sau khi xóa rule trên column
INSERT dbo.Test_Rule VALUES(200)

GO
SELECT * FROM dbo.Test_Rule
GO
DROP TABLE dbo.Test_Rule