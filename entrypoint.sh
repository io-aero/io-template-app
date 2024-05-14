#!/bin/bash

# Activate the conda environment
source /opt/conda/etc/profile.d/conda.sh
conda activate iotemplateapp

# Execute the provided command
exec "$@"
