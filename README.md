# IO-TEMPLATE-APP - Template for Application Repositories

This repository is a sample repository for developing Python related IO-Aero applications.

## Documentation

The complete documentation for this repository is contained in the GitHub pages [here](https://io-aero.github.io/io-template-app/). 
See that documentation for installation instructions

Further IO-Aero software documentation can be found under the following links.

- [IO-AVSTATS - Aviation Event Statistics](https://io-aero.github.io/io-avstats/) 
- [IO-COMMON - Common Elements](https://io-aero.github.io/io-common/) 
- [IO-LIDAR - Lidar Map Processing](https://io-aero.github.io/io-lidar/) 
- [IO-LIDAR-DATA - Lidar Data Management](https://io-aero.github.io/io-lidar-data/)
- [IO-MAP-APPS - IO Map Applications](https://io-aero.github.io/io-map-apps/) 
- [IO-RASTER - Raster Map Processing](https://io-aero.github.io/io-raster/) 
- [IO-RISKMAP - Riskmap and Landing site processing](https://io-aero.github.io/io-riskmap/) 
- [IO-VECTOR - Vector Map Processing](https://io-aero.github.io/io-vector/) 
- [IO-XPA-CORE - IO-XPA Data Processing](https://io-aero.github.io/io-xpa-core/)
- [IO-XPA-SERVER - IO-XPA Server Processing](https://io-aero.github.io/io-xpa-server/)
<!-- - [IO-TEMPLATE-APP - Template for Application Repositories](https://io-aero.github.io/io-template-app/) -->
<!-- - [IO-TEMPLATE-LIB - Template for Library Repositories](https://io-aero.github.io/io-template-lib/) -->

## Directory and File Structure of this Repository

### 1. Directories

| Directory         | Content                                                  |
|-------------------|----------------------------------------------------------|
| .github/workflows | GitHub Action workflows.                                 |
| .vscode           | Visual Studio Code configuration files.                  |
| data              | Application data related files.                          |
| dist              | Dynamic link library version of **IO-TEMPLATE-APP**.     |
| docs              | Documentation files.                                     |
| examples          | Scripts for examples and special tests.                  |
| iotemplateapp     | Python script files.                                     |
| libs              | Contains libraries that are not used via pipenv.         |
| resources         | Selected manuals and software.                           |
| scripts           | Scripts supporting Ubuntu and Windows.                   |
| tests             | Scripts and data for examples and tests.                 |

### 2. Files

| File                            | Functionality                                                        |
|---------------------------------|----------------------------------------------------------------------|
| .act_secrets_template           | Template file for the configuration of ``make action``.              |
| .gitattributes                  | Handling of the os-specific file properties.                         |
| .gitignore                      | Configuration of files and folders to be ignored.                    |
| .pylintrc                       | pylint configuration file.                                           |
| .settings.io_aero_template.toml | Template file for the secret configuration data.                     |
| LICENSE.md                      | Text of the licence terms.                                           |
| logging_cfg.yaml                | Configuration of the Logger functionality.                           |
| Makefile                        | Tasks to be executed with the make command.                          |
| Pipfile                         | Definition of the Python package requirements.                       |
| pyproject.toml                  | Optional configuration data for the software quality tools.          |
| README.md                       | This file.                                                           |
| run_io_template_app             | Main script for using the functionality of **IO-TEMPLATE-APP**.      |
| run_io_template_app_pytest      | Main script for using the test functionality of **IO-TEMPLATE-APP**. |
| settings.io_aero.toml           | Configuration data.                                                  |
| setup.cfg                       | Configuration data for flake8.                                       |
