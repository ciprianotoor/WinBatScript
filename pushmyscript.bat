@echo off
REM ==========================
REM Script para sincronizar WinBatScript con GitHub (Windows)
REM ==========================

REM Carpeta del proyecto
SET REPO_PATH=C:\Users\cipriano\Git\WinBatScript

REM Pedir comentario del commit
SET /P MESSAGE=Escriba comentario del commit: 

IF "%MESSAGE%"=="" (
    SET MESSAGE=Actualizacion automatica
)

REM Ir al directorio del proyecto
cd /d "%REPO_PATH%"

REM Configurar finales de línea para Windows
git config core.autocrlf true

REM Verificar si es repositorio Git
git rev-parse --is-inside-work-tree >nul 2>&1

IF ERRORLEVEL 1 (
    echo Inicializando repositorio Git...
    git init
    git remote add origin git@github.com:ciprianotoor/WinBatScript.git
)

REM Agregar todos los cambios
git add .

REM Hacer commit
git commit -m "%MESSAGE%"

REM Push a la rama master
git push -u origin master

echo.
echo ==========================
echo Sincronizacion completa.
echo Comentario: %MESSAGE%
echo ==========================

pause

REM Abrir enlace GitHub
set /p respuesta=¿Desea abrir el enlace en Microsoft Edge? (S/N)

if /I "%respuesta%"=="S" (
    start msedge "https://github.com/ciprianotoor/WinBatScript"
) else (
    echo No se abrio el enlace.
)

pause
exit