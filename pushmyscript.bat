@echo off
REM --------------------------------------------------
REM pushmyscript.bat  – sincroniza un repo local
REM   USO: pushmyscript.bat [mensaje de commit]
REM --------------------------------------------------

setlocal enabledelayedexpansion

:: configuración editables
set "REPO_PATH=C:\Users\cipriano\WinBatScript"
set "DEFAULT_BRANCH=master"
set "LOGFILE=%REPO_PATH%\push.log"

if "%1"=="?" goto :usage
if "%1"=="-h" goto :usage
set "MESSAGE=%~1"
if "%MESSAGE%"=="" set "MESSAGE=Actualización automática"

:: entrar al repo
cd /d "%REPO_PATH%" 2>nul || (
    echo ERROR: no existe la carpeta %REPO_PATH%
    exit /b 1
)

git config core.autocrlf true

:: inicialización si falta .git
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo Inicializando repositorio...
    git init
    git remote add origin git@github.com:ciprianotoor/WinBatScript.git
)

:: seleccionar rama actual o predeterminada
for /f "delims=" %%b in ('git rev-parse --abbrev-ref HEAD') do set "BRANCH=%%b"
if "%BRANCH%"=="HEAD" set "BRANCH=%DEFAULT_BRANCH%"

echo [%date% %time%] branch=%BRANCH% >> "%LOGFILE%"

:: añadir + commit opcional
echo Añadiendo cambios...
git add .
git diff --quiet --staged
if errorlevel 1 (
    git commit -m "%MESSAGE%"
) else (
    echo (no hay nada que commitear)
)

:: push
echo Haciendo push a origin/%BRANCH%...
git push -u origin %BRANCH%
if errorlevel 1 (
    echo ERROR: git push falló, comprueba credenciales o conflictos.
    echo >> "%LOGFILE%"
    exit /b 1
)

:: URL del repositorio
for /f "delims=" %%u in ('git config --get remote.origin.url') do set "ORIG=%%u"
call :make_url "%ORIG%"

echo.
echo ==========================
echo Sincronización completa.
echo URL: %BROWSER_URL%
echo.

choice /m "Abrir en el navegador?"
if errorlevel 1 start "" "%BROWSER_URL%"

exit /b 0

:make_url
set "BROWSER_URL=%~1"
if not "%BROWSER_URL:~0,4%"=="git@" if not "%BROWSER_URL:~0,8%"=="https://" (
    if "%BROWSER_URL:~0,11%"=="github.com:" set "BROWSER_URL=https://%BROWSER_URL:github.com:/github.com/%"
)
if /i "%BROWSER_URL:~0,4%"=="git@" (
    set "BROWSER_URL=%BROWSER_URL:git@=%"
    for /f "delims=: tokens=1,2*" %%x in ("%BROWSER_URL%") do set "BROWSER_URL=%%x/%%y"
    set "BROWSER_URL=https://%BROWSER_URL%"
)
set "BROWSER_URL=%BROWSER_URL:.git=%"
goto :eof

:usage
echo Uso: %~nx0 [mensaje de commit]
echo   - cambia la ruta, rama y remoto dentro del fichero.
exit /b 0
