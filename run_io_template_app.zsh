#!/bin/zsh

set -e

# ------------------------------------------------------------------------------
#
# run_io_template_app.zsh: Process IO-TEMPLATE-APP tasks.
#
# ------------------------------------------------------------------------------

export ENV_FOR_DYNACONF=prod

export IO_AERO_TASK=
export IO_AERO_TASK_DEFAULT=version

export PYTHONPATH=.

# Prompt the user for a task if none is provided
if [[ -z "$1" ]]; then
    echo "==================================================================="
    echo "version - Show the IO-TEMPLATE-APP version"
    echo "-------------------------------------------------------------------"
    vared -p "Enter the desired task [default: ${IO_AERO_TASK_DEFAULT}] " -c IO_AERO_TASK
    export IO_AERO_TASK=${IO_AERO_TASK:-${IO_AERO_TASK_DEFAULT}}
else
    export IO_AERO_TASK=$1
fi

# Check if logging_io_aero.log exists and delete it
if [[ -f logging_io_aero.log ]]; then
    rm -f logging_io_aero.log
fi

# Display script and environment details
echo "======================================================================="
echo "Start $0"
echo "-----------------------------------------------------------------------"
echo "IO_TEMPLATE-APP - Template for Application Repositories."
echo "-----------------------------------------------------------------------"
echo "ENV_FOR_DYNACONF : ${ENV_FOR_DYNACONF}"
echo "PYTHONPATH       : ${PYTHONPATH}"
echo "-----------------------------------------------------------------------"
echo "TASK             : ${IO_AERO_TASK}"
echo "-----------------------------------------------------------------------"
echo "CURRENT DIRECTORY: ${PWD}"
echo "-----------------------------------------------------------------------"
ls -ll
echo "-----------------------------------------------------------------------"
date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "======================================================================="

# ---------------------------------------------------------------------------
# Task handling
# ---------------------------------------------------------------------------
case "${IO_AERO_TASK}" in
    "version")
        if ! python scripts/launcher.py -t "${IO_AERO_TASK}"; then
            echo "Error: Failed to execute task 'version'."
            exit 255
        fi
        ;;
    *)
        echo "Processing of the script run_io_template_app is aborted: unknown task='${IO_AERO_TASK}'"
        exit 255
        ;;
esac

# Final script end
echo "-----------------------------------------------------------------------"
date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "-----------------------------------------------------------------------"
echo "End   $0"
echo "======================================================================="
