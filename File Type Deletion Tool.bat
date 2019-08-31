@echo off
title File type deletion tool
:top
echo:From where would you like to delete?
echo:----------------------------------------
echo:[1] Current location
echo:[2] Check location
echo:[3] From Somewhere Else
echo:----------------------------------------
set /p input=:
if %input% == 1 ( goto :type )
if %input% == 2 ( echo:You're open in.. %CD%
    echo:Press any key to Continue... & pause>nul
    cls
    goto :top )
if %input% == 3 ( goto :specifiedlocation 
) else ( cls
    echo:Invalid Response.
    goto :top 
)

:type
echo:----------------------------------------
echo:What type of file to delete?
echo:----------------------------------------
echo:[1] .txt
echo:[2] .doc
echo:[3] .docx
echo:[4] .png
echo:[5] .jpg
echo:[6] .jpeg
echo:[7] .mp3
echo:[8] .mp4
echo:[9] .avi
echo:[10] .wav
echo:[11] Other File Type
echo:----------------------------------------
set /p input=:
if %input% == 1 ( if NOT EXIST *.txt ( echo:No text files found.. 
        echo:Press any key to Continue.. & pause >nul 
        goto :type )
    del *.txt
    echo:Text files erased!
    echo:
    pause 
    goto :more )
if %input% == 2 ( if NOT EXIST *.doc ( echo:No doc files found.. 
        echo:Press any key to Continue.. & pause >nul 
        goto :type )
    del *.doc
    echo:Doc files erased!
    echo:
    pause 
    goto :more )
if %input% == 3 ( if NOT EXIST *.docx ( echo:No docx files found.. 
        echo:Press any key to Continue.. & pause >nul 
        goto :type )
    del *.docx
    echo:Docx files erased!
    echo:
    pause 
    goto :more )
if %input% == 4 ( if NOT EXIST *.png ( echo:No png files found.. 
        echo:Press any key to Continue.. & pause >nul 
        goto :type )
    del *.png
    echo:PNG files erased!
    echo:
    pause 
    goto :more )
if %input% == 5 ( if NOT EXIST *.jpg ( echo:No jpg files found.. 
        echo:Press any key to Continue.. & pause >nul 
        goto :type )
    del *.jpg
    echo:JPG files erased!
    echo:
    pause 
    goto :more )
if %input% == 6 ( if NOT EXIST *.jpeg ( echo:No jpeg files found.. 
        echo:Press any key to Continue.. & pause >nul 
        goto :type )
    del *.jpeg
    echo:JPEG files erased!
    echo:
    pause 
    goto :more )
if %input% == 7 ( if NOT EXIST *.mp3 ( echo:No mp3 files found.. 
        echo:Press any key to Continue.. & pause >nul 
        goto :type )
    del *.mp3
    echo:MP3 files erased!
    echo:
    pause 
    goto :more )
if %input% == 8 ( if NOT EXIST *.mp4 ( echo:No mp4 files found.. 
        echo:Press any key to Continue.. & pause >nul 
        goto :type )
    del *.mp4
    echo:MP4 files erased!
    echo:
    pause 
    goto :more )
if %input% == 9 ( if NOT EXIST *.avi ( echo:No avi files found.. 
        echo:Press any key to Continue.. & pause >nul 
        goto :type )
    del *.avi
    echo:AVI files erased!
    echo:
    pause 
    goto :more )
if %input% == 10 ( if NOT EXIST *.wav ( echo:No wav files found.. 
        echo:Press any key to Continue.. & pause >nul 
        goto :type )
    del *.wav
    echo:WAV files erased!
    echo:
    pause 
    goto :more )
echo:----------------------------------------
echo:What File type to delete?
echo:
set /p file=:
if NOT EXIST *%file% ( echo:No %file% files found.. 
        echo:Press any key to Continue.. & pause >nul 
        goto :type )
    del *%file%
    echo:%file% files erased!
    echo:
    pause )
:more
echo:Erase more files? y / n
set /p yorn=:
if %yorn% == y ( cls & goto :top )
if %yorn% == n ( exit
) else ( cls
    echo:Invalid Response.
    pause
    goto :more )
:specifiedlocation
echo:----------------------------------------
echo:Where to? EX: C:\Users\john\Desktop or D:\files - Exact Path please.
set /p whereto=
cd "%whereto%" 2>nul || ( echo:Couldn't Find that folder.. & pause & goto :specifiedlocation )
goto :type