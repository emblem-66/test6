#!/bin/bash
set -xeuo pipefail

dnf install -y \
    ibm-plex* \

rpm -qa | sort
