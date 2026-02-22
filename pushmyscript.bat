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

REM Hacer commit solo si hay cambios
REM "git diff --quiet" devuelve 1 si hay diferencias

git diff --quiet --staged
IF ERRORLEVEL 1 (
    git commit -m "%MESSAGE%"
) ELSE (
    echo No hay cambios para commitear.
)

REM Push a la rama correcta (master en lugar de main)
git push -u origin master

echo.
echo ==========================
echo Sincronizacion completa.
REM obtener la URL remota y convertirla para abrir en navegador
for /f "delims=" %%u in ('git config --get remote.origin.url') do set ORIG=%%u
if defined ORIG (
    set "BROWSER_URL=%ORIG%"
    rem convierte SSH a https (solo el prefijo y el separador) y quita sufijo .git
    rem ejemplo: git@github.com:user/repo.git -> https://github.com/user/repo
    rem Si empieza con git@ o simplemente contiene github.com:...
    if /i "%BROWSER_URL:~0,4%"=="git@" (
        rem quitar 'git@'
        set "BROWSER_URL=%BROWSER_URL:git@=%"
        rem reemplazar primer ':' por '/'
        for /f "delims=: tokens=1,2*" %%x in ("%BROWSER_URL%") do set "BROWSER_URL=%%x/%%y"
        set "BROWSER_URL=https://%BROWSER_URL%"
    ) else if not "%BROWSER_URL:~0,8%"=="https://" if not "%BROWSER_URL:~0,7%"=="http://" if "%BROWSER_URL%" neq "" (
        rem si tiene host:repo.git sin prefijo, convertir también
        if /i "%BROWSER_URL:~0,11%"=="github.com:"
        (
            set "BROWSER_URL=%BROWSER_URL:github.com:/github.com/%"
            set "BROWSER_URL=https://%BROWSER_URL%"
        )
    )
    set "BROWSER_URL=%BROWSER_URL:.git=%"
    rem opcional: añadir rama actual si quieres navegarla
    rem for /f "delims=" %%b in ('git rev-parse --abbrev-ref HEAD') do set BRANCH=%%b
    rem set "BROWSER_URL=%BROWSER_URL%/tree/%BRANCH%"
    echo URL para abrir: %BROWSER_URL%
    echo.
    choice /m "Desea abrir la URL del repositorio para ver el cambio"
    if errorlevel 2 (
        goto :end
    )
    start "" "%BROWSER_URL%"
)

:end

pause
