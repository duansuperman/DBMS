--Check in sql
USE HowKteam
GO
CREATE TABLE Test_check(
	id INT PRIMARY KEY,
	luong FLOAT ,

	CONSTRAINT check_luong CHECK(luong >300 AND luong <600 ),
	CONSTRAINT CHECK_id CHECK( id>=4)
	
)
GO 
INSERT dbo.Test_check(id,luong) 
VALUES(4,500)

GO
SELECT * FROM dbo.Test_check

GO
 DROP TABLE dbo.Test_check