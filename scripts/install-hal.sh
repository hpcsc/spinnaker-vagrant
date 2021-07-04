#!/bin/bash

set -euo pipefail

if (command -v hal >/dev/null 2>&1) then
  echo "=== hal exists, skipping"
else
  echo "=== hal doesn't exist, installing"
  sudo apt install -y default-jre
  curl -O https://raw.githubusercontent.com/spinnaker/halyard/master/install/debian/InstallHalyard.sh
  sudo bash InstallHalyard.sh --user vagrant
  echo "hal version: $(hal -v)"
fi
