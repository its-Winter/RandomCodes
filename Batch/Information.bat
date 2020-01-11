@echo off
title Info
color 0c
:clearscreen
cls
:mainmenu
echo:Whatcha need?
echo:[1] Basic Information
echo:[2] Network information
echo:[3] System Information
echo:[4] Advanced Information
echo:[5] Optional Inforation
echo:[6] Exit this script
echo:----------------------------------
set /p input=: 
if %input%==1 goto :Basic
if %input%==2 goto :Net
if %input%==3 goto :System
if %input%==4 goto :Advanced
if %input%==5 goto :Optionalinforation
if %input%==6 ( exit
) else ( 
    echo:----------------------------------
    echo: invalid reponse try again 
    echo:
    goto :mainmenu
)

:Basic
set currentlabel=:Basic
echo:----------------------------------
echo:
echo:You are logged in as...
echo:%username% || echo:Somehow failed to fetch User.
echo:
echo:----------------------------------
echo:
echo:Your System Timezone is...
wmic timezone get description | find "(" || echo: Failed to catch Timezone.
echo:
echo:----------------------------------
echo:
echo Your PC's name is...
echo:%computername% || echo:Somehow failed to fetch computer name.
echo:
echo:----------------------------------
echo:
echo:Windows Information
wmic os get caption, version, buildnumber, serialnumber
echo:----------------------------------
goto :tryagain

:Net
set currentlabel=:Net
cls
echo:----------------------------------
echo:
echo:All interfaces' internal IP addresses are...
ipconfig /all | find "IPv4 Address" || echo:Somehow failed to fetch IPv4 Address(es).
ipconfig /all | find "IPv6 Address" || echo:Somehow failed to fetch IPv6 Address(es).
echo:
echo:----------------------------------
echo:
echo Your external IPv4 address is...
curl -4 "https://ifconfig.co" || ( echo:Either the way this works is broken or this just failed...
    echo:If failed, you might not be connected to the internet.
)
echo:
echo:----------------------------------
echo:
echo Your external IPv6 address is...
curl -6 --max-time 10 "https://ifconfig.co"2>nul || ( echo:Looks like you don't have IPv6 on your external network...
    echo:For nerds looks like you don't have full duplex enabled on WAN.
)
echo:
echo:----------------------------------
goto :tryagain

:System
set currentlabel=:System
echo:----------------------------------
echo:
echo:CPU Identification
wmic cpu get name | find "I" || wmic cpu get name | find "A" || echo:Failed to find CPU name.
echo:
echo:----------------------------------
echo:
echo CPU Core Count
echo:%NUMBER_OF_PROCESSORS% || echo:Your system variable for logical processors seems to have failed.
echo:
echo:----------------------------------
echo:
echo:CPU Architecture
wmic computersystem get systemtype | find "x" || echo:Somehow failed to find Architecture.
echo:
echo:----------------------------------
echo:
echo:Total Amount of System Memory
wmic os get TotalVisibleMemorySize | find "1" || wmic os get TotalVisibleMemorySize | find "2" || wmic os get TotalVisibleMemorySize | find "3" ||  wmic os get TotalVisibleMemorySize | find "4" ||  wmic os get TotalVisibleMemorySize | find "5" ||  wmic os get TotalVisibleMemorySize | find "6" ||  wmic os get TotalVisibleMemorySize | find "7" ||  wmic os get TotalVisibleMemorySize | find "8" ||  wmic os get TotalVisibleMemorySize | find "9" ||  echo:Somehow failed to find memory amount.
echo:
echo:----------------------------------
goto :tryagain

:Advanced
set currentlabel=:Advanced
echo:----------------------------------
echo:
echo:Disk Volumes
wmic logicaldisk get Caption, Description, Filesystem, Size
echo:----------------------------------
echo:
echo:BIOS Information
wmic bios get caption, manufacturer
echo:----------------------------------
echo:
echo:Boot Type
wmic computersystem get bootupstate | find "N" || wmic computersystem get bootupstate | find "F"
echo:
echo:----------------------------------
echo:
echo:Motherboard Information
wmic baseboard get manufacturer, product, serialnumber, status || echo:Could not recieve info on Motherboard.
echo:----------------------------------
echo:
echo:Windows Boot Configuration
wmic bootconfig get bootdirectory, tempdirectory
echo:----------------------------------
echo:
echo:Some random info about users...
wmic desktop get Name, Screensaveractive, wallpaper, wallpaperstretched, wallpapertiled
echo:----------------------------------
goto :tryagain

:Optionalinformation
set currentlabel=:Optionalinforation
echo:----------------------------------
echo:What do you need now? More to come soon
echo:[1] Driver List
echo:[2] Go Back
echo:----------------------------------
set /p idkanymore=
if %idkanymore%==1 ( set whatyouwant=:driveroutput
    goto :outputstart
)
if %idkanymore%==2 ( goto :mainmenu
) else ( 
    echo:----------------------------------
    echo:Invalid Response
    goto :OptionalInformation
)

:outputstart
echo:----------------------------------
echo:For Optional Inforation, all info will go to an output text file.
echo:Output will go to your Desktop.
echo:Continue? [y, n]
set /p continue=: 
if %continue%==n goto :clearscreen
if %continue%==y ( 
    cd %userprofile%
    call %whatyouwant% > Desktop\Output%random:~-1%.txt
    goto :tryagain
) else ( 
    echo:----------------------------------
    echo:Invalid response try again
    goto :outputstart
)

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
if %input2%==3 ( exit 
) else ( echo:Invalid reponse try again 
    goto :tryagain
)

:driveroutput
echo:----------------------------------
echo:
echo:All drivers installed on your machine are...
wmic sysdriver get caption, status
echo:----------------------------------
exit /b