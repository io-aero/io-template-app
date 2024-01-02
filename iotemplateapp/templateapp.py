# Copyright (c) 2022-2023 IO-Aero. All rights reserved. Use of this
# source code is governed by the IO-Aero License, that can
# be found in the LICENSE.md file.

"""IO-TEMPLATE-APP interface."""
from __future__ import annotations

import argparse
import logging

from iocommon import io_config
from iocommon import io_glob
from iocommon import io_logger
from iocommon import io_utils

from iotemplateapp import glob

# -----------------------------------------------------------------------------
# Global variables.
# -----------------------------------------------------------------------------

ARG_TASK = ""

logger = logging.getLogger(__name__)


# -----------------------------------------------------------------------------
# Check the command line argument: -t / --task.
# -----------------------------------------------------------------------------
def check_arg_task(args: argparse.Namespace) -> None:
    """Check the command line argument: -t / --task.

    Args:
        args (argparse.Namespace): Command line arguments.
    """
    global ARG_TASK  # pylint: disable=global-statement

    ARG_TASK = args.task.lower()

    if not (
        ARG_TASK
        in [
            glob.ARG_TASK_VERSION,
        ]
    ):
        terminate_fatal(
            "The specified task '"
            + ARG_TASK
            + "' is neither '"
            + glob.ARG_TASK_VERSION
            + f"': {args.task}",
        )


# -----------------------------------------------------------------------------
# Load the command line arguments into the memory.
# -----------------------------------------------------------------------------
def get_args() -> None:
    """Load the command line arguments into the memory."""
    logger.debug(io_glob.LOGGER_START)

    parser = argparse.ArgumentParser(
        description="Perform a IO-IO-XPA-DATA task",
        prog="launcher",
        prefix_chars="--",
        usage="%(prog)s options",
    )

    # -------------------------------------------------------------------------
    # Definition of the command line arguments.
    # ------------------------------------------------------------------------
    parser.add_argument(
        "-e",
        "--msexcel",
        help="the MS Excel file: '",
        metavar="msexcel",
        required=False,
        type=str,
    )

    parser.add_argument(
        "-t",
        "--task",
        help="the task to execute: '"
        + glob.ARG_TASK_VERSION
        + "' (Show the current version of IO-IO-XPA-DATA)",
        metavar="task",
        required=True,
        type=str,
    )

    # -------------------------------------------------------------------------
    # Load and check the command line arguments.
    # -------------------------------------------------------------------------
    parsed_args = parser.parse_args()

    check_arg_task(parsed_args)

    # --------------------------------------------------------------------------
    # Display the command line arguments.
    # --------------------------------------------------------------------------
    # INFO.00.005 Arguments {task}='{value_task}'
    progress_msg(
        glob.INFO_00_005.replace("{task}", glob.ARG_TASK).replace(
            "{value_task}", parsed_args.task
        ),
    )

    logger.debug(io_glob.LOGGER_END)


# -----------------------------------------------------------------------------
# Initialising the logging functionality.
# -----------------------------------------------------------------------------
def initialise_logger() -> None:
    """Initialise the root logging functionality."""
    io_logger.initialise_logger()


# ------------------------------------------------------------------
# Create a progress message.
# ------------------------------------------------------------------
def progress_msg(msg: str) -> None:
    """Create a progress message.

    Args:
        msg (str): Progress message

    """
    if io_config.settings.is_verbose:
        io_utils.progress_msg_core(msg)


# ------------------------------------------------------------------
# Create a progress message.
# ------------------------------------------------------------------
def progress_msg_time_elapsed(duration: int, event: str) -> None:
    """Create a time elapsed message.

    Args:
        duration (int): Time elapsed in ns.
        event (str): Event description.

    """
    io_utils.progress_msg_time_elapsed(duration, event)


# ------------------------------------------------------------------
# Terminate the application immediately.
# ------------------------------------------------------------------
def terminate_fatal(error_msg: str) -> None:
    """Terminate the application immediately.

    Args:
        error_msg (str): Error message

    """
    io_utils.terminate_fatal(error_msg)


# ------------------------------------------------------------------
# Returns the version number of the IO-XPA-DATA application.
# ------------------------------------------------------------------
def version() -> str:
    """Return the version number of the IO-XPA-DATA application.

    Returns:
        str:
            The version number of the IO-XPA-DATA application

    """
    return glob.IO_TEMPLATE_APP_VERSION
