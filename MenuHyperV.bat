@echo off
:MENU
color 05
cls
echo ================================================
echo     Menu para activar y desactivar Hyper-V
echo ================================================
echo Seleccione algunas de las siguientes opciones:
echo 1. Activar Hyper-V
echo 2. Desactivar Hyper-V
echo 3. Salir del menu
echo ================================================
set /p opcion=Seleccione alguna de las opciones:


if "%opcion%"=="1" goto ActivarHyperV
if "%opcion%"=="2" goto DesactivarHyperV
if "%opcion%"=="3" goto SalirMenu
goto MENU

:ActivarHyperV
color 04
echo ================================================
echo          Se esta activando Hyper-V
echo ================================================
bcdedit /set hypervisorlaunchtype auto
pause
goto MENU

:DesactivarHyperV
color 04
echo ================================================
echo        Se esta desactivando Hyper-V
echo ================================================
bcdedit /set hypervisorlaunchtype off
pause
goto MENU

:SalirMenu
exit