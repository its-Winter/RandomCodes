@echo off
Title Installing Paper 1.15...
cd "%homedrive%%homepath%\Desktop"
mkdir "Paper 1.15"
cd "Paper 1.15"
curl -sSL https://papermc.io/api/v1/paper/1.15/8/download --output paper1.15.jar
java -Xmx4G -jar paper1.15.jar
echo:eula=true> eula.txt
cls
echo:Now set up the server properties and come back when you've saved your settings.
"server.properties"
pause
echo:java -Xmx6G -Xms6G -jar paper1.15.jar> start.bat
title Command Prompt
cmd /K "start.bat"