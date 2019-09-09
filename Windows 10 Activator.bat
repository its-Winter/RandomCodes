@echo off
color 0b
call :isAdmin
if %errorlevel% == 0 ( goto :run 
) else ( echo Requesting Administrative Privileges...
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
title Contact me on Discord at its.Winter#6512
cls
echo:============================================================================
echo:#Project: Activating Microsoft software products for FREE without software
echo:============================================================================
echo:\\\\\\ Version 2.1 //////
echo:--Supported products--
echo:  Windows 10 Home
echo:  Windows 10 Home N
echo:  Windows 10 Home Single Language
echo:  Windows 10 Home Country Specific
echo:  Windows 10 Professional
echo:  Windows 10 Professional N
echo:  Windows 10 Education
echo:  Windows 10 Education N
echo:  Windows 10 Enterprise
echo:  Windows 10 Enterprise N
echo:  Windows 10 Enterprise LTSB
echo:  Windows 10 Enterprise LTSB N
echo:============================================================================
echo:Activating your Windows...
echo:
cscript //nologo slmgr.vbs /ckms >nul
cscript //nologo slmgr.vbs /upk >nul
cscript //nologo slmgr.vbs /cpky >nul
set i=1
wmic os | findstr /I "enterprise" >nul
if %errorlevel% EQU 0 (
	echo:Windows Enterprise Found!
	cscript //nologo slmgr.vbs /ipk NPPR9-FWDCX-D2C8J-H872K-2YT43 >nul
	cscript //nologo slmgr.vbs /ipk DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4 >nul
	cscript //nologo slmgr.vbs /ipk WNMTR-4C88C-JK8YV-HQ7T2-76DF9 >nul
	cscript //nologo slmgr.vbs /ipk 2F77B-TNFGY-69QQF-B8YKP-D69TJ >nul
	cscript //nologo slmgr.vbs /ipk DCPHK-NFMTC-H88MJ-PFHPY-QJ4BJ >nul
	cscript //nologo slmgr.vbs /ipk QFFDN-GRT3P-VKWWX-X7T3R-8B639 >nul
	goto :server 
)
echo:Windows Enterprise not found..
wmic os | findstr /I "home"
if %errorlevel% EQU 0 (
	echo:Windows Home Found!
	cscript //nologo slmgr.vbs /ipk TX9XD-98N7V-6WMQ6-BX7FG-H8Q99 >nul
	cscript //nologo slmgr.vbs /ipk 3KHY7-WNT83-DGQKR-F7HPR-844BM >nul
	cscript //nologo slmgr.vbs /ipk 7HNRX-D7KGG-3K4RQ-4WPJ4-YTDFH >nul
	cscript //nologo slmgr.vbs /ipk PVMJN-6DFY6-9CCP6-7BKTT-D3WVR >nul
	goto :server 
)
echo:Windows Home not found..
wmic os | findstr /I "education" >nul
if %errorlevel% EQU 0 (
	echo:Windows Education Found!
	cscript //nologo slmgr.vbs /ipk NW6C2-QMPVW-D7KKK-3GKT6-VCFB2 >nul
	cscript //nologo slmgr.vbs /ipk 2WH4N-8QGBV-H22JP-CT43Q-MDWWJ >nul
	goto :server
)
echo:Windows Education not found..
wmic os | findstr /I "10 pro" >nul
if %errorlevel% EQU 0 (
	echo:Windows Pro Found!
	cscript //nologo slmgr.vbs /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX >nul
	cscript //nologo slmgr.vbs /ipk MH37W-N47XK-V7XM9-C7227-GCQG9 >nul
	goto :server
) else ( goto :notsupported 
)
:server
if %i% == 1 set KMS_Sev=kms8.MSGuides.com
if %i% == 2 set KMS_Sev=kms9.MSGuides.com
if %i% == 3 set KMS_Sev=kms7.MSGuides.com
if %i% == 4 goto :notsupported
cscript //nologo slmgr.vbs /skms %KMS_Sev%:1688 >nul
echo:============================================================================
echo:
cscript //nologo slmgr.vbs /ato | find /i "successfully" && (
	echo:
	echo:============================================================================
	echo:
	echo:============================================================================
	choice /n /c yn /m "Would you like to check out my other codes? [y,n]?"
	if errorlevel 2 exit ) || ( echo:The connection to my KMS server failed! Trying to connect to another one...
	echo:Please wait...
	echo:
	set /a i+=1
	goto :server 
)
explorer "https://gitlab.kitware.com/its-Winter/randomcodes"
goto :halt
:notsupported
echo:============================================================================
echo:Sorry! Your version is not supported.
:halt
exit