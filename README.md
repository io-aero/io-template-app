# IO-TEMPLATE-APP - Template for Application Repositories

This repository is a sample repository for developing Python related IO-Aero applications.

## Documentation

The complete documentation for this repository is contained in the GitHub pages [here](https://io-aero.github.io/io-template-app/). 
See that documentation for installation instructions

Further IO-Aero software documentation can be found under the following links.

- [IO-AIRPLANE-SIM - Airplane Simulator](https://io-aero.github.io/io-airplane-sim/)
- [IO-AVSTATS - Aviation Event Statistics](https://io-aero.github.io/io-avstats/) 
- [IO-AX4-DI - Flight Data Interface](https://github.com/IO-Aero-Projects-2024/io-ax4-di/) 
- [IO-AX4-UI - Pilot Data Interface](https://github.com/io-swiss/io-ax4-ui/) 
- [IO-COMMON - Common Elements](https://io-aero.github.io/io-common/) 
- [IO-DATA-SOURCES - Data Source Documentation](https://io-aero.github.io/io-data-sources/) 
- [IO-EVAA-MAP-CREATOR - A tool to create EVAA elevation maps](https://io-aero.github.io/io-evaa-map-creator/) 
- [IO-LANDINGSPOT - Landing spot identification](https://io-aero.github.io/io-landingspot/) 
- [IO-LIDAR - Lidar Map Processing](https://io-aero.github.io/io-lidar/) 
- [IO-LIDAR-DATA - Lidar Data Management](https://io-aero.github.io/io-lidar-data/)
- [IO-MAP-APPS - IO Map Applications](https://io-aero.github.io/io-map-apps/) 
- [IO-RASTER - Raster Map Processing](https://io-aero.github.io/io-raster/) 
- [IO-RESOURCES - All relevant books, articles, etc](https://github.com/io-aero/io-resources/) 
- [IO-TEMPLATE-APP - Template for Application Repositories](https://io-aero.github.io/io-template-app/)
- [IO-TEMPLATE-LIB - Template for Library Repositories](https://io-aero.github.io/io-template-lib/)
- [IO-VECTOR - Vector Map Processing](https://io-aero.github.io/io-vector/) 
- [IO-XPA-CORE - IO-XPA Data Processing](https://io-aero.github.io/io-xpa-core/)
- [IO-XPI - X-Plane Interface](https://github.com/IO-Aero-Projects-2024/io-xpi/)

## Directory and File Structure of this Repository

### 1. Directories

| Directory         | Content                                              |
|-------------------|------------------------------------------------------|
| .github/workflows | GitHub Action workflows.                             |
| .vscode           | Visual Studio Code configuration files.              |
| config            | Configuration files.                                 |
| data              | Application data related files.                      |
| dist              | Dynamic link library version of **IO-TEMPLATE-APP**. |
| docs              | Documentation files.                                 |
| examples          | Scripts for examples and special tests.              |
| iotemplateapp     | Python script files.                                 |
| libs              | Contains libraries that are not used via pip.        |
| resources         | Selected manuals and software.                       |
| scripts           | Scripts supporting macOS, Ubuntu and Windows.        |
| tests             | Scripts and data for examples and tests.             |

### 2. Files

| File                            | Functionality                                                         |
|---------------------------------|-----------------------------------------------------------------------|
| .act_secrets_template           | Template file for the configuration of ``make action``.               |
| .dockerignore                   | Configuration of files and folders to be ignored.                     |
| .gitattributes                  | Handling of the os-specific file properties.                          |
| .gitignore                      | Configuration of files and folders to be ignored.                     |
| .pylintrc                       | pylint configuration file.                                            |
| .settings.io_aero_template.toml | Template file for the secret configuration data.                      |
| Dockerfile                      | Configuration file to create a Docker image.                          |
| environment.yaml                | Definition of the Python package requirements - productive version.   |
| environment_dev.yaml            | Definition of the Python package requirements - development version.  |
| LICENSE.md                      | Text of the licence terms.                                            |
| logging_cfg.yaml                | Configuration of the Logger functionality.                            |
| Makefile                        | Tasks to be executed with the make command.                           |
| pyproject.toml                  | Optional configuration data for the software quality tools.           |
| README.md                       | This file.                                                            |
| run_io_template_app_dev         | Main script for using the functionality in a development environment. |
| run_io_template_app_prod        | Main script for using the functionality in a productive environment.  |
| run_io_template_app_pytest      | Main script for using the functionality in a test environment.        |
| run_iotemplateapp               | Main script for using the functionality based on a Docker executable. |
| settings.io_aero.toml           | Configuration data.                                                   |
| setup.cfg                       | Configuration data.                                                   |

## Converting the application into an executable file

### 1. Common Characteristics

This section details characteristics of `docker2exe` when used to convert the `io-template-app` into an executable file. These features are crucial for understanding the overall approach and platform-specific considerations necessary for the conversion process.

- **Target Platforms**:
The tools support creating executables specifically for macOS, Ubuntu, or Windows. This allows for precise targeting based on deployment needs.

- **Platform-Specific Build**:
The process of creating an executable is required to be conducted on the operating system for which the executable is intended. This means building a Windows executable on a Windows machine, a macOS executable on a macOS machine, and so on.

- **Use of Makefile**:
`docker2exe` utilize the Makefile of `iotemplateapp` to facilitate the construction of executables. 

### 2. Using docker2exe

**a. The prerequisites are:**

- Go Programming Language: `docker2exe` is developed in Go, so Go must be installed on the system to either compile from source or run the pre-compiled binaries.
- Docker: Docker is required as `docker2exe` converts Docker images into executable files.

The executable files for `docker2exe` are downloaded from the [GitHub Releases page](https://github.com/rzane/docker2exe). Note that the executable for Windows has been renamed to `docker2exe-windows-amd64.exe` and is located in the `dist` directory of the application. Visit the [docker2exe tool page](https://github.com/rzane/docker2exe) for more details and to access the source code.

**b. Creating the Executable File**

- Run `make docker`

- The Docker image named `iotemplateapp` is first created.
 
- `docker2exe` is then used to convert the Docker image into an executable file.

- A directory is finally created containing all the files necessary for running the application. The name of this directory varies depending on the operating system and architecture:
    - **macOS**: `app-darwin-amd64` or `app-darwin-arm64`
    - **Ubuntu**: `app-linux-amd64`
    - **Windows**: `app-windows-amd64`

- The directory, in addition to the executable file (`iotemplateapp` or `iotemplateapp.exe`), includes the following components:
    - **data**: A directory for the application data.
    - **logging_cfg.yaml**: A configuration file for logging.
    - **run_io_templateapp.[bat|sh|zsh]**: A shell script to run the application.
    - **settings.io-aero.toml**: Configuration data for the `iotemplateapp`.

- The converted application requires Docker to be installed in order to run, ensuring that the application's environment is appropriately replicated.



=====
sudo locale-gen en_US.UTF-8
sudo update-locale LANG=en_US.UTF-8

export LC_ALL=C.UTF-8
export LANG=C.UTF-8

export PYPI_PAT=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

export LANG=C.UTF-8
export LC_ALL=C.UTF-8


