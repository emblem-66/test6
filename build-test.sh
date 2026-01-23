#!/usr/bin/env bash

set -xeuo pipefail

echo "::group::****"
trap 'echo "::endgroup::"' EXIT

#
dnf install -y 'dnf5-command(config-manager)'
# Debloat
dnf remove -y qemu-user-static* sssd*
# Tailscale
dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf config-manager setopt tailscale-stable.enabled=0
dnf install -y --enablerepo='tailscale-stable' tailscale
systemctl enable tailscaled
systemctl enable sshd.service
# Just
dnf install -y just
# Niri & DMS
dnf copr enable -y yalter/niri
dnf copr enable -y avengemedia/dms
dnf copr enable -y avengemedia/danklinux
dnf install -y \
    niri \
    dms dms-greeter \
    danksearch dgop \
    material-symbols-fonts \
    adw-gtk3-theme
# Flatpak
dnf install -y flatpak
# Cockpit
dnf install -y cockpit
systemctl enable cockpit
# 
#systemctl enable auditd
#systemctl enable firewalld
