#!/usr/bin/env bash

set -xeuo pipefail



systemctl enable systemd-timesyncd
systemctl enable systemd-resolved.service

dnf -y install 'dnf5-command(config-manager)'

dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf config-manager setopt tailscale-stable.enabled=0
dnf -y install --enablerepo='tailscale-stable' tailscale

systemctl enable tailscaled

dnf -y remove \
  console-login-helper-messages \
  chrony \
  sssd* \
  qemu-user-static* \
  toolbox

dnf -y install greetd

# These were manually picked out from a Bluefin comparison with `rpm -qa --qf="%{NAME}\n" `
dnf -y install \
  -x PackageKit* \
  NetworkManager \
  NetworkManager-adsl \
  NetworkManager-bluetooth \
  NetworkManager-config-connectivity-fedora \
  NetworkManager-libnm \
  NetworkManager-openconnect \
  NetworkManager-openvpn \
  NetworkManager-strongswan \
  NetworkManager-ssh \
  NetworkManager-ssh-selinux \
  NetworkManager-vpnc \
  NetworkManager-wifi \
  NetworkManager-wwan \
  alsa-firmware \
  alsa-sof-firmware \
  alsa-tools-firmware \
  atheros-firmware \
  audispd-plugins \
  audit \
  brcmfmac-firmware \
  cifs-utils \
  cups \
  cups-pk-helper \
  dymo-cups-drivers \
  firewalld \
  fprintd \
  fprintd-pam \
  fuse \
  fuse-common \
  fwupd \
  gum \
  gvfs-archive \
  gvfs-mtp \
  gvfs-nfs \
  gvfs-smb \
  hplip \
  hyperv-daemons \
  ibus \
  ifuse \
  intel-audio-firmware \
  iwlegacy-firmware \
  iwlwifi-dvm-firmware \
  iwlwifi-mvm-firmware \
  jmtpfs \
  kernel-modules-extra \
  libcamera{,-{v4l2,gstreamer,tools}} \
  libimobiledevice \
  libimobiledevice-utils \
  libratbag-ratbagd \
  man-db \
  man-pages \
  mobile-broadband-provider-info \
  mt7xxx-firmware \
  nxpwireless-firmware \
  open-vm-tools \
  open-vm-tools-desktop \
  openconnect \
  pam_yubico \
  pcsc-lite \
  plymouth \
  plymouth-system-theme \
  printer-driver-brlaser \
  ptouch-driver \
  qemu-guest-agent \
  realtek-firmware \
  rsync \
  spice-vdagent \
  steam-devices \
  switcheroo-control \
  system-config-printer-libs \
  system-config-printer-udev \
  systemd-container \
  systemd-oomd-defaults \
  tiwilink-firmware \
  tuned \
  tuned-ppd \
  unzip \
  usb_modeswitch \
  uxplay \
  vpnc \
  whois \
  wireguard-tools \
  zram-generator-defaults

systemctl enable auditd
systemctl enable firewalld

systemctl enable greetd



### Config files
# Terra
#curl -sS --create-dirs -o /etc/yum.repos.d/terra.repo https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo
# repo - tailscale
#curl -sS --create-dirs -o /etc/yum.repos.d/_tailscale.repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo
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

dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

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

dnf install -y steam

dnf install -y terra-release-mesa

dnf install -y \
    helium-browser-bin \
    tailscale \

dnf install -y \
    tuned tuned-ppd \
    blueman \
    pavucontrol alsa-sof-firmware alsa-utils \
    iwl* nm-connection-editor-desktop NetworkManager-wifi \
    gvfs* \
    greetd \

#rpm -qa 'qemu-user-static*' | xargs dnf remove -y


systemctl --quiet enable tailscaled.service
systemctl --quiet enable sshd.service

#authselect enable-feature with-systemd-homed

#systemctl enable sddm.service
#systemctl set-default graphical.target

#rm /usr/lib/systemd/system/default.target.wants/bootc-fetch-apply-updates.timer

