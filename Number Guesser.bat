@echo off
:ABC
color 0b
echo think of a number 1-5
echo.
pause
cls
echo now remember that number or write it down...
echo.
pause
cls
echo answer all of these questions with either yes or no.
echo.
pause
cls
:startover
cls
echo does your number (as a word), start with an "O"?
echo.
set /p answer= : 
if %answer% == yes goto A
if %answer% == no goto B
echo.
echo Incorrect Input..
goto startover
pause
cls
:A
echo is your number "1"?
echo.
set /p answer= : 
if %answer% == no goto D
if %answer% == yes goto C
echo.
pause
cls
:B
echo does your number (as a word), start with a "T"?
echo.
set /p answer= : 
if %answer% == no goto E
if %answer% == yes goto F
echo.
pause
cls
:C
echo I Won c:
echo.
pause
cls
goto ABC
:D
echo Stop Cheating!
echo.
pause
cls
goto ABC
:F
echo is your number "2"?
echo.
set /p answer= : 
if %answer% == no goto G
if %answer% == yes goto 6
echo.
pause
cls
:E
echo does your number start with an "F"?
echo.
set /p answer= : 
if %answer% == no goto H
if %answer% == yes goto I
echo.
pause
cls
:G
echo is your number "3"?
echo.
set /p answer= : 
if %answer% == no goto J
if %answer% == yes goto K
:J
echo Stop Cheating!
echo.
pause
cls
goto ABC
:H
echo well something is wrong here...
pause
goto ABC
:K
echo I Won c:
echo.
pause
cls
goto ABC
:6
echo I Won c:
echo.
pause
cls
goto ABC
:I
echo is your number "4"?
echo.
set /p answer= : 
if %answer% == no goto M
if %answer% == yes goto L
echo.
pause
cls
:L
echo I won c:
echo.
pause
cls
goto ABC
:M
echo is your number "5"?
echo.
set /p answer= : 
if %answer% == no goto N
if %answer% == yes goto O
echo.
pause
cls
:N
echo Stop Cheating!
echo.
pause
cls
goto ABC
:O
echo I Won c:
echo.
pause
cls
goto ABC