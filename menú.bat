@echo off
title Menú de Mantenimiento con DISM y SFC
:menu
echo ==============================================
echo             Menú de Mantenimiento
echo ==============================================
echo 1. Verificar si hay corrupción en la imagen (DISM CheckHealth)
echo 2. Escanear en busca de daños en la imagen (DISM ScanHealth)
echo 3. Reparar la imagen del sistema (DISM RestoreHealth)
echo 4. Analizar el almacenamiento de componentes (DISM AnalyzeComponentStore)
echo 5. Limpiar el almacenamiento de componentes (DISM StartComponentCleanup)
echo 6. Verificar y reparar archivos de sistema (SFC Scannow)
echo 7. Salir
echo ==============================================
set /p choice=Elige una opción [1-7]: 

if "%choice%"=="1" goto checkhealth
if "%choice%"=="2" goto scanhealth
if "%choice%"=="3" goto restorehealth
if "%choice%"=="4" goto analyzecomponent
if "%choice%"=="5" goto cleanup
if "%choice%"=="6" goto sfcscan
if "%choice%"=="7" goto exit

:checkhealth
echo Ejecutando DISM CheckHealth...
DISM /online /cleanup-image /checkhealth
pause
goto menu

:scanhealth
echo Ejecutando DISM ScanHealth...
DISM /online /cleanup-image /scanhealth
pause
goto menu

:restorehealth
echo Ejecutando DISM RestoreHealth...
DISM /online /cleanup-image /restorehealth
pause
goto menu

:analyzecomponent
echo Ejecutando DISM AnalyzeComponentStore...
DISM /online /cleanup-image /AnalyzeComponentStore
pause
goto menu

:cleanup
echo Ejecutando DISM StartComponentCleanup...
DISM /online /cleanup-image /StartComponentCleanup
pause
goto menu

:sfcscan
echo Ejecutando SFC Scannow...
sfc /scannow
pause
goto menu

:exit
exit
