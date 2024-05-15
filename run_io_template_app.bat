@echo off

rem ----------------------------------------------------------------------------
rem
rem run_io_template_app.bat: Process IO-TEMPLATE-APP tasks.
rem
rem ----------------------------------------------------------------------------

setlocal EnableDelayedExpansion

set ERRORLEVEL=

if "%ENV_FOR_DYNACONF%"=="" (
    set "ENV_FOR_DYNACONF=prod"
)

set "IO_AERO_TASK="
set "IO_AERO_TASK_DEFAULT=version"

set "PYTHONPATH=."

if "%1"=="" (
    echo =======================================================================
    echo version - Show the IO-TEMPLATE-APP version
    echo -----------------------------------------------------------------------
    set /P "IO_AERO_TASK=Enter the desired task [default: %IO_AERO_TASK_DEFAULT%] "

    if "%IO_AERO_TASK%"=="" (
        set "IO_AERO_TASK=%IO_AERO_TASK_DEFAULT%"
    )
) else (
    set "IO_AERO_TASK=%1"
)

echo.
echo Script %0 is now running
echo.

rem Check if logging_io_aero.log exists and delete it
if exist logging_io_aero.log (
    del /f /q logging_io_aero.log
)

echo ========================================================================
echo Start %0
echo ------------------------------------------------------------------------
echo IO_TEMPLATE_APP - Template for Application Repositories.
echo ------------------------------------------------------------------------
echo ENV_FOR_DYNACONF : %ENV_FOR_DYNACONF%
echo PYTHONPATH       : %PYTHONPATH%
echo ------------------------------------------------------------------------
echo TASK             : %IO_AERO_TASK%
echo ------------------------------------------------------------------------
date /T & time /T
echo ========================================================================

rem ----------------------------------------------------------------------------
rem Task handling
rem ----------------------------------------------------------------------------
if "%IO_AERO_TASK%"=="version" (
    python scripts\launcher.py -t "%IO_AERO_TASK%"
    if ERRORLEVEL 1 (
        echo Error: Failed to execute task 'version'.
        exit /B 255
    )
) else (
    echo Processing of the script run_io_template_app is aborted: unknown task='%IO_AERO_TASK%'
    exit /B 255
)

echo ------------------------------------------------------------------------
date /T & time /T
echo ------------------------------------------------------------------------
echo End   %0
echo ========================================================================

:END_OF_SCRIPT
ENDLOCAL
exit /B
