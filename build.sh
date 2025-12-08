#!/bin/bash
set -xeuo pipefail

dnf install -y \
    ibm-plex* \
    adw-gtk3-theme \

rpm -qa | sort
