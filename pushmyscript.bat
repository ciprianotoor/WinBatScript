@echo off
REM ==========================
REM Script para sincronizar WinBatScript con GitHub
REM ==========================

REM Configura la carpeta del proyecto
SET REPO_PATH=C:\Users\cipriano\WinBatScript
SET MESSAGE=%1

IF "%MESSAGE%"=="" (
    SET MESSAGE=Actualización automática
)

REM Cambia al directorio del proyecto
cd /d "%REPO_PATH%"

REM Verifica si es un repositorio Git
git rev-parse --is-inside-work-tree >nul 2>&1
IF ERRORLEVEL 1 (
    echo Inicializando repositorio Git...
    git init
    REM Agregar remoto (reemplaza con tu usuario)
    git remote add origin git@github.com:ciprianotoor/WinBatScript.git
)

REM Agregar todos los cambios
git add .

REM Hacer commit
git commit -m "%MESSAGE%"

REM Hacer push al remoto
git push -u origin main

echo.
echo ==========================
echo Sincronización completa.
pause
