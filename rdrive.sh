#!/bin/sh
# set -x

# AUTOSTART_DIR=/etc/xdg/autostart
AUTOSTART_DIR=~/.config/autostart
AUTOSTART_FILE=${AUTOSTART_DIR}/rclone_drive.desktop

config_gnome_autostart(){
  which $0 > /dev/null || echo "add $0 to your \$PATH"

  [ -d "${AUTOSTART_DIR}" ] || mkdir -p "${AUTOSTART_DIR}"
  [ -e "${AUTOSTART_FILE}" ] && return

echo \
"[Desktop Entry]
Name=Rclone Drive
GenericName=Rclone mount for online storage
Comment=Rclone mount for online storage
Exec=rdrive.sh
Terminal=false
Type=Application
X-GNOME-Autostart-enabled=true
" > "${AUTOSTART_FILE}"
}

rclone_mount(){
  REMOTE=${1}
  MOUNT=${2}
  
  [ -e "${MOUNT}" ] || mkdir -p "${MOUNT}"
  rclone mount \
    "${REMOTE}" "${MOUNT}" \
    --vfs-cache-mode full &
}

rclone_umount(){
  MOUNT=${1}
  fusermount -u "${MOUNT}"
}

rclone_mount_all(){
  rclone_mount onedrive: "${HOME}/Remotes/One Drive"
}

rclone_umount_all(){
  rclone_umount "${HOME}/Remotes/One Drive"
}

config_gnome_autostart
rclone_mount_all
# rclone_umount_all
