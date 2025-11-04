@echo off

Title Copia de Seguridad de mis documentos importantes

echo =========================================
echo =                                       =
echo =         Copia de Seguridad            =
echo =                                       =
echo =========================================

for /f "tokens=1,2 delims=:" %%a in ('time /T') do (
    set "hora=%%a"
    set "minutos=%%b"
)

echo  Fecha: %date% Hora: %hora%:%minutos% 

echo  ===============================================================================  
echo                     Usuario: %username%  
echo ===============================================================================  
echo =       Seleccione la unidad donde desea hacer el backup      =
echo ===============================================================================

rem Mostrar unidades usando PowerShell porque wmic está descontinuado
powershell -Command "Get-CimInstance -ClassName Win32_LogicalDisk | Select-Object DeviceID,  VolumeName | Format-Table -AutoSize"

echo.
echo Escribe la ruta donde haras la copia de archivos. Recuerda usar los dos puntos (:)
set /p dest=

:retry
rem Realiza la copia de seguridad de OneDrive-Personal
echo Copia de OneDrive-Personal en "%dest%\OneDrive-Personal"
ROBOCOPY "%USERPROFILE%\OneDrive\Documentos" "%dest%\OneDrive-Personal" /S /MT /Z /R:0 /W:0

rem Realiza la copia de seguridad de PowerShell del Administrador
echo Copia de PowerShell del Administrador en "%dest%\COPIA_PS_ADMIN"
ROBOCOPY "C:\Users\root\Documents\WindowsPowerShell" "%dest%\COPIA_PS_ADMIN" /S /MT /Z /R:0 /W:0

rem Realiza la copia de seguridad de los hacks
echo Copias de los hacks en "%dest%\COPIA_HACKS"
ROBOCOPY "C:\Users\cipriano\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Hacks" "%dest%\COPIA_HACKS" /S /MT /Z /R:0 /W:0

rem Realiza la copia de seguridad de temas oh my posh
echo Copias de temas de oh my posh en "%dest%\TEMASOMYPOSH"
echo Los temas deben copiarse en "%LOCALAPPDATA%\Programs\oh-my-posh\themes"
ROBOCOPY "%LOCALAPPDATA%\Programs\oh-my-posh\themes" "%dest%\TEMASOMYPOSH" /S /MT /Z /R:0 /W:0

echo Copia realizada.
echo Se abrira "%dest%" para revisar las copias.
explorer "%dest%"
pause
exit /b 0

rem Manejo de Errores
:UnidadNoDisponible
cls
echo Hubo un error. ¿Deseas realizar otra copia en una ubicación diferente? (S/N)
set /p retry=

if /i "%retry%" equ "S" goto :retry
echo Saliendo...
pause
exit /b 1
