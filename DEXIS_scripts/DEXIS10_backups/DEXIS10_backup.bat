@ECHO Off 

REM Author: Joshua Bagwell
REM Version 2.0b
REM Purpose: This program makes a full backup of the DEXIS 10 data folder to a destination of your choice.

ECHO This will Backup your DEXIS to another folder.
ECHO

REM Get Server data path from registry
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKLM\SOFTWARE\WOW6432Node\DEXIS" /v "DataDirectoryPath"') DO set "workDir=%%B"
echo Working Directory = "%workDir%"

REM Get the path to save the backup from the user
set /p savePath= Where would you like to save the Backup? 

REM detach the DEXIS mdf
SQLCMD -S localhost\DEXIS_DATA -i detach.sql

REM stop sql services
net stop MSSQL$DEXIS_DATA
net stop SQLBrowser

REM perform copy of the server folder to the designated save path
robocopy "%workDir%" "%savepath%" /E

REM restart the services
net start MSSQL$DEXIS_DATA
net start SQLBrowser

REM reattach the MDF files
SQLCMD -S localhost\DEXIS_DATA -i attach.sql -v PATH="%workDir%"

pause