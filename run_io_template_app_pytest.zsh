#!/bin/zsh

set -e

# ------------------------------------------------------------------------------
#
# run_io_template_app_pytest.zsh: Process IO-TEMPLATE-APP tasks.
#
# ------------------------------------------------------------------------------

if [[ -z "${ENV_FOR_DYNACONF}" ]]; then
    export ENV_FOR_DYNACONF=test
fi

export PYTHONPATH=.

rm -f logging_io_aero.log

echo "================================================================================"
echo "Start $0"
echo "--------------------------------------------------------------------------------"
echo "IO_TEMPLATE_APP - Template Application."
echo "--------------------------------------------------------------------------------"
echo "ENV_FOR_DYNACONF : ${ENV_FOR_DYNACONF}"
echo "PYTHONPATH       : ${PYTHONPATH}"
echo "--------------------------------------------------------------------------------"
date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "================================================================================"

if ! ( pipenv run python scripts/launcher.py ); then
    exit 255
fi

echo "--------------------------------------------------------------------------------"
date +"DATE TIME : %d.%m.%Y %H:%M:%S"
echo "--------------------------------------------------------------------------------"
echo "End   $0"
echo "================================================================================"