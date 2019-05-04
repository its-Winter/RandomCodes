@echo off
goto start
:startover
echo.
echo.
:start
echo This is your external IPv4 address
curl -4 "https://ifconfig.co"
echo ___________________________________
echo.
echo Testing for an external IPv6 address...
curl -6 --max-time 10 "https://ifconfig.co"2>nul && echo This is your external IPv6 address! You're wise for having one..
if %ERRORLEVEL% NEQ 0 (
    echo Looks like you probably don't have IPv6 enabled on your network... 
    echo or the website is broken with IPv6 currently.
)
echo.
echo Try again? y / n
set input=
set /p input=
if %input% == y goto startover
if %input% == n exit
