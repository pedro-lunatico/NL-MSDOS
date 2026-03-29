@echo off

:: URL DO SITE
set SITE=https://gam.onl/sega-saturn/#segaSaturn---225

:: Caminhos do Edge
set EDGE64="%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
set EDGE32="%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"

:: Caminhos do Chrome
set CHROME64="%ProgramFiles%\Google\Chrome\Application\chrome.exe"
set CHROME32="%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"

:: Tentar Edge fullscreen
if exist %EDGE64% (
    start "" %EDGE64% --app=%SITE% --start-fullscreen
    exit
)

if exist %EDGE32% (
    start "" %EDGE32% --app=%SITE% --start-fullscreen
    exit
)

:: Tentar Chrome fullscreen
if exist %CHROME64% (
    start "" %CHROME64% --app=%SITE% --start-fullscreen
    exit
)

if exist %CHROME32% (
    start "" %CHROME32% --app=%SITE% --start-fullscreen
    exit
)

echo Nenhum navegador Edge ou Chrome encontrado.
pause
