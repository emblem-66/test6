#!/bin/bash
set -xeuo pipefail

dnf install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \

dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' \
    terra-release

dnf install -y helium-browser-bin

dnf install -y \
    ibm-plex* \
    adw-gtk3-theme \

dnf install -y \
    kitty \
    pcmanfm \
    wofi \

dnf remove -y \
    firefox* \

rpm -qa | sort
