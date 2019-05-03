@echo off
title Folder Authentication
color 0b
for /f %%i in ('more %userprofile%\Desktop\Coding\config') do set password=%%i
rem change '\Desktop\Coding\config' to the file is in that contains the super secret password. Also make sure the file is set to read only to prevent any accidental changes to the password and set to hidden.
rem %userprofile% is C:\Users\<whoever you're logged in as>
rem For me %userprofile% = C:\Users\winter -- if you don't know what your %userprofile% variable is set to then open cmd and type
rem echo %userprofile%
rem and it will return what it is set to.
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
rem Also change this directory to the folder you're trying to need authentication for. TIP: Make the folder hidden
explorer %userprofile%\Desktop\Coding
ping localhost -n 2 >nul
exit