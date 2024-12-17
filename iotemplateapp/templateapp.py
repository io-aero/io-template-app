# Copyright (c) 2022-2024 IO-Aero. All rights reserved. Use of this
# source code is governed by the IO-Aero License, that can
# be found in the LICENSE.md file.
"""IO-TEMPLATE-APP interface."""

from __future__ import annotations

import argparse
import logging

from iocommon import io_glob, io_settings, io_utils

from iotemplateapp import glob_local

# -----------------------------------------------------------------------------
# Global variables.
# -----------------------------------------------------------------------------

ARG_TASK = ""
"""str: Placeholder for the command line argument 'task'."""


# -----------------------------------------------------------------------------

def check_arg_task(args: argparse.Namespace) -> None:
    """Check the command line argument: -t / --task.

    This function checks whether the command line argument 'task' matches the
    predefined constant 'ARG_TASK_VERSION'. If not, the function terminates the
    application with a fatal error message.

    Parameters
        args : argparse.Namespace
            Command line arguments.

    Notes
    This function modifies the global variable 'ARG_TASK' if the command line
    argument 'task' is valid.

    """
    global ARG_TASK

    ARG_TASK = args.task.lower()

    if ARG_TASK not in [
        glob_local.ARG_TASK_VERSION,
    ]:
        terminate_fatal(
            "The specified task '"
            + ARG_TASK
            + "' is neither '"
            + glob_local.ARG_TASK_VERSION
            + f"': {args.task}",
        )


# -----------------------------------------------------------------------------

def get_args() -> None:
    """Load the command line arguments into the memory.

    The following command line arguments are recognized by the IO-TEMPLATE-APP
    application:

    -e, --msexcel <msexcel>  the MS Excel file: '

    -t, --task <task>       the task to execute: '

    The values of the command line arguments are loaded into the memory and
    checked.

    """
    logging.debug(io_glob.LOGGER_START)

    parser = argparse.ArgumentParser(
        description="Perform an IO-TEMPLATE-APP task",
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
        + glob_local.ARG_TASK_VERSION
        + "' (Show the current version of IO-TEMPLATE-APP)",
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
        glob_local.INFO_00_005.replace("{task}", glob_local.ARG_TASK).replace(
            "{value_task}",
            parsed_args.task,
        ),
    )

    logging.debug(io_glob.LOGGER_END)


# -----------------------------------------------------------------------------

def progress_msg(msg: str) -> None:
    """Create a progress message.

    If the verbosity level is set to true, the specified message is displayed as
    a progress message.

    Args:
        msg (str): Progress message.

    Notes:
    The verbosity level is set to true if the constant
    `io_settings.settings.is_verbose` is set to true.

    """
    if io_settings.settings.is_verbose:
        io_utils.progress_msg_core(msg)


# -----------------------------------------------------------------------------

def progress_msg_time_elapsed(duration: int, event: str) -> None:
    """Create a time elapsed message.

    Args:
        duration (int): Time elapsed in nanoseconds.
        event (str): Event description.

    Notes:
    The specified event description is used to create a time elapsed message.
    The specified time elapsed is used to calculate the time elapsed in seconds.
    The function displays the time elapsed message.

    """
    io_utils.progress_msg_time_elapsed(duration, event)


# -----------------------------------------------------------------------------

def terminate_fatal(error_msg: str) -> None:
    """Terminate the application immediately.

    If an application error occurs, the application is terminated immediately
    with an error message.

    Args:
        error_msg (str): Error message.

    Notes:
    The application is terminated by calling the function
    `io_utils.terminate_fatal()` with the specified error message.

    """
    io_utils.terminate_fatal(error_msg)


# -----------------------------------------------------------------------------

def version() -> str:
    """Return the version number of the IO-TEMPLATE-APP application.

    Returns
        str
            The version number of the IO-TEMPLATE-APP application.

    Notes
    The version number of the IO-TEMPLATE-APP application is stored in the
    module `iotemplateapp.glob_local` as the constant `IO_TEMPLATE_APP_VERSION`.

    """
    return glob_local.IO_TEMPLATE_APP_VERSION
