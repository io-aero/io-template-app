#!/bin/bash

set -e

# ------------------------------------------------------------------------------
#
# run_install_terraform.sh: Install Terraform on Ubuntu.
#
# ------------------------------------------------------------------------------

echo "=========================================================================="
echo "Downloading and installing Terraform."
echo "--------------------------------------------------------------------------"
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

echo "=========================================================================="
echo "Verifying Terraform installation."
echo "--------------------------------------------------------------------------"
terraform --version

echo "--------------------------------------------------------------------------"
date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "--------------------------------------------------------------------------"
echo "End   $0"
echo "=========================================================================="
