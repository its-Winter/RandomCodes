@echo off
title Info
color 0c
:mainmenu
cls
echo:Whatcha need?
echo:[1] Basic Information
echo:[2] Network information
echo:[3] System Information
echo:[4] Advanced Information
echo:----------------------------------
set /p input=: 
if %input%==1 goto :Basic
if %input%==2 goto :Net
if %input%==3 goto :System
if %input%==4 goto :Advanced
if %input% GTR 4 echo: invalid reponse try again & goto :mainmenu
if %input% LSS 1 echo: invalid reponse try again & goto :mainmenu

:Basic
set currentlabel=:Basic
echo:----------------------------------
echo:
echo:You are logged in as...
echo:%username% || echo:Couldn't find it.. Error 404
echo:
echo:----------------------------------
echo:
echo:Your System Timezone is...
wmic timezone get description | find "(" || echo:Couldn't find it.. Error 404
echo:----------------------------------
echo:
echo Your PC's name is...
echo:%computername% || echo:Couldn't find it.. Error 404
echo:
echo:----------------------------------
echo:
echo:Windows Information
wmic os get caption,version,buildnumber,serialnumber
echo:----------------------------------
goto :tryagain

:Net
set currentlabel=:Net
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
    echo: For nerds looks like you don't have full duplex enabled on WAN...
)
echo:
echo:----------------------------------
goto :tryagain

:System
set currentlabel=:System
echo:----------------------------------
echo:
echo:CPU Identification
wmic cpu get name | find "I" || wmic cpu get name | find "A" || echo:Couldn't find it.. Error 404
echo:
echo:----------------------------------
echo:
echo CPU Core Count
echo:%NUMBER_OF_PROCESSORS% || echo:Couldn't find it.. Error 404
echo:
echo:----------------------------------
echo:
echo:CPU Architecture
wmic computersystem get systemtype | find "x" || echo:Couldn't find it.. Error 404
echo:
echo:----------------------------------
echo:
echo:Total Amount of System Memory
wmic os get TotalVisibleMemorySize | find "1" || wmic os get TotalVisibleMemorySize | find "2" || wmic os get TotalVisibleMemorySize | find "3" ||  wmic os get TotalVisibleMemorySize | find "4" ||  wmic os get TotalVisibleMemorySize | find "5" ||  wmic os get TotalVisibleMemorySize | find "6" ||  wmic os get TotalVisibleMemorySize | find "7" ||  wmic os get TotalVisibleMemorySize | find "8" ||  wmic os get TotalVisibleMemorySize | find "9" ||  echo:Couldn't find it.. Error 404
echo:
echo:----------------------------------
goto :tryagain

:Advanced
set currentlabel=:Advanced
echo:----------------------------------
echo:
echo:Disk Volumes
wmic partition get name,size,type
echo:----------------------------------
echo:
echo:BIOS Information
wmic bios get caption,manufacturer
echo:----------------------------------
echo:
echo:Boot Type
wmic computersystem get bootupstate | find "N" || wmic computersystem get bootupstate | find "F"
echo:
echo:----------------------------------
echo:
echo:Motherboard Information
wmic baseboard get manufacturer,product,serialnumber,status
echo:----------------------------------

:tryagain
echo:
echo:Where to now?
echo:[1] Go to main menu
echo:[2] Show this page again
echo:[3] Exit the script
echo:----------------------------------
set /p input2=: 
if %input2%==1 goto :mainmenu
if %input2%==2 goto %currentlabel%
if %input2%==3 exit
if %input2% GTR 3 echo: invalid reponse try again & goto :tryagain
if %input2% LSS 1 echo: invalid reponse try again & goto :tryagain
