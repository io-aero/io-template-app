#!/bin/zsh

set -e

# ------------------------------------------------------------------------------
#
# run_install_docker.sh: Install Docker Engine on macOS.
#
# ------------------------------------------------------------------------------

echo "=========================================================================="
echo "Installing Docker Engine."
echo "--------------------------------------------------------------------------"

echo "=========================================================================="
echo "Updating Homebrew."
echo "--------------------------------------------------------------------------"
brew update

echo "=========================================================================="
echo "Installing Docker."
echo "--------------------------------------------------------------------------"
brew install --cask docker

echo "=========================================================================="
echo "Starting Docker."
echo "Please locate Docker.app in your /Applications folder and double-click it"
echo "to open Docker Desktop. This is the usual way to start Docker after installation."
echo "--------------------------------------------------------------------------"

echo "=========================================================================="
echo "Verifying Docker Engine installation."
echo "Please ensure Docker Desktop is running before executing this."
echo "--------------------------------------------------------------------------"
docker --version

echo "=========================================================================="
echo "Docker Engine is installed."
echo "--------------------------------------------------------------------------"

date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "--------------------------------------------------------------------------"
echo "End   $0"
echo "=========================================================================="