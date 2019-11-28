@echo off
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
goto :start

:vercheck
python --version | findstr /I "Python" && set py=Python || echo:You do not have python installed.
if DEFIND %py% ( for /f "tokens=2" %%G in ('python --version') do set pyver=%%G
	if %pyver% LSS 3.7.0 echo:You have a version older than 3.7 and it is required to update.
	if %pyver% GEQ 3.8.0 echo:You have the latest version of python.
)
:start
title Installing Red...
call :Prerequisites > %temp%\psinstall.ps1
powershell -executionpolicy bypass -File "%temp%\psinstall.ps1"
cls
echo:installed Red Prerequisites!
del /F /Q "%temp%\psinstall.ps1">nul
timeout 2>nul

:Venv
echo:Now time to setup that virtual environment!
:retry
echo:Where do you want the virtual environment? Ex: path\to\venv\
set /p in=
if [%in%] EQU [] ( echo:Nothing was entered!
	echo:
	goto :retry 
)
set venv=%userprofile%\%in%
choice /n /c yn /m "You have selected %venv% to be the virtual environment. Confirm? y/n"
if %ERRORLEVEL% EQU 1 ( echo:Setting up venv now! 
	python -m venv %venv%
)
if %ERRORLEVEL% EQU 2 goto :retry
call "%venv%\Scripts\activate.bat"
cls
cd "%userprofile%"
cmd

:Prerequisites
echo:Set-ExecutionPolicy Bypass -Scope Process -Force
echo:iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
echo:choco install git --params "/GitOnlyOnPath /WindowsTerminal" -y 
echo:choco install jre8 python -y; exit
exit /b