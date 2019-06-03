@echo off
title Folder Authentication
color 0b
call :isAdmin
if %errorlevel% == 0 goto run
if %errorlevel% NEQ 0 ( echo Requesting Administrative Privileges...
    title Requesting Administrative Privileges...
	goto :UACPrompt 
)
exit /b

:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "cmd.exe", "/c %~s0 %~1", "", "runas", 1 >> "%temp%\getadmin.vbs"

"%temp%\getadmin.vbs"
del "%temp%\getadmin.vbs"

:isAdmin
fsutil dirty query %systemdrive% >nul
exit /b

:run
@echo off
color 0b
title DELETE THIS SETUP WHEN FINISHED!
cd %systemdrive%%homepath%
if exist "Documents\config" ( del /Q /A:RH "Documents\config" )
if exist "Documents\config2" ( del /Q /A:RH "Documents\config2" )
echo:What do you want your password to be? ~ one word please, or else it doesn't work.
set /p passwd=: 
echo:%passwd% > "Documents\config"
echo:What folder do you want to lock? 
echo:example ~ Documents\Secrets
set /p folder=: 
cd %folder%
for /f %%H in ('cd') do set folder1=%%H
cd %systemdrive%%homepath%
echo:%folder1% > "Documents\config2"
attrib +H +R "Documents\config"
attrib +H +R "Documents\config2"
attrib +H "%folder%"
echo:Alright, Just a second and everything will be good to go!
call :writeout
timeout 2 >nul
"Desktop\FolderAuth.bat" && exit

:writeout
echo:@echo off> Desktop\FolderAuth.bat
echo:title Folder Authentication>> Desktop\FolderAuth.bat
echo:color 0b>> Desktop\FolderAuth.bat
echo:cls>> Desktop\FolderAuth.bat
echo:call :isAdmin>> Desktop\FolderAuth.bat
echo:if %%errorlevel%% == 0 goto run>> Desktop\FolderAuth.bat
echo:if %%errorlevel%% NEQ 0 ( echo Requesting Administrative Privileges...>> Desktop\FolderAuth.bat
echo:    title Requesting Administrative Privileges...>> Desktop\FolderAuth.bat
echo:	goto :UACPrompt )>> Desktop\FolderAuth.bat
echo:>> Desktop\FolderAuth.bat
echo:exit /b>> Desktop\FolderAuth.bat
echo:>> Desktop\FolderAuth.bat
echo::UACPrompt>> Desktop\FolderAuth.bat
echo:echo Set UAC = CreateObject^^("Shell.Application"^^) ^> "%%temp%%\getadmin.vbs">> Desktop\FolderAuth.bat
echo:echo UAC.ShellExecute "cmd.exe", "/c %%~s0 %%~1", "", "runas", 1 ^>^> "%%temp%%\getadmin.vbs">> Desktop\FolderAuth.bat
echo:>> Desktop\FolderAuth.bat
echo:"%%temp%%\getadmin.vbs">> Desktop\FolderAuth.bat
echo:del "%%temp%%\getadmin.vbs">> Desktop\FolderAuth.bat
echo:>> Desktop\FolderAuth.bat
echo :isAdmin>> Desktop\FolderAuth.bat
echo:fsutil dirty query %%systemdrive%% ^>nul>> Desktop\FolderAuth.bat
echo:exit /b>> Desktop\FolderAuth.bat
echo:>> Desktop\FolderAuth.bat
echo :run >> Desktop\FolderAuth.bat
echo:cd %%systemdrive%%%%homepath%%>> Desktop\FolderAuth.bat
echo:for /f %%%%I in ('more %%userprofile%%\Documents\config') do set password="%%%%I">> Desktop\FolderAuth.bat
echo:for /f %%%%G in ('more %%userprofile%%\Documents\config2') do set folder="%%%%G">> Desktop\FolderAuth.bat
echo :top>> Desktop\FolderAuth.bat
echo:echo __________________>> Desktop\FolderAuth.bat
echo:echo.>> Desktop\FolderAuth.bat
echo:echo Folder Password>> Desktop\FolderAuth.bat
echo:echo __________________>> Desktop\FolderAuth.bat
echo:echo.>> Desktop\FolderAuth.bat
echo:echo You have 1 attempt only.>> Desktop\FolderAuth.bat
echo:echo Enter password>> Desktop\FolderAuth.bat
echo:echo ______________________________________________>> Desktop\FolderAuth.bat
echo:set /p pass= : >> Desktop\FolderAuth.bat
echo:if "%%pass%%" == "%%password%%" goto correct>> Desktop\FolderAuth.bat
echo:if "%%pass%%" NEQ "%%password%%" goto fail>> Desktop\FolderAuth.bat
echo:cls>> Desktop\FolderAuth.bat
echo:goto top>> Desktop\FolderAuth.bat
echo :fail>> Desktop\FolderAuth.bat
echo:echo Did you forget your own password? Gosh.>> Desktop\FolderAuth.bat..
echo:echo Press any key to close window...>> Desktop\FolderAuth.bat
echo:pause ^>nul>> Desktop\FolderAuth.bat
echo:exit>> Desktop\FolderAuth.bat
echo :correct>> Desktop\FolderAuth.bat
echo:cls>> Desktop\FolderAuth.bat
echo:echo ______________________________________________>> Desktop\FolderAuth.bat
echo:echo.>> Desktop\FolderAuth.bat
echo:echo Password Accepted!>> Desktop\FolderAuth.bat
echo:echo Opening Folder...>> Desktop\FolderAuth.bat
echo:echo ______________________________________________>> Desktop\FolderAuth.bat
echo:explorer "%%folder%%">> Desktop\FolderAuth.bat
echo:timeout 2 ^>nul>> Desktop\FolderAuth.bat
echo:exit>> Desktop\FolderAuth.bat
exit /b
