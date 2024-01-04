# Copyright (c) 2022-2024 IO-Aero. All rights reserved. Use of this
# source code is governed by the IO-Aero License, that can
# be found in the LICENSE.md file.

"""Module iotemplateapp: Entry Point Functionality.

This is the entry point to the application IO-TEMPLATE-APP.
"""
import locale
import logging
import sys
import time

from iocommon import file
from iocommon import io_glob
from iocommon import io_logger
from iocommon import io_utils

from iotemplateapp import glob
from iotemplateapp import templateapp

# -----------------------------------------------------------------------------
# Global variables.
# -----------------------------------------------------------------------------
_LOCALE = "en_US.UTF-8"


# -----------------------------------------------------------------------------
# Initialising the logging functionality.
# -----------------------------------------------------------------------------
def main(argv: list[str]) -> None:
    """Entry point.

    The processes to be carried out are selected via command line arguments.
    Args:
        argv (list[str]): Command line arguments.

    """
    # Start time measurement.
    start_time = time.time_ns()

    # Provide progress messages.
    io_utils.progress_msg("=" * 79)
    # INFO.00.004 Start Launcher.
    io_utils.progress_msg(glob.INFO_00_004)

    # Initialise the logging functionality.
    io_logger.initialise_logger()

    logger = logging.getLogger(__name__)

    logger.debug(io_glob.LOGGER_START)
    logger.info("param argv=%s", argv)

    logger.info("Start launcher.py")

    try:
        locale.setlocale(locale.LC_ALL, glob.LOCALE)
    except locale.Error:
        locale.setlocale(locale.LC_ALL, "en_US.UTF-8")

    logger.info("locale=%s", locale.getlocale())

    # Load the command line arguments.
    templateapp.get_args()

    # Perform the processing
    if templateapp.ARG_TASK == glob.ARG_TASK_VERSION:
        # file.print_version_pkg_struct("iotemplateapp")
        file.print_pkg_structs(["iocommon"])
    else:
        io_utils.terminate_fatal(
            # FATAL.00.926 The task '{task}' is invalid
            glob.FATAL_00_926.replace("{task}", templateapp.ARG_TASK)
        )

    io_utils.progress_msg("-" * 79)

    # Stop time measurement.
    io_utils.progress_msg_time_elapsed(
        time.time_ns() - start_time,
        "launcher",
    )

    # INFO.00.006 End   Launcher
    io_utils.progress_msg(glob.INFO_00_006)
    io_utils.progress_msg("=" * 79)

    logger.debug(io_glob.LOGGER_END)


# -----------------------------------------------------------------------------
# Program start.
# -----------------------------------------------------------------------------
if __name__ == "__main__":
    # not testable
    main(sys.argv)
