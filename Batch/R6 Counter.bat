@echo off
title Counting your alpha packs!
cd "%homedrive%%homepath%\Documents"
mkdir "Text Files"
cd "Text Files"
if DEFINED *.txt (
	for /F %%G in (total.txt) do set total=%%G
	for /F %%G in (common.txt) do set common=%%G
	for /F %%G in (uncommon.txt) do set uncommon=%%G
	for /F %%G in (rare.txt) do set rare=%%G
	for /F %%G in (epic.txt) do set epic=%%G
	for /F %%G in (legendary.txt) do set legendary=%%G
) else (
	set total=200
	set common=0
	set uncommon=0
	set rare=0
	set epic=0
	set legendary=0
	echo:%total%> total.txt
	echo:%common%> common.txt
	echo:%uncommon%> uncommon.txt
	echo:%rare%> rare.txt
	echo:%epic%> epic.txt
	echo:%legendary%> legendary.txt )
cls && echo:Now add the text files located in your documents folder to your OBS screen and continue.
pause
goto :top2
:top
echo:%total%> total.txt
echo:%common%> common.txt
echo:%uncommon%> uncommon.txt
echo:%rare%> rare.txt
echo:%epic%> epic.txt
echo:%legendary%> legendary.txt
:top2
cls && echo:What value do you want to add to?
echo:  --  Total Remaining: %total%  --
echo:[1] Common - Current Value: %common%
echo:[2] -1 from Common
echo:[3] Uncommon - Current Value: %uncommon%
echo:[4] -1 from Uncommon
echo:[5] Rare - Current Value: %rare%
echo:[6] -1 from Rare
echo:[7] Epic - Current Value: %epic%
echo:[8] -1 from Epic
echo:[9] Legendary - Current Value: %legendary%
echo:[0] -1 from Legendary
echo:[*] Reset values
set /p _in=
if %_in% == 1 (
	set /A "common=common+=1, total=total-=1" && goto :top )
if %_in% == 2 (
	set /A "common=common-=1, total=total+=1" && goto :top )
if %_in% == 3 (
	set /A "uncommon=uncommon+=1, total=total-=1" && goto :top )
if %_in% == 4 (
	set /A "uncommon=uncommon-=1, total=total+=1" && goto :top )
if %_in% == 5 (
	set /A "rare=rare+=1, total=total-=1" && goto :top )
if %_in% == 6 (
	set /A "rare=rare-=1, total=total+=1" && goto :top )
if %_in% == 7 (
	set /A "epic=epic+=1, total=total-=1" && goto :top )
if %_in% == 8 (
	set /A "epic=epic-=1, total=total+=1" && goto :top )
if %_in% == 9 (
	set /A "legendary=legendary+=1, total=total-=1" && goto :top )
if %_in% == 0 ( 
	set /A "legendary=legendary-=1, total=total+=1" && goto :top ) 
if %_in% == * (
	set total=200
	set common=0
	set uncommon=0
	set rare=0
	set epic=0
	set legendary=0
	goto :top
) else (
	echo:Invalid Input.. && pause && goto :top )