@echo off
chcp 65001 > nul
cls
::Todas las opciones para la gestion de los usuarios, utilizan el comando "Net User" para su funcionamiento
::Todas las opciones incluyen una estructura "IF" extra para preguntar si quieren realizar esa accion otra vez
::Todas las opciones salvo "SalirMenu" tiene una estructura "IF" para volver al Menu con un temporizador
::Menu de opciones
:Menu
cls
echo ===========================================
echo           Gestion de Usuarios
echo ===========================================
echo 1. Mostrar usuarios del sistema
echo 2. Mostrar el usuario actual
echo 3. Crear Usuario
echo 4. Eliminar Usuario
echo 5. Activar o desactivar un usuario
echo 6. Salir del menu
echo ===========================================
set /p opcion=Selecciona alguna de las opciones: 

::Estructura IF para ir a las diferentes opciones
if "%opcion%"=="1" goto Visualizar
if "%opcion%"=="2" goto Actual
if "%opcion%"=="3" goto Crear
if "%opcion%"=="4" goto Eliminar
if "%opcion%"=="5" goto ActivarDesactivar
if "%opcion%"=="6" goto SalirMenu
goto Menu

::Etiqueta "Crear" donde se desarrolla la opcion para crear usuario
:Crear
cls
set /p nombre=Elija un nombre: 
call :Verificar %nombre%
if "%existe%"=="si" (
echo El usuario "%nombre%" ya existe.
echo =======================================
echo Usted va a volver al menu en 5 segundos
echo =======================================
timeout /t 5 >nul
goto Menu
)
echo --------------------------------------
set /p contraseña=Elija una contraseña: 
echo --------------------------------------

echo ======================================
echo        Creando Usuario %nombre%
echo ======================================

net user %nombre% %contraseña% /add

set /p variable5=¿Desea crear otro usuario?(S/N): 
if /i "%variable5%"=="S" (
   goto Crear
) else (
   if /i "%variable5%"=="N" (
   echo =======================================
   echo Usted va a volver al menu en 5 segundos
   echo =======================================
   timeout /t 5 >nul
   goto Menu
) else (
   echo =======================================
   echo Usted ha elegido una opcion no valida.
   echo =======================================
   echo Usted va a volver al menu en 5 segundos
   echo =======================================
   timeout /t 5 >nul
   goto Menu
)
)

::Etiqueta "Visualizar" donde se desarrolla la opcion para visualizar todos los usuarios del sistema
:Visualizar
cls
echo ========================================================
echo A continuacion se van a mostrar los usuarios del sistema
echo ========================================================
timeout /t 3 >nul
net user
pause
echo =======================================
echo Usted va a volver al menu en 5 segundos
echo =======================================
timeout /t 5 >nul
goto Menu

::Etiqueta "Eliminar" donde se desarrolla la opcion para eliminar un usuario
:Eliminar
cls
echo ==================================================
set /p variable2=Ingrese el nombre del usuario que quiere eliminar: 
echo ==================================================
::En esta parte de la opcion, se verifica si el usuario existe o no existe, en caso de que no exista da un mensaje de error y vuelve al Menu
::Si el usuario si existe, continua con el script y elimina el usuario
net user | findstr /c:%variable2% > nul
if %errorlevel%==0 (
net user %variable2% /delete

echo =======================================
echo Usuario %variable2% ha sido eliminado
echo =======================================
) else (
   echo =================================
   echo El Usuario %variable2% no existe.
   echo =================================
   echo ---------------------------------
   echo =======================================
   echo Usted va a volver al menu en 5 segundos
   echo =======================================
   timeout /t 5 >nul
   goto Menu
)

set /p variable3=¿Desea eliminar algun otro usuario?(S/N): 

if /i "%variable3%"=="S" (
   goto Eliminar
) else (
   if /i "%variable3%"=="N" (
    echo =======================================
    echo Usted va a volver al menu en 5 segundos
    echo =======================================
    timeout /t 5 >nul
    goto Menu
   ) else (
         echo ======================================
         echo Usted ha elegido un opcion no valida.
         echo =======================================
         echo Usted va a volver al menu en 5 segundos
         echo =======================================
         timeout /t 5 >nul
         goto Menu
   )
)

::Etiqueta "Actual" donde se desarrolla la opcion para visualizar el usuario actual que esta utilizando el sistema
:Actual
cls
echo ==================
echo    %USERNAME%
echo ==================
timeout /t 5 >nul
echo =======================================
echo Usted va a volver al menu en 5 segundos
echo =======================================
timeout /t 5 >nul
goto Menu


::Etiqueta "ActivarDesactivar" donde se desarrolla la opcion para activar o desactivar un usuario en concreto
:ActivarDesactivar
cls
echo ==============================
set /p variable4=Ingrese el nombre de usuario: 
echo ==============================
net user %variable4% >nul 2>&1
if %errorlevel% neq 0 (
   echo =================================
   echo El Usuario %variable4% no existe.
   echo =================================
   echo ---------------------------------
   echo =================================
   echo Volviendo al menu en 5 segundos
   echo =================================
   timeout /t 5 >nul
   goto Menu
)
echo ------------------------------------------
echo ===============================================================
set /p variable5=Desea activarlo o desactivarlo(A=Activar/D=Desactivar): 
echo ===============================================================

if /i "%variable5%"=="A" (
   net user %variable4% /active:yes
   echo ======================================
   echo Se ha activado el usuario: %variable4%
   echo ======================================
) else (
   if /i "%variable5%"=="D" (
    net user %variable4% /active:no
    echo =========================================
    echo Se ha desactivado el usuario: %variable4%
    echo =========================================
   )
)

set /p variable6=¿Desea activar/desactivar otro usuario?(S/N): 
if /i "%variable6%"=="S" (
   goto ActivarDesactivar
) else (
   if /i "%variable6%"=="N" (
      echo ================================
      echo Volviendo al menu en 5 segundos.
      echo ================================
      timeout /t 5 >nul
      goto Menu
   ) else (
      echo ====================================
      echo Ha introducido una opcion no valida.
      echo ====================================
      echo ------------------------------------
      echo ====================================
      echo Volviendo al menu en 5 segundos.
      echo ====================================
      timeout /t 5 >nul
      goto Menu
   )
)

::Etiqueta "Verificar" donde se desarrolla la opcion para verificar los usuarios que se introduzcan en la etiqueta "Crear"
:Verificar
set existe=no
net user %1 >nul 2>&1
if "%errorlevel%"=="0" set existe=si
exit /b

::Etiqueta "SalirMenu" donde se desarrolla la opcion para salir del menu y de la CMD
:SalirMenu
exit
