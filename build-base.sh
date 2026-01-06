#!/usr/bin/env bash

set -xeuo pipefail

rpm -qa | sort

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



