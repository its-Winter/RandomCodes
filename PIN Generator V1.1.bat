@echo off
set /a num4 =%random:~-1% %random:~-1% %random:~-1% %random:~-1%
set /a num6 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%
cls
goto Start2


:Start8
cls
echo Your 4 Digit PIN was successfully generated to a text file!
echo Press any key to make more...
pause >nul
goto Start2


:Start7
cls
echo Your 5 6 Digit Random PINs were successfully generated to a text file!
echo Press any key to make more...
pause >nul
goto Start2


:Start6
cls
echo Your Random 6 Digit PIN was successfully generated to a text file!
echo Press any key to make more...
pause >nul
goto Start2


:Start5
cls
echo Your Random PIN was successfully generated to a text file!
echo Press any key to make more...
pause >nul
goto Start2


:Start4
cls
echo Your 4 Digit PIN was successfully generated to a text file!
echo Press any key to make more...
pause >nul
goto Start2


:Start3
cls
echo Your 5 4 Digit Random PINs were successfully generated to a text file!
echo Press any key to make more...
pause >nul
goto Start2


:Start2
cls
goto Start


:Start
title PIN Generator
echo This will generate a new PIN
echo Please save the generated PIN somewhere in case you forget it.
echo https://www.github.com/its-winter/randomcodes
echo ______________________________________________________________
echo.
echo 1) 1 Random PIN (0, 32767)
echo 2) 1 Random 4 Digit PIN 
echo 3) 5 Random 4 Digit PINs
echo 4) 1 Random 6 Digit PIN
echo 5) 5 Random 6 Digit PINs 
echo 6) Write Option 1 to text file
echo 7) Write Option 2 to text file
echo 8) Write Option 3 to text file
echo 9) Write Option 4 to text file
echo 10) Write Option 5 to text file
echo 11) Exit script
echo How many pin(s) today?
set input=
set /p input= Option:
if %input%==1 goto A else goto Start2
if %input%==2 goto B else goto Start2
if %input%==3 goto C else goto Start2
if %input%==4 goto D else goto Start2
if %input%==5 goto E else goto Start2
if %input%==6 call :F > %USERPROFILE%\Desktop\randompin.txt & goto Start5
if %input%==7 call :G > %USERPROFILE%\Desktop\4digitpin.txt & goto Start8
if %input%==8 call :H > %USERPROFILE%\Desktop\5random4digits.txt & goto Start3
if %input%==9 call :I > %USERPROFILE%\Desktop\6digitpin.txt & goto Start6
if %input%==10 call :J > %USERPROFILE%\Desktop\5random6digits.txt & goto Start7
if %input%==11 goto exit
if %input% GTR 11 goto Start2
if %input% LSS 1 goto Start2


:A
cls
echo Your PIN is %random%
echo _____________________
echo.
echo 1) Generate more
echo 2) Exit
set input=
set /p input= Choice:
if %input%==1 goto Start2
if %input%==2 exit
if %input% GTR 2 goto A
if %input% LSS 1 goto A


:B
cls
echo Your 4 Digit PIN is: 
set /a num4 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num4%
echo ___________________________________________________________________
echo.
echo 1) Generate more
echo 2) Exit
set input=
set /p input= Choice:
if %input%==1 goto Start2 
if %input%==2 exit
if %input% GTR 2 goto B
if %input% LSS 1 goto B


:C
cls
echo Your 5 4 Digit PINs are:
echo.
set /a num4 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num4%
echo.
set /a num4 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num4%
echo.
set /a num4 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num4%
echo.
set /a num4 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num4%
echo.
set /a num4 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num4%
echo ________________________________________________________________________________________________________________________
echo.
echo 1) Generate more
echo 2) Exit
set input=
set /p input= Choice:
if %input%==1 goto Start2
if %input%==2 exit
if %input% GTR 2 goto Start2
if %input% LSS 1 goto Start2


:D
cls
echo Your 6 Digit PIN is: 
set /a num6 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num6%
echo ___________________________________________________________________
echo.
echo 1) Generate more
echo 2) Exit
set input=
set /p input= Choice:
if %input%==1 goto Start2 
if %input%==2 exit
if %input% GTR 2 goto D
if %input% LSS 1 goto D


:E
cls
echo Your 5 6 Digit PINs are:
echo.
set /a num6 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num6%
echo.
set /a num6 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num6%
echo.
set /a num6 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num6%
echo.
set /a num6 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num6%
echo.
set /a num6 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num6%
echo ________________________
echo.
echo 1) Generate more
echo 2) Exit
set input=
set /p input= Choice:
if %input%==1 goto Start2 
if %input%==2 exit 
if %input% GTR 2 goto E
if %input% LSS 1 goto E


:F
cls
echo Your PIN is %random%
goto lol



:G 
echo Your 4 Digit PIN is: 
echo.
set /a num4 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num4%
goto lol
 

:H
cls
echo Your 5 4 Digit PINs are:
echo.
set /a num4 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num4%
echo.
set /a num4 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num4%
echo.
set /a num4 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num4%
echo.
set /a num4 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num4%
echo.
set /a num4 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num4%
goto lol


:I
cls
echo Your 6 Digit PIN is: 
echo.
set /a num6 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num6%
goto lol

:J
cls
echo Your 5 6 Digit PINs are:
echo.
set /a num6 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num6%
echo.
set /a num6 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num6%
echo.
set /a num6 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num6%
echo.
set /a num6 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num6%
echo.
set /a num6 =%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%
echo %num6%
goto lol

:exit
echo Are you sure you want to exit? (Y / N)
set input=
set /p input=
if %input%==Y exit
if %input%==N goto Start2

:lol
