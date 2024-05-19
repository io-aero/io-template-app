# IO-TEMPLATE-APP - Template for Application Repositories

This repository is a sample repository for developing Python related IO-Aero applications.

## Documentation

The complete documentation for this repository is contained in the GitHub pages [here](https://io-aero.github.io/io-template-app/). 
See that documentation for installation instructions

Further IO-Aero software documentation can be found under the following links.

- [IO-AIRPLANE-SIM - Airplane Simulator](https://io-aero.github.io/io-airplane-sim/)
- [IO-AVSTATS - Aviation Event Statistics](https://io-aero.github.io/io-avstats/) 
- [IO-COMMON - Common Elements](https://io-aero.github.io/io-common/) 
- [IO-LANDINGSPOT - Landing spot identification](https://io-aero.github.io/io-landingspot/) 
- [IO-LIDAR - Lidar Map Processing](https://io-aero.github.io/io-lidar/) 
- [IO-LIDAR-DATA - Lidar Data Management](https://io-aero.github.io/io-lidar-data/)
- [IO-MAP-APPS - IO Map Applications](https://io-aero.github.io/io-map-apps/) 
- [IO-RASTER - Raster Map Processing](https://io-aero.github.io/io-raster/) 
- [IO-VECTOR - Vector Map Processing](https://io-aero.github.io/io-vector/) 
- [IO-XPA-CORE - IO-XPA Data Processing](https://io-swiss.github.io/io-xpa-core/)
<!-- - [IO-TEMPLATE-APP - Template for Application Repositories](https://io-aero.github.io/io-template-app/) -->
<!-- - [IO-TEMPLATE-LIB - Template for Library Repositories](https://io-aero.github.io/io-template-lib/) -->

## Directory and File Structure of this Repository

### 1. Directories

| Directory         | Content                                              |
|-------------------|------------------------------------------------------|
| .github/workflows | GitHub Action workflows.                             |
| .vscode           | Visual Studio Code configuration files.              |
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

| File                            | Functionality                                                           |
|---------------------------------|-------------------------------------------------------------------------|
| .act_secrets_template           | Template file for the configuration of ``make action``.                 |
| .dockerignore                   | Configuration of files and folders to be ignored.                       |
| .gitattributes                  | Handling of the os-specific file properties.                            |
| .gitignore                      | Configuration of files and folders to be ignored.                       |
| .pylintrc                       | pylint configuration file.                                              |
| .settings.io_aero_template.toml | Template file for the secret configuration data.                        |
| Dockerfile                      | Configuration file to create a Docker image.                            |
| environment.yaml                | Definition of the Python package requirements - productive version.     |
| environment_dev.yaml            | Definition of the Python package requirements - development version.    |
| LICENSE.md                      | Text of the licence terms.                                              |
| logging_cfg.yaml                | Configuration of the Logger functionality.                              |
| Makefile                        | Tasks to be executed with the make command.                             |
| pyproject.toml                  | Optional configuration data for the software quality tools.             |
| README.md                       | This file.                                                              |
| run_io_template_app             | Main script for using the functionality based on a Nuitka executable.   |
| run_io_template_app_prod        | Main script for using the functionality in the development environment. |
| run_io_template_app_pytest      | Main script for using the functionality in the test environment.        |
| run_iotemplateapp               | Main script for using the functionality based on a Docker executable.   |
| settings.io_aero.toml           | Configuration data.                                                     |
| setup.cfg                       | Configuration data.                                                     |

    ./iotemplateapp

	docker exec -it iotemplateapp bash -c "source /opt/conda/etc/profile.d/conda.sh && conda activate iotemplateapp && ./run_io_template_app.sh"


	docker run -d --name ${MODULE} \
			   -v $(CURRENT_DIR)/data:/app/data \
			   -v $(CURRENT_DIR)/logging_cfg.yaml:/app/logging_cfg.yaml \
			   -v $(CURRENT_DIR)/settings.io_aero.toml:/app/settings.io_aero.toml \
			   ${MODULE} tail -f /dev/null


docker run -d --name iotemplateapp -v %cd%\data:/app/data -v %cd%\logging_cfg.yaml:/app/logging_cfg.yaml -v %cd%\settings.io_aero.toml:/app/settings.io_aero.toml iotemplateapp

