#!/bin/zsh

set -e

# ---------------------------------------------------------------------------
#
# run_io_template_app.zsh: Process IO-TEMPLATE-APP tasks.
#
# ---------------------------------------------------------------------------

# Set default values for environment variables
export PROCESSOR=
export PROCESSOR_DEFAULT=arm64

# Prompt the user for a task if none is provided
if [[ -z "$1" ]]; then
    echo "==================================================================="
    echo "amd64 - Intel-based Macs"
    echo "arm64 - Apple Silicon Macs M1, M2, M3, ..."
    echo "-------------------------------------------------------------------"
    vared -p "Enter the processor architecture [default: ${PROCESSOR_DEFAULT}] " -c PROCESSOR
    export PROCESSOR=${PROCESSOR:-${PROCESSOR_DEFAULT}}
else
    export PROCESSOR=$1
fi

echo "======================================================================="
echo "IO_TEMPLATE-APP - Template for Application Repositories."
echo "-----------------------------------------------------------------------"
echo "Processor architecture : ${PROCESSOR}"
echo "-----------------------------------------------------------------------"
echo "CURRENT DIRECTORY: ${PWD}"
echo "-----------------------------------------------------------------------"
ls -ll
echo "-----------------------------------------------------------------------"
date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "======================================================================="

./iotemplateapp-darwin-${PROCESSOR}

echo "-----------------------------------------------------------------------"
date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "-----------------------------------------------------------------------"
echo "End   $0"
echo "======================================================================="
