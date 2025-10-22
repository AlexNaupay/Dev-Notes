#!/bin/bash

set -e  # Salir si hay error

NGINX_ADMINS_GROUP="nginx-admins"
USERS_TO_CREATE=("usuario1" "usuario2")  # <-- ¡MODIFICA ESTA LISTA!

# Colores para salida
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
    exit 1
}

# Verificar que se ejecute como root
if [[ $EUID -ne 0 ]]; then
   error "Este script debe ejecutarse como root (usa sudo)."
fi

# Verificar rutas de comandos
SYSTEMCTL=$(which systemctl 2>/dev/null || echo "/bin/systemctl")
NGINX_BIN=$(which nginx 2>/dev/null || echo "/usr/sbin/nginx")
SUDOEDIT=$(which sudoedit 2>/dev/null || echo "/usr/bin/sudoedit")

# Validar que existan
command -v systemctl >/dev/null || error "systemctl no encontrado. ¿Es un sistema con systemd?"
command -v nginx >/dev/null || warn "nginx no está instalado (pero continuamos por si se instala después)."

# 1. Crear grupo
if ! getent group "$NGINX_ADMINS_GROUP" > /dev/null 2>&1; then
    log "Creando grupo: $NGINX_ADMINS_GROUP"
    groupadd "$NGINX_ADMINS_GROUP"
else
    log "El grupo $NGINX_ADMINS_GROUP ya existe."
fi

# 2. Crear usuarios y añadir al grupo
for user in "${USERS_TO_CREATE[@]}"; do
    if ! id "$user" &>/dev/null; then
        log "Creando usuario: $user"
        useradd -m -s /bin/bash "$user"
        # Opcional: establecer contraseña (comentado por defecto)
        # passwd "$user"
    else
        log "El usuario $user ya existe."
    fi
    usermod -aG "$NGINX_ADMINS_GROUP" "$user"
    log "Usuario $user añadido al grupo $NGINX_ADMINS_GROUP"
done

# 3. Crear archivo sudoers personalizado (mejor que editar /etc/sudoers directamente)
SUDOERS_FILE="/etc/sudoers.d/nginx-admins"

cat > "$SUDOERS_FILE" <<EOF
# Permisos para el grupo nginx-admins
# Generado por setup-nginx-admins.sh el $(date)

%$NGINX_ADMINS_GROUP ALL=(root) \
    $SYSTEMCTL start nginx, \
    $SYSTEMCTL stop nginx, \
    $SYSTEMCTL restart nginx, \
    $SYSTEMCTL reload nginx, \
    $SYSTEMCTL status nginx, \
    $NGINX_BIN -t, \
    $SUDOEDIT /etc/nginx/nginx.conf, \
    $SUDOEDIT /etc/nginx/sites-available/*, \
    $SUDOEDIT /etc/nginx/sites-enabled/*, \
    $SUDOEDIT /etc/nginx/conf.d/*
EOF

# Asegurar permisos correctos (sudoers requiere 0440)
chmod 0440 "$SUDOERS_FILE"
chown root:root "$SUDOERS_FILE"

# Validar sintaxis de sudoers (opcional pero recomendado)
if command -v visudo >/dev/null; then
    if visudo -cf "$SUDOERS_FILE"; then
        log "Archivo sudoers validado correctamente: $SUDOERS_FILE"
    else
        error "Error de sintaxis en $SUDOERS_FILE. Revisa manualmente."
    fi
else
    warn "visudo no disponible: no se verificó la sintaxis del archivo sudoers."
fi

log "✅ Configuración completada."
echo
echo "Usuarios creados/añadidos: ${USERS_TO_CREATE[*]}"
echo "Grupo: $NGINX_ADMINS_GROUP"
echo "Permisos: gestión de nginx (start, stop, restart, reload, test, edición segura)"
echo "Trazabilidad: todos los comandos quedan registrados en /var/log/auth.log"
echo
echo "Ejemplo de uso por parte de un usuario:"
echo "  sudo systemctl reload nginx"
echo "  sudo nginx -t"
echo "  sudoedit /etc/nginx/sites-available/misitio"