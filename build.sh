#!/bin/bash
set -xeuo pipefail

### Config files
# Terra
#curl -sS --create-dirs -o /etc/yum.repos.d/terra.repo https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo
# repo - tailscale
curl -sS --create-dirs -o /etc/yum.repos.d/_tailscale.repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo
# repo - morewaita icons
#curl -sS --create-dirs -o /etc/yum.repos.d/_morewaita.repo https://copr.fedorainfracloud.org/coprs/trixieua/morewaita-icon-theme/repo/fedora-$(rpm -E %fedora)/trixieua-morewaita-icon-theme-fedora-$(rpm -E %fedora).repo
# repo -ghostty
#curl -sS --create-dirs -o /etc/yum.repos.d/_ghostyy.repo https://copr.fedorainfracloud.org/coprs/scottames/ghostty/repo/fedora-$(rpm -E %fedora)/scottames-ghostty-fedora-$(rpm -E %fedora).repo
# repo - hyprland
curl -sS --create-dirs -o /etc/yum.repos.d/_hyprland.repo https://copr.fedorainfracloud.org/coprs/sdegler/hyprland/repo/fedora-$(rpm -E %fedora)/sdegler-hyprland-fedora-$(rpm -E %fedora).repo
# niri
#curl -sS --create-dirs -o /etc/yum.repos.d/_niri.repo https://copr.fedorainfracloud.org/coprs/yalter/niri/repo/fedora-$(rpm -E %fedora)/yalter-niri-fedora-$(rpm -E %fedora).repo
# DMS
#curl -sS --create-dirs -o /etc/yum.repos.d/_dms.repo https://copr.fedorainfracloud.org/coprs/avengemedia/dms/repo/fedora-$(rpm -E %fedora)/avengemedia-dms-fedora-$(rpm -E %fedora).repo
# repo - docker
#curl -sS --create-dirs -o /etc/yum.repos.d/_docker.repo https://download.docker.com/linux/fedora/docker-ce.repo
# justfile
#curl -sS --create-dirs -o /usr/share/just/justfile https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_share_just_justfile
# systemd - bootc
#curl -sS --create-dirs -o /usr/lib/systemd/system/bootc-update.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_bootc-update.service
#curl -sS --create-dirs -o /usr/lib/systemd/system/bootc-update.timer https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_bootc-update.timer
# systemd - flatpak
#curl -sS --create-dirs -o /usr/lib/systemd/system/flatpak-setup.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_flatpak-setup.service
#curl -sS --create-dirs -o /usr/lib/systemd/system/flatpak-update.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_flatpak-update.service
#curl -sS --create-dirs -o /usr/lib/systemd/system/flatpak-update.timer https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_flatpak-update.timer
#curl -sS --create-dirs -o /usr/lib/systemd/system/flatpak-packages.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_flatpak-packages.service
# containers
#curl -sS --create-dirs -o /usr/share/containers/systemd/jellyfin.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/jellyfin.container
#curl -sS --create-dirs -o /usr/share/containers/systemd/navidrome.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/navidrome.container
#curl -sS --create-dirs -o /usr/share/containers/systemd/audiobookshelf.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/audiobookshelf.container
#curl -sS --create-dirs -o /usr/share/containers/systemd/syncthing.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/syncthing.container
#curl -sS --create-dirs -o /usr/share/containers/systemd/stash.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/stash.container
#curl -sS --create-dirs -o /usr/share/containers/systemd/stirlingpdf.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/stirlingpdf.container
#curl -sS --create-dirs -o /usr/share/containers/systemd/qbittorent.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/qbittorent.container

#dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release


dnf install -y \
    ibm-plex* \
    adw-gtk3-theme \
    cockpit \
    cockpit-podman \

dnf install -y \
    hyprland hypridle hyprlock hyprpaper hyprutils hyprpolkitagent \
    kitty \
    pcmanfm \
    wofi \

systemctl enable cockpit.socket

rpm -qa | sort



dnf install -y \
    helium-browser-bin \

dnf install -y \
    tuned tuned-ppd \
    sddm \
    blueman \
    pavucontrol alsa-sof-firmware alsa-utils \
    iwl* nm-manager-editor-desktop NetworkManager-wifi \
    gvfs* \

rpm -qa 'qemu-user-static*' | xargs dnf remove -y

authselect enable-feature with-systemd-homed

systemctl enable sddm.service
systemctl set-default graphical.target

rm /usr/lib/systemd/system/default.target.wants/bootc-fetch-apply-updates.timer

cp -a --verbose /etc/systemd/system /etc/systemd/user /usr/lib/systemd/
rm -r /etc/systemd/system /etc/systemd/user

rm --verbose /etc/*-

