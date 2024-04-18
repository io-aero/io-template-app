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
from pathlib import Path

import tomli
from iocommon import file, io_glob, io_logger, io_utils

from iotemplateapp import glob_local, templateapp

# -----------------------------------------------------------------------------
# Global variables.
# -----------------------------------------------------------------------------

io_logger.initialise_logger()

_LOCALE = "en_US.UTF-8"


# -----------------------------------------------------------------------------
# Print the version number from pyproject.toml.
# -----------------------------------------------------------------------------
def _print_project_version() -> None:
    """Print the version number from pyproject.toml."""
    # Open the pyproject.toml file in read mode
    with Path("pyproject.toml").open("rb") as toml_file:
        # Use toml.load() to parse the file and store the data in a dictionary
        pyproject = tomli.load(toml_file)

    # Extract the version information
    # This method safely handles cases where the key might not exist
    version = pyproject.get("project", {}).get("version")

    # Check if the version is found and print it
    if version:
        logging.info("IO-TEMPLATE-APP version: %s", version)
    else:
        # If the version isn't found, print an appropriate message
        logging.fatal("IO-TEMPLATE-APP version not found in pyproject.toml")


# -----------------------------------------------------------------------------
# Initialising the logging functionality.
# -----------------------------------------------------------------------------
def main(argv: list[str]) -> None:
    """Entry point.

    The processes to be carried out are selected via command line arguments.

    Args:
    ----
        argv (list[str]): Command line arguments.

    """
    # Start time measurement.
    start_time = time.time_ns()

    # Provide progress messages.
    io_utils.progress_msg("=" * 79)
    # INFO.00.004 Start Launcher.
    io_utils.progress_msg(glob_local.INFO_00_004)

    logging.debug(io_glob.LOGGER_START)
    logging.info("param argv=%s", argv)

    logging.info("Start launcher.py")

    try:
        locale.setlocale(locale.LC_ALL, glob_local.LOCALE)
    except locale.Error:
        locale.setlocale(locale.LC_ALL, "en_US.UTF-8")

    logging.info("locale=%s", locale.getlocale())

    # Load the command line arguments.
    templateapp.get_args()

    # Perform the processing
    if templateapp.ARG_TASK == glob_local.ARG_TASK_VERSION:
        file.print_version_pkg_struct("iotemplateapp")
        file.print_pkg_structs(["iocommon"])
        _print_project_version()
    else:
        io_utils.terminate_fatal(
            # FATAL.00.926 The task '{task}' is invalid
            glob_local.FATAL_00_926.replace("{task}", templateapp.ARG_TASK),
        )

    io_utils.progress_msg("-" * 79)

    # Stop time measurement.
    io_utils.progress_msg_time_elapsed(
        time.time_ns() - start_time,
        "launcher",
    )

    # INFO.00.006 End   Launcher
    io_utils.progress_msg(glob_local.INFO_00_006)
    io_utils.progress_msg("=" * 79)

    logging.debug(io_glob.LOGGER_END)


# -----------------------------------------------------------------------------
# Program start.
# -----------------------------------------------------------------------------
if __name__ == "__main__":
    # not testable
    main(sys.argv)
