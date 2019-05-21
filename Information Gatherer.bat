@echo off
title Info
color 0c
:mainmenu
cls
echo:Whatcha need?
echo:[1] Basic Information
echo:[2] Network information
echo:[3] CPU Information
echo:----------------------------------
set /p input=: 
if %input%==1 goto :Basic
if %input%==2 goto :Net
if %input%==3 goto :CPU
if %input% GTR 3 echo: invalid reponse try again & goto :mainmenu
if %input% LSS 1 echo: invalid reponse try again & goto :mainmenu

:Basic
echo:----------------------------------
echo:
echo:You are logged in as...
echo:%username% || echo:Couldn't find it.. Error 404
echo:
echo:----------------------------------
echo:
echo Your PC's name is...
echo:%computername% || echo:Couldn't find it.. Error 404
echo:
echo:----------------------------------
:tryagain2
echo:
echo:Where to now?
echo:[1] Go to main menu
echo:[2] Show this page again
echo:[3] Exit the script
echo:----------------------------------
set /p yes=: 
if %yes%==1 goto :mainmenu
if %yes%==2 goto :Basic
if %yes%==3 exit
if %yes% GTR 3 echo: invalid reponse try again & goto :tryagain2
if %yes% LSS 1 echo: invalid reponse try again & goto :tryagain2

:Net
cls
echo:----------------------------------
echo:
echo:Your internal IPv4 address(es) is(are)...
ipconfig | find "IPv4 Address" || echo:Couldn't find it.. Error 404
echo:
echo:----------------------------------
echo:
echo Your external IPv4 address is...
curl -4 "https://ifconfig.co" || echo:Either the way this works is broken or this just failed...
echo:
echo:----------------------------------
echo:
echo Your external IPv6 address is...
curl -6 "https://ifconfig.co" || ( echo:Looks like you don't have IPv6 on your external...
    echo: For nerds looks like you don't have full duplex enabled on your WAN side...
)
echo:
echo:----------------------------------
:tryagain1
echo:
echo:Where to now?
echo:[1] Go to main menu
echo:[2] Show this page again
echo:[3] Exit the script
echo:----------------------------------
set /p hm=: 
if %hm%==1 goto :mainmenu
if %hm%==2 goto :Net
if %hm%==3 exit
if %hm% GTR 3 echo: invalid reponse try again & goto :tryagain1
if %hm% LSS 1 echo: invalid reponse try again & goto :tryagain1

:CPU
echo:----------------------------------
echo:
echo:CPU Identification
echo:%PROCESSOR_IDENTIFIER% || echo:Couldn't find it.. Error 404
echo:
echo:----------------------------------
echo:
echo CPU Core Count
echo:%NUMBER_OF_PROCESSORS% || echo:Couldn't find it.. Error 404
echo:
echo:----------------------------------
echo:
echo CPU Architecture
echo:%PROCESSOR_ARCHITECTURE% || echo:Couldn't find it.. Error 404
echo:
echo:----------------------------------
:tryagain3
echo:
echo:Where to now?
echo:[1] Go to main menu
echo:[2] Show this page again
echo:[3] Exit the script
echo:----------------------------------
set /p input3=: 
if %input3%==1 goto :mainmenu
if %input3%==2 goto :CPU
if %input3%==3 exit
if %input3% GTR 3 echo: invalid reponse try again & goto :tryagain3
if %input3% LSS 1 echo: invalid reponse try again & goto :tryagain3