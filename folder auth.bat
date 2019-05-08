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
for /f %%I in ('more %userprofile%\Documents\config') do set password=%%I
for /f %%G in ('more %userprofile%\Documents\config2') do set folder=%%G
::Change '\Desktop\Coding\config' to the file is in that contains the super secret password. Also make sure the file is set to read only to prevent any accidental changes to the password and set to hidden.
::%userprofile% is C:\Users\<whoever you're logged in as>
::For me %userprofile% = C:\Users\Winter -- if you don't know what your %userprofile% variable is set to then open cmd and type
::echo %userprofile%
::and it will return what it is set to.
:top
echo __________________
echo.
echo Folder Password
echo __________________
echo.
echo You have 1 attempt only.
echo Enter password
echo ______________________________________________
set /p pass= : 
if %pass% == %password% goto correct
if %pass% NEQ %password% goto fail
cls
goto top
:fail
echo Did you forget your own password? Gosh...
echo Press any key to close window...
pause >nul
exit
:correct
cls
echo ______________________________________________
echo.
echo Password Accepted!
echo Opening Folder...
echo ______________________________________________
explorer %folder%
ping localhost -n 2 >nul
exit