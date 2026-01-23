#!/usr/bin/env bash

set -xeuo pipefail

echo "::group::****"
trap 'echo "::endgroup::"' EXIT

#
dnf -y install 'dnf5-command(config-manager)'
# Tailscale
dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf config-manager setopt tailscale-stable.enabled=0
dnf -y install --enablerepo='tailscale-stable' tailscale
systemctl enable tailscaled
systemctl enable sshd.service
# Just
dnf install -y just
# Niri
dnf copr enable -y yalter/niri
dnf install -y niri niri-settings
# DMS
dnf copr enable -y avengemedia/dms
dnf copr enable -y avengemedia/danklinux
dnf install -y dms dms-greeter
dnf install -y danksearch dgop material-symbols-fonts
# Flatpak
dnf install -y flatpak 
