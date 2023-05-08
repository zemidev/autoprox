#!/bin/bash

# Initialize error count to 0
errors=0

# Install Proxmox VE, Postfix, and Open-iscsi
apt-get install -y proxmox-ve postfix open-iscsi || ((errors++))

# Remove old Linux kernel images
apt-get remove -y linux-image-amd64 'linux-image-5.10*' || ((errors++))

# Update Grub
update-grub || ((errors++))

# Remove os-prober
apt-get remove -y os-prober || ((errors++))

# Display completion message with error count
if [[ $errors -eq 0 ]]; then
  echo "Install complete with no errors."
else
  echo "Install complete with $errors errors."
fi
