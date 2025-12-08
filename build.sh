#!/bin/bash
set -xeuo pipefail

dnf install -y \
    ibm-plex* \
    adw-gtk3-theme \

dnf remove -y \
    google-droid-sans-fonts \

dnf remove -y \
    default-fonts \

rpm -qa | sort
