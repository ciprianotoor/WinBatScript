@echo off
REM ==========================
REM Script para sincronizar WinBatScript con GitHub (Windows)
REM ==========================

REM Carpeta del proyecto
SET REPO_PATH=C:\Users\cipriano\WinBatScript
SET MESSAGE=%1

IF "%MESSAGE%"=="" (
    SET MESSAGE=Actualización automática
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
    REM Agregar remoto (reemplaza con tu URL si es necesario)
    git remote add origin git@github.com:ciprianotoor/WinBatScript.git
)

REM Agregar todos los cambios
git add .

REM Hacer commit
git commit -m "%MESSAGE%"

REM Push a la rama correcta (master en lugar de main)
git push -u origin master

echo.
echo ==========================
echo Sincronizacion completa.
pause
@echo off
set /p respuesta=¿Desea abrir el enlace en Microsoft Edge? (S/N) 

if /I "%respuesta%"=="S" (
    start msedge "https://github.com/ciprianotoor/WinBatScript"
) else (
    echo No se abrió el enlace.
)
pause
exit