@echo off
REM Caminho base (a pasta onde o .bat está)
set BASEDIR=%~dp0

REM Verifica se o emulador existe
if not exist "%BASEDIR%vba.exe" (
    echo O emulador vba.exe nao foi encontrado na pasta!
    exit
)

REM Verifica se a ROM existe
if not exist "%BASEDIR%game.gb" (
    echo O arquivo game.gb nao foi encontrado na pasta!
    exit
)

REM Executa o emulador com a ROM
start "" "%BASEDIR%vba.exe" "%BASEDIR%game.gb"

REM Mensagem de confirmação
echo Abrindo o jogo game.gb... Divirta-se!
exit
