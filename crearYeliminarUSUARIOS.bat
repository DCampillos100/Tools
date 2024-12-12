@echo off
setlocal

:MENU
cls
echo ================================================
echo           GESTION DE USUARIOS DEL SISTEMA       
echo ================================================
echo 1. Mostrar todos los usuarios
echo 2. Mostrar el usuario actual
echo 3. Crear un usuario
echo 4. Borrar un usuario
echo 5. Activar o desactivar un usuario
echo 6. Salir
echo ================================================
set /p option="Selecciona una opcion (1-6): "

if "%option%"=="1" goto SHOW_USERS
if "%option%"=="2" goto SHOW_CURRENT_USER
if "%option%"=="3" goto CREATE_USER
if "%option%"=="4" goto DELETE_USER
if "%option%"=="5" goto TOGGLE_USER
if "%option%"=="6" goto END

:SHOW_USERS
echo.
echo Usuarios en el sistema:
net user
pause
goto MENU

:SHOW_CURRENT_USER
echo.
echo Usuario actual:
echo %username%
pause
goto MENU

:CREATE_USER
set /p newuser="Introduce el nombre del nuevo usuario: "
net user %newuser% /add
if %errorlevel% equ 0 (
    echo Usuario %newuser% creado exitosamente.
) else (
    echo Error al crear el usuario.
)
pause
goto MENU

:DELETE_USER
set /p deluser="Introduce el nombre del usuario a borrar: "
net user %deluser% /delete
if %errorlevel% equ 0 (
    echo Usuario %deluser% borrado exitosamente.
) else (
    echo Error al borrar el usuario.
)
pause
goto MENU

:TOGGLE_USER
set /p toguser="Introduce el nombre del usuario a activar/desactivar: "
net user %toguser% | find "Account active" >nul
if %errorlevel% equ 0 (
    net user %toguser% /active:no
    echo Usuario %toguser% desactivado.
) else (
    net user %toguser% /active:yes
    echo Usuario %toguser% activado.
)
pause
goto MENU

:END
echo Saliendo del programa...
endlocal
exit