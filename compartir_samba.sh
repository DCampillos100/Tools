#!/bin/bash

# Definir la ruta de la carpeta a compartir
CARPETA_COMPARTIDA="/home/usuario/CarpetaCompartida"

# Definir el nombre del recurso compartido
NOMBRE_COMPARTIDO="MiCarpeta"

# Definir la descripción (opcional)
DESCRIPCION="Carpeta compartida a través de Samba"

# Verificar si la carpeta existe, si no, crearla
if [ ! -d "$CARPETA_COMPARTIDA" ]; then
    echo "Creando la carpeta $CARPETA_COMPARTIDA..."
    mkdir -p "$CARPETA_COMPARTIDA"
fi

# Establecer los permisos de la carpeta (acceso total para todos)
chmod 777 "$CARPETA_COMPARTIDA"
chown nobody:nogroup "$CARPETA_COMPARTIDA"

# Hacer una copia de seguridad del archivo de configuración de Samba
cp /etc/samba/smb.conf /etc/samba/smb.conf.backup

# Agregar el recurso compartido al archivo de configuración de Samba
echo -e "\n[$NOMBRE_COMPARTIDO]\n\
    path = $CARPETA_COMPARTIDA\n\
    available = yes\n\
    valid users = nobody\n\
    read only = no\n\
    browseable = yes\n\
    public = yes\n\
    writable = yes" >> /etc/samba/smb.conf

# Reiniciar el servicio de Samba para aplicar los cambios
echo "Reiniciando Samba..."
systemctl restart smbd

# Mostrar los recursos compartidos actuales
echo "Recursos compartidos actuales:"
smbclient -L localhost -U%

echo "¡La carpeta '$CARPETA_COMPARTIDA' está ahora compartida como '$NOMBRE_COMPARTIDO'!"
