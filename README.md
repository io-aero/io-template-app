# IO-TEMPLATE-APP - Template for Application Repositories

This repository is a sample repository for developing Python related IO-Aero applications.

## Quickstart

This is a quick start guide.
Detailed instructions can be found in the [documentation](https://io-aero.github.io/io-template-app/) under Requirements, Installation and First Steps.

1. Run the following commands:

```
    sudo locale-gen en_US.UTF-8
    sudo update-locale LANG=en_US.UTF-8
```

2. Add the following entries to your `~/.bashrc` file:

```
    export LANG=C.UTF-8
    export LC_ALL=C.UTF-8
    export PYPI_PAT=<tbd>
```

3. Install Python 3.12
4. Install Conda or Miniconda
5. Install Docker Desktop
6. Clone this repository:

```
    git clone https://github.com/io-aero/io-template-app
```

7. Create the virtual environment:

```
    make conda-dev
```

8. Switch to the created virtual environment:

```
    conda activate iotemplateapp
```

9. Create a file named `.settings.io_aero.toml` which contains the database access data

10. Test the whole functionality:

```
    make final
```

11. All Makefile commands can be found by running:

```
    make 
```
 or 
```
    make help
```

```
========================================================================
Recommended Makefile Targets:
------------------------------------------------------------------------
action                    action: Run the GitHub Actions locally.
conda-dev                 Create a new environment for development.
conda-prod                Create a new environment for production.
dev                       dev: Format, lint and test the code.
docker                    Create a docker image.
docs                      docs: Create the user documentation.
everything                everything: Do everything pre-checkin
final                     final: Format, lint and test the code and create the documentation.
format                    format: Format the code with Black and docformatter.
lint                      lint: Lint the code with ruff, Bandit, Vulture, and Mypy.
mypy-stubgen              Autogenerate stub files.
pre-push                  pre-push: Preparatory work for the pushing process.
pytest-ci                 Run all tests with pytest after test tool installation.
pytest-first-issue        Run all tests with pytest until the first issue occurs.
pytest-ignore-mark        Run all tests without marker with pytest.
pytest-issue              Run only the tests with pytest which are marked with 'issue'.
pytest-module             Run test of a specific module with pytest.
tests                     tests: Run all tests with pytest.
version                   Show the installed software versions.
========================================================================
```

## Operation

The whole functionality of **IO-TEMPLATE-APP** can be used with the script `run_io_template_app`.
The script is available in a version for Ubuntu Bash and provides the following functionality:

    version - Show the IO-AVSTATS version

## Documentation

The complete documentation for this repository is contained in the GitHub pages [here](https://io-aero.github.io/io-template-app/). 
See that documentation for installation instructions

Further IO-Aero software documentation can be found under the following links.

- [IO-AIRPLANE-SIM - Airplane Simulator](https://io-aero.github.io/io-airplane-sim/)
- [IO-AVSTATS - Aviation Event Statistics](https://io-aero.github.io/io-avstats/) 
- [IO-AX4-DI - Flight Data Interface](https://github.com/IO-Aero-Projects-2024/io-ax4-di/) 
- [IO-DATA-SOURCES - Data Source Documentation](https://io-aero.github.io/io-data-sources/) 
- [IO-EVAA-MAP-CREATOR - A tool to create EVAA elevation maps](https://io-aero.github.io/io-evaa-map-creator/) 
- [IO-LANDINGSPOT - Landing spot identification](https://io-aero.github.io/io-landingspot/) 
- [IO-LIDAR - Lidar Map Processing](https://io-aero.github.io/io-lidar/) 
- [IO-LIDAR-DATA - Lidar Data Management](https://io-aero.github.io/io-lidar-data/)
- [IO-MAP-APPS - IO Map Applications](https://io-aero.github.io/io-map-apps/) 
- [IO-OLYMPUS - Raster Map Processing](https://io-aero.github.io/io-olympus/) 
- [IO-RESOURCES - All relevant books, articles, etc](https://github.com/io-aero/io-resources/) 
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
| scripts           | Scripts supporting Ubuntu Bash.                      |
| tests             | Scripts and data for examples and tests.             |

### 2. Files

| File                     | Functionality                                                         |
|--------------------------|-----------------------------------------------------------------------|
| .dockerignore            | Configuration of files and folders to be ignored.                     |
| .gitattributes           | Handling of the os-specific file properties.                          |
| .gitignore               | Configuration of files and folders to be ignored.                     |
| Dockerfile               | Configuration file to create a Docker image.                          |
| LICENSE.md               | Text of the licence terms.                                            |
| logging_cfg.yaml         | Configuration of the Logger functionality.                            |
| Makefile                 | Tasks to be executed with the make command.                           |
| pyproject.toml           | Optional configuration data for the software quality tools.           |
| README.md                | This file.                                                            |
| run_io_template_app      | Main script for using the functionality.                              |
| run_io_template_app_dev  | Main script for using the functionality in a development environment. |
| run_io_template_app_prod | Main script for using the functionality in a productive environment.  |
| run_io_template_app_test | Main script for using the functionality in a test environment.        |
| run_iotemplateapp        | Main script for using the functionality based on a Docker executable. |
| settings.io_aero.toml    | Configuration data.                                                   |
| setup.cfg                | Configuration data.                                                   |
