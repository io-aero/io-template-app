# Copyright (c) 2022-2024 IO-Aero. All rights reserved. Use of this
# source code is governed by the IO-Aero License, that can
# be found in the LICENSE.md file.
"""Global constants and variables."""

from iocommon import io_logger, io_settings

# -----------------------------------------------------------------------------
# Global variables.
# -----------------------------------------------------------------------------

io_logger.initialise_logger()

# pylint: disable=line-too-long
ARG_TASK = "task"
"""str: A constant key used to reference the 'task' argument in function calls and command line arguments throughout the software."""  # noqa: E501

ARG_TASK_CHOICE = ""
"""str: Initially set to an empty string, this variable is intended to hold the user's choice of task once determined at runtime."""  # noqa: E501

ARG_TASK_VERSION = "version"
"""str: A constant key used to reference the 'version' argument for tasks, indicating the version of the task being used."""  # noqa: E501

CHECK_VALUE_TEST = io_settings.settings.check_value == "test"
"""bool: A boolean indicating whether the check value from io_settings is 'test'."""

# Error messages.
# ERROR_00_999 = "ERROR.00.999 ...

# Fatal error messages.
FATAL_00_926 = "FATAL.00.926 The task '{task}' is invalid"
"""str: Error message template indicating that the specified task is invalid."""

# Informational messages.
INFO_00_004 = "INFO.00.004 Start Launcher"
"""str: Information message indicating the start of the launcher."""

INFO_00_005 = "INFO.00.005 Argument '{task}'='{value_task}'"
"""str: Information message indicating the value of a specific argument in the launcher."""

INFO_00_006 = "INFO.00.006 End Launcher"
"""str: Information message indicating the end of the launcher."""

INFO_00_007 = "INFO.00.007 Section: '{section}' - Parameter: '{name}'='{value}'"
"""str: Information message indicating the value of a specific configuration parameter."""


INFORMATION_NOT_YET_AVAILABLE = "n/a"
"""str: Placeholder indicating that information is not yet available."""

# Library version number.
IO_TEMPLATE_APP_VERSION = "9.9.9"
"""str: The current version number of the IO-Aero template application."""

LOCALE = "en_US.UTF-8"
"""str: Default locale setting for the system to 'en_US.UTF-8', ensuring consistent language and regional format settings."""  # noqa: E501

# Warning messages.
# WARN_00_999 = "WARN.00.999 ...
