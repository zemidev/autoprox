#!/bin/bash

set -e

export GITHUB_SOURCE="v0.12.3"
export SCRIPT_RELEASE="v0.12.3"
export GITHUB_BASE_URL="https://raw.githubusercontent.com/pterodactyl-installer/pterodactyl-installer"

LOG_PATH="/var/log/pterodactyl-installer.log"

# check for curl
if ! [ -x "$(command -v curl)" ]; then
  echo "* curl is required in order for this script to work."
  echo "* install using apt (Debian and derivatives) or yum/dnf (CentOS)"
  exit 1
fi

# Always remove lib.sh, before downloading it
rm -rf /tmp/lib.sh
curl -sSL -o /tmp/lib.sh "$GITHUB_BASE_URL"/"$GITHUB_SOURCE"/lib/lib.sh
# shellcheck source=lib/lib.sh
source /tmp/lib.sh

execute_wings() {
  echo -e "\n\n* pterodactyl-installer $(date) \n\n" >>$LOG_PATH

  update_lib_source
  run_ui_wings |& tee -a $LOG_PATH
}

# Run Wings installation
execute_wings
