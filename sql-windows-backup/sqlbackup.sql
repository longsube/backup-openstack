USE portal; 
GO
DECLARE @path VARCHAR(256) -- path for backup files  
DECLARE @fileDate VARCHAR(20) -- used for file name
DECLARE @fileName VARCHAR(256) -- filename for backup 
SET @path = 'D:\SQL_Backup\'  
SELECT @fileDate = CONVERT(VARCHAR(20),GETDATE(),112) + REPLACE(CONVERT(VARCHAR(20),GETDATE(),108),':','')
SET @fileName = @path + 'portal' + '_' + @fileDate + '.BAK'  
BACKUP DATABASE portal
TO DISK = @fileName
GO
