:: Name:     copy-and-convert.bat
:: Purpose:  Copies and converts the latest RSR daily recording to the Google Drive
::           folder in one step.
:: Author:   agulyas@societyfortheblind.org
:: Revision: 9/22/2016 (last version if all goes well)
:: Resources:
::      http://steve-jansen.github.io/guides/windows-batch-scripting/part-10-advanced-tricks.html
::      http://stackoverflow.com/questions/9349815/comparing-a-modified-file-date-with-the-current-date-in-a-batch-file
::      http://stackoverflow.com/questions/29824223/set-output-of-a-command-to-a-variable
::      http://stackoverflow.com/questions/14810544/get-date-in-yyyymmdd-format-in-windows-batch-file

@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

:: variables
SET today=%date:~10,4%_%date:~4,2%_%date:~7,2%
SET source=%1
SET destination=%2
FOR /F "delims=" %%i in ('FORFILES /P %source% /D 0 /M *nc*journal* /C "cmd /c echo @path"') DO SET recording=%%i
ECHO converting...
ECHO %recording%
sox.exe %recording% %destination%\%today%.mp3
ECHO Done - See results in %destination%.

:END
ENDLOCAL
ECHO ON
@EXIT /B 0