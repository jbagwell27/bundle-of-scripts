USE master;  
GO  
CREATE DATABASE DEXIS   
    ON (FILENAME = '$(PATH)\DEXIS.mdf'),  
    (FILENAME = '$(PATH)\DEXIS_Log.ldf')  
    FOR ATTACH;  
GO  