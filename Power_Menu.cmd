@echo off
TITLE Bienvenid@ %USERNAME% al menu de opciones de apagado
MODE con:cols=80 lines=40

:inicio
SET var=0
cls
echo -----------------------------------------------------------------------------
echo -			Bienvenido %USERNAME% 				    -
echo -----------------------------------------------------------------------------
echo -			 %DATE% ^| %TIME% 
echo -----------------------------------------------------------------------------
echo  1    Opcion 1  Su equipo se apagara
echo  2    Opcion 2  Su equipo entrara en hibernacion
echo  3    Opcion 3  Su equipo se reiniciara
echo  4    Opcion 4  Cerrara sesion
echo  5    Opcion 5  Bloquear sesion
echo  6    Salir
echo -----------------------------------------------------------------------------
echo.

SET /p var= ^> Seleccione una opcion [1-6]:

if "%var%"=="0" goto inicio
if "%var%"=="1" goto op1
if "%var%"=="2" goto op2
if "%var%"=="3" goto op3
if "%var%"=="4" goto op4
if "%var%"=="5" goto op5
if "%var%"=="6" goto salir

::Mensaje de error, validación cuando se selecciona una opción fuera de rango
echo. El numero "%var%" no es una opcion valida, por favor intente de nuevo.
echo.
pause
echo.
goto:inicio

:op1
    echo.
    echo. Has elegido la opcion No. 1
    echo. Su equipo se apagara
      gsudo SHUTDOWN /p
        color 08
    echo.
    pause
    goto:inicio

:op2
    echo.
    echo. Has elegido la opcion No. 2
    echo. Su equipo entrara en hibernacion 
        gsudo SHUTDOWN /h
        color 09
    echo.
    pause
    goto:inicio

:op3
    echo.
    echo. Has elegido la opcion No. 3
    echo. Su equipo se reiniciara
       gsudo SHUTDOWN /r
        color 0A
    echo.
    pause
    goto:inicio
  
:op4
    echo.
    echo. Has elegido la opcion No. 4
    echo. Cerrara sesion
        logoff
        color 0B
    echo.
    pause
    goto:inicio

:op5
    echo.
    echo. Has elegido la opcion No. 5
    echo. Bloquear sesion
        Rundll32.exe user32.dll,LockWorkStation
        color 0C
    echo.
    pause
    goto:inicio

:salir
    @cls&exit