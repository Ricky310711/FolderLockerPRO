@echo off
color 0F
echo. > tmp.txt
cd >> tmp.txt
set /p current=< tmp.txt
del tmp.txt
cd "%current%"
mode con:cols=41 lines=22
if exist "Private" then goto main
mkdir Private

:main
cls
echo  ***************************************
echo            Folder Locker Pro
echo  ***************************************
echo.
echo  1. Hide the "Private" folder
echo  2. Unhide "Private" contents
echo.
set /P selection= Make your decision:
if %selection% == 1 goto hide
if %selection% == 2 goto unhide

:hide
cls
echo  ***************************************
echo            Folder Locker Pro
echo  ***************************************
echo  insert files and folders you wish to
echo  hide inside the "Private" folder then
set /P password= Enter an unlock password:
echo Password:%password% > Private/password
attrib +s +h "Private"
echo  FOLDER HIDDEN
pause
goto main

:unhide
if not exist Private/password goto nonehidden
findstr "Password:" "Private\password" >tmp.txt
cscript "%MYFILES%/sed.vbs" "tmp.txt" "Password:" "">nul
set /p passwordcorrect=<tmp.txt
del "tmp.txt"
cls
echo  ***************************************
echo            Folder Locker Pro
echo  ***************************************
set /P password= Enter unlock password:
if %password% == %passwordcorrect% attrib -s -h "Private"
if %password% == %passwordcorrect% del "Private\password"
if %password% == %passwordcorrect% echo  CORRECT PASSWORD
if %password% == %passwordcorrect% pause
if %password% == %passwordcorrect% goto main
if not %password% == %passwordcorrect% echo  INCORRECT PASSWORD
if not %password% == %passwordcorrect% pause
if not %password% == %passwordcorrect% goto unhide