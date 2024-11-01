#!/bin/bash

set -e

# ------------------------------------------------------------------------------
#
# run_install_miniconda.sh: Install Miniconda on Ubuntu.
#
# ------------------------------------------------------------------------------

# Set the Python version
PYTHON_VERSION="3.13"

echo "=========================================================================="
echo "Downloading Miniconda installer."
echo "--------------------------------------------------------------------------"
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda-installer.sh

echo "=========================================================================="
echo "Installing Miniconda."
echo "--------------------------------------------------------------------------"
chmod +x ~/miniconda-installer.sh
sh ~/miniconda-installer.sh -b

echo "=========================================================================="
echo "Initializing Miniconda."
echo "--------------------------------------------------------------------------"
~/miniconda3/bin/conda init bash

echo "=========================================================================="
echo "Initializing Miniconda."
echo "--------------------------------------------------------------------------"
export PATH=~/miniconda3/bin:$PATH

echo "=========================================================================="
echo "Verifying Miniconda installation."
echo "--------------------------------------------------------------------------"
conda info

echo "=========================================================================="
echo "Install Python."
echo "--------------------------------------------------------------------------"
conda install -y python=${PYTHON_VERSION}
python3 --version

echo "--------------------------------------------------------------------------"
date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "--------------------------------------------------------------------------"
echo "End   $0"
echo "=========================================================================="
