@echo off
rem ======================================================
rem  MID to GT1 Drag-and-Drop Converter
rem  Author : (your name)
rem  Version: 1.1  – asks for duration in seconds
rem ------------------------------------------------------
rem  Usage:
rem     1. Place this BAT beside
rem        ./midi_converter.exe
rem        ./gtbasic_WIN10_x64.exe
rem        ./midi_config.ini
rem     2. Drag any *.mid file onto this BAT.
rem     3. Enter the desired conversion length (seconds).
rem  Output:
rem     - basename.gbas
rem     - basename.gt1
rem ======================================================
setlocal enabledelayedexpansion

:: ------------------------------------------------------
:: 1. Validate drop
:: ------------------------------------------------------
if "%~1"=="" (
    echo No file dropped. Please drag a *.mid file onto this script.
    pause
    exit /b 1
)

:: ------------------------------------------------------
:: 2. Build paths
:: ------------------------------------------------------
set "MID_FILE=%~1"
set "BASE_NAME=%~n1"
set "GBAS_FILE=%BASE_NAME%.gbas"
set "GT1_FILE=%BASE_NAME%.gt1"

:: ------------------------------------------------------
:: 3. Ask user for duration
:: ------------------------------------------------------
set "DURATION="
set /p DURATION=Enter conversion time in seconds (e.g. 25.5): 
if "%DURATION%"=="" (
    echo [ERROR] No duration supplied.
    pause
    exit /b 2
)

:: ------------------------------------------------------
:: 4. MIDI -^> GBAS
:: ------------------------------------------------------
echo [INFO] Converting "%MID_FILE%" to "%GBAS_FILE%" for %DURATION%s...
.\midi_converter.exe "%MID_FILE%" "%GBAS_FILE%" -d -time %DURATION% -config midi_config.ini

if not exist "%GBAS_FILE%" (
    echo [ERROR] Conversion failed. "%GBAS_FILE%" not created.
    pause
    exit /b 3
)

:: ------------------------------------------------------
:: 5. GBAS -^> GT1
:: ------------------------------------------------------
echo [INFO] Compiling "%GBAS_FILE%" to "%GT1_FILE%"...
.\gtbasic_WIN10_x64.exe "%GBAS_FILE%" "%GT1_FILE%"

echo [SUCCESS] Done. Output: "%GT1_FILE%"
pause
endlocal
exit /b 0