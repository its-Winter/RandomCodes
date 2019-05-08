@echo off
title Folder Authentication
color 0b
call :isAdmin
if %errorlevel% == 0 goto run
if %errorlevel% NEQ 0 ( echo Requesting Administrative Privileges...
    title Requesting Administrative Privileges...
	goto :UACPrompt )

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
del /Q /A:RH "%userprofile%\Documents\config" >nul 2>nul
del /Q /A:RH "%userprofile%\Documents\config2" >nul 2>nul
echo:What do you want your password to be? ~ one word please, or else it doesn't work.
set /p passwd=: 
echo:%passwd% > "%userprofile%\Documents\config"
echo:What folder do you want to lock? 
echo:example ~ Documents\Secrets
set /p folder=: 
echo:%userprofile%\%folder% > "%userprofile%\Documents\config2"
attrib +H +R "%userprofile%\Documents\config"
attrib +H +R "%userprofile%\Documents\config2"
attrib +H %folder%
echo:Alright, Just a second and everything will be good to go!
call :writeout
timeout 8 >nul
start "%userprofile%\Desktop\FolderAuth.bat" && exit

:writeout
echo:@echo off> %userprofile%\Desktop\FolderAuth.bat
echo:title Folder Authentication>> %userprofile%\Desktop\FolderAuth.bat
echo:color 0b>> %userprofile%\Desktop\FolderAuth.bat
echo:call :isAdmin>> %userprofile%\Desktop\FolderAuth.bat
echo:if %errorlevel% == 0 goto run>> %userprofile%\Desktop\FolderAuth.bat
echo:if %errorlevel% NEQ 0 ( echo Requesting Administrative Privileges...>> %userprofile%\Desktop\FolderAuth.bat
echo:    title Requesting Administrative Privileges...>> %userprofile%\Desktop\FolderAuth.bat
echo:	goto :UACPrompt )>> %userprofile%\Desktop\FolderAuth.bat
echo:>> %userprofile%\Desktop\FolderAuth.bat
echo:exit /b>> %userprofile%\Desktop\FolderAuth.bat
echo:>> %userprofile%\Desktop\FolderAuth.bat
echo::UACPrompt>> %userprofile%\Desktop\FolderAuth.bat
echo:echo Set UAC = CreateObject^^("Shell.Application"^^) ^> "%%temp%%\getadmin.vbs">> %userprofile%\Desktop\FolderAuth.bat
echo:echo UAC.ShellExecute "cmd.exe", "/c %%~s0 %%~1", "", "runas", 1 ^>^> "%%temp%%\getadmin.vbs">> %userprofile%\Desktop\FolderAuth.bat
echo:>> %userprofile%\Desktop\FolderAuth.bat
echo:"%%temp%%\getadmin.vbs">> %userprofile%\Desktop\FolderAuth.bat
echo:del "%%temp%%\getadmin.vbs">> %userprofile%\Desktop\FolderAuth.bat
echo:>> %userprofile%\Desktop\FolderAuth.bat
echo :isAdmin>> %userprofile%\Desktop\FolderAuth.bat
echo:fsutil dirty query %systemdrive% ^>nul>> %userprofile%\Desktop\FolderAuth.bat
echo:exit /b>> %userprofile%\Desktop\FolderAuth.bat
echo:>> %userprofile%\Desktop\FolderAuth.bat
echo :run >> %userprofile%\Desktop\FolderAuth.bat
echo:for /f %%%%I in ('more %%userprofile%%\Documents\config') do set password=%%%%I>> %userprofile%\Desktop\FolderAuth.bat
::Change '\Desktop\Coding\config' to the file is in that contains the super secret password. Also make sure the file is set to read only to prevent any accidental changes to the password and set to hidden.
::%userprofile% is C:\Users\<whoever you're logged in as>
::For me %userprofile% = C:\Users\Winter -- if you don't know what your %userprofile% variable is set to then open cmd and type
::echo %userprofile%
::and it will return what it is set to.
echo :top>> %userprofile%\Desktop\FolderAuth.bat
echo:echo __________________>> %userprofile%\Desktop\FolderAuth.bat
echo:echo.>> %userprofile%\Desktop\FolderAuth.bat
echo:echo Folder Password>> %userprofile%\Desktop\FolderAuth.bat
echo:echo __________________>> %userprofile%\Desktop\FolderAuth.bat
echo:echo.>> %userprofile%\Desktop\FolderAuth.bat
echo:echo You have 1 attempt only.>> %userprofile%\Desktop\FolderAuth.bat
echo:echo Enter password>> %userprofile%\Desktop\FolderAuth.bat
echo:echo ______________________________________________>> %userprofile%\Desktop\FolderAuth.bat
echo:set /p pass= : >> %userprofile%\Desktop\FolderAuth.bat
echo:if %%pass%% == %%password%% goto correct>> %userprofile%\Desktop\FolderAuth.bat
echo:if %%pass%% NEQ %%password%% goto fail>> %userprofile%\Desktop\FolderAuth.bat
echo:cls>> %userprofile%\Desktop\FolderAuth.bat
echo:goto top>> %userprofile%\Desktop\FolderAuth.bat
echo :fail>> %userprofile%\Desktop\FolderAuth.bat
echo:echo Did you forget your own password? Gosh.>> %userprofile%\Desktop\FolderAuth.bat..
echo:echo Press any key to close window...>> %userprofile%\Desktop\FolderAuth.bat
echo:pause ^>nul>> %userprofile%\Desktop\FolderAuth.bat
echo:exit>> %userprofile%\Desktop\FolderAuth.bat
echo :correct>> %userprofile%\Desktop\FolderAuth.bat
echo:cls>> %userprofile%\Desktop\FolderAuth.bat
echo:echo ______________________________________________>> %userprofile%\Desktop\FolderAuth.bat
echo:echo.>> %userprofile%\Desktop\FolderAuth.bat
echo:echo Password Accepted!>> %userprofile%\Desktop\FolderAuth.bat
echo:echo Opening Folder...>> %userprofile%\Desktop\FolderAuth.bat
echo:echo ______________________________________________>> %userprofile%\Desktop\FolderAuth.bat
::Also change this directory to the folder you're trying to need authentication for. TIP: Make the folder hidden
echo:explorer %folder%>> %userprofile%\Desktop\FolderAuth.bat
echo:ping localhost -n 2 ^>nul>> %userprofile%\Desktop\FolderAuth.bat
echo:exit>> %userprofile%\Desktop\FolderAuth.bat
exit /b