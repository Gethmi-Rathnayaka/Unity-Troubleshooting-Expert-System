@echo off
setlocal

cd /d "%~dp0"

echo ==========================================
echo Unity Troubleshooting Expert System
echo ==========================================
echo.
echo Project folder:
echo %CD%
echo.
echo Searching for SWI-Prolog...
echo.

set "SWIPL="

if exist "C:\Program Files\swipl\bin\swipl.exe" (
    set "SWIPL=C:\Program Files\swipl\bin\swipl.exe"
)

if exist "C:\Program Files (x86)\swipl\bin\swipl.exe" (
    set "SWIPL=C:\Program Files (x86)\swipl\bin\swipl.exe"
)

if not defined SWIPL (
    where swipl >nul 2>&1
    if not errorlevel 1 (
        set "SWIPL=swipl"
    )
)

if not defined SWIPL (
    echo ERROR: SWI-Prolog could not be found.
    echo.
    echo Please install SWI-Prolog before running this program.
    echo.
    pause
    exit /b 1
)

echo SWI-Prolog found.
echo.
echo Starting server...
echo.
echo Open http://localhost:8080 in your browser.
echo.
echo Close this window to stop the server.
echo.

"%SWIPL%" -s server.pl -g "server(8080)"

endlocal