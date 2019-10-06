﻿--Đánh chỉ số index  cho trường có thể trùng nhau 
GO
CREATE INDEX IndexMaGV ON NGUOITHAN(MAGV)
--Đánh chỉ số index cho trường unique/foreign key
GO
CREATE INDEX InDexMAGV1 ON dbo.GIAOVIEN(MAGV)

-- Đánh trên nhiêu feild
GO
CREATE UNIQUE INDEX IndexMaGV_TEN ON dbo.GIAOVIEN(MAGV,LUONG)

CREATE UNIQUE INDEX IndexMaGV_TEN1 ON dbo.GIAOVIEN(MAGV)

CREATE UNIQUE INDEX IndexMaGV_TEN1 ON dbo.GIAOVIEN(HOTEN)
GO
DROP INDEX IndexMaGV ON dbo.NGUOITHAN
GO
DROP INDEX IndexMaGV_TEN ON dbo.GIAOVIEN
DROP INDEX InDexMAGV1 ON dbo.GIAOVIEN
