@echo off
REM Configura un recurso compartido de red mediante SMB

REM Carpeta que quieres compartir
set carpeta_a_compartir=C:\CarpetaCompartida

REM Nombre del recurso compartido
set nombre_compartido=MiCarpeta

REM Descripción opcional
set descripcion=Carpeta compartida a través de SMB

REM Crear la carpeta si no existe
if not exist "%carpeta_a_compartir%" (
    mkdir "%carpeta_a_compartir%"
    echo Carpeta creada: %carpeta_a_compartir%
)

REM Configurar el recurso compartido
net share %nombre_compartido%=%carpeta_a_compartir% /GRANT:todos,full /remark:"%descripcion%"

REM Mostrar los recursos compartidos actuales
echo Recursos compartidos actualmente:
net share

echo Proceso completado. Presione cualquier tecla para salir.
pause
