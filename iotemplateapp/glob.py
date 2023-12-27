# Copyright (c) 2022-2023 IO-Aero. All rights reserved. Use of this
# source code is governed by the IO-Aero License, that can
# be found in the LICENSE.md file.

"""Global constants and variables."""

from iocommon import io_config

# -----------------------------------------------------------------------------
# Global variables.
# -----------------------------------------------------------------------------

ARG_TASK = "task"
ARG_TASK_CHOICE = ""
ARG_TASK_VERSION = "version"

CHECK_VALUE_TEST = io_config.settings.check_value == "test"

# Error messages.
# ERROR_00_999 = "ERROR.00.999 ...

# Fatal error messages.
FATAL_00_926 = "FATAL.00.926 The task '{task}' is invalid"

# Informational messages.
INFO_00_004 = "INFO.00.004 Start Launcher"
INFO_00_005 = "INFO.00.005 Argument '{task}'='{value_task}'"
INFO_00_006 = "INFO.00.006 End   Launcher"

INFORMATION_NOT_YET_AVAILABLE = "n/a"

# Library version number.
IO_TEMPLATE_APP_VERSION = "9.9.9"

LOCALE = "en_US.UTF-8"

# Warning messages.
# WARN_00_999 = "WARN.00.999 ...
