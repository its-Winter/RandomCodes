@echo off
title Set Preferences...
echo:How much RAM do you want to dedicate to the server? - Numbers only
set /p RAM=:
cls
Title Installing Paper 1.15...
cd "%USERPROFILE%\Desktop"
mkdir "Paper 1.15"
cd "Paper 1.15"
curl -sSL https://papermc.io/api/v1/paper/1.15.1/34/download --output paper1.15.1.jar
java -Xmx%RAM%G -jar paper1.15.1.jar
echo:eula=true> eula.txt
cls
echo:Now set up the server properties and come back when you've saved your settings.
"server.properties"
pause
echo:java -Xmx%RAM%G -Xms%RAM%G -jar paper1.15.jar> start.bat
title Command Prompt
cmd /K "start.bat"