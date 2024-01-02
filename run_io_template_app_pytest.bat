@echo off

rem ----------------------------------------------------------------------------
rem
rem run_io_template_app.bat: Process IO-TEMPLATE-APP tasks.
rem
rem ----------------------------------------------------------------------------

setlocal EnableDelayedExpansion

set ERRORLEVEL=

if ["!ENV_FOR_DYNACONF!"] EQU [""] (
    set ENV_FOR_DYNACONF=test
)
set PYTHONPATH=.

echo.
echo Script %0 is now running

if exist logging_io_aero.log (
    del /f /q logging_io_aero.log
)

echo =======================================================================
echo Start %0
echo -----------------------------------------------------------------------
echo IO_TEMPLATE_APP - Template Application.
echo -----------------------------------------------------------------------
echo ENV_FOR_DYNACONF : %ENV_FOR_DYNACONF%
echo PYTHONPATH       : %PYTHONPATH%
echo -----------------------------------------------------------------------
echo:| TIME
echo =======================================================================

pipenv run python scripts\launcher.py
if ERRORLEVEL 1 (
    echo Processing of the script: %0 - step: 'python scripts\launcher.py was aborted
)

echo.
echo -----------------------------------------------------------------------
echo:| TIME
echo -----------------------------------------------------------------------
echo End   %0
echo =======================================================================