# Tool Coverage by Ruff

## **Understanding Ruff**

**Ruff** is a fast and efficient Python linter written in Rust. It aims to provide comprehensive linting capabilities by integrating multiple linting functionalities into a single tool. Ruff can handle many tasks traditionally managed by separate tools, offering both speed and versatility.

### **Key Features of Ruff:**
- **Linting:** Detects syntax errors, code smells, and stylistic issues.
- **Import Sorting:** Manages and sorts imports, effectively replacing tools like `isort`.
- **Fixes:** Automatically fixes certain linting issues.
- **Performance:** Extremely fast, making it suitable for large codebases.

---

## **Tools You Can Remove When Using Ruff**

### **1. `isort`**
- **Purpose of `isort`:** Specifically sorts and organizes import statements in Python files.
- **Ruff's Replacement Capability:** Ruff includes built-in support for import sorting, effectively handling the tasks performed by `isort`.
- **Action:** **Remove `isort`** from your Makefile.

  ```makefile
  ## format:             Format the code with Black and docformatter.
  format: black docformatter
  ```

  *(Removed `isort` from the `format` target)*

### **2. `pylint` (Optional)**
- **Purpose of `pylint`:** A comprehensive linter that checks for errors, enforces a coding standard, and looks for code smells.
- **Ruff's Replacement Capability:** Ruff covers a substantial portion of `pylint`'s functionality with improved performance. However, `pylint` offers some advanced checks and reporting that Ruff may not cover entirely.
- **Decision:** 
  - **If Ruff Meets Your Needs:** **Remove `pylint`** for a simpler setup.
  - **If You Require Advanced Checks:** **Keep `pylint`** alongside Ruff.

  ```makefile
  ## lint:               Lint the code with ruff, Bandit, vulture, Pylint and Mypy.
  lint: ruff bandit vulture mypy
  ```

  *(Optionally remove `pylint` if not needed)*

### **3. `docformatter`**
- **Purpose of `docformatter`:** Formats docstrings to follow PEP 257 standards.
- **Ruff's Replacement Capability:** Ruff does **not** handle docstring formatting.
- **Action:** **Keep `docformatter`** in your Makefile.

### **4. `isort` Replacement Confirmed**
- As mentioned, Ruff replaces `isort`. No additional action needed beyond removal.

---

## **Tools to Retain When Using Ruff**

### **1. `bandit`**
- **Purpose:** Identifies common security issues in Python code.
- **Ruff's Capability:** Ruff does **not** focus on security analysis.
- **Action:** **Keep `bandit`** for security linting.

### **2. `vulture`**
- **Purpose:** Detects dead code in Python projects.
- **Ruff's Capability:** Ruff does **not** specialize in dead code detection.
- **Action:** **Keep `vulture`** for identifying unused code.

### **3. `black`**
- **Purpose:** A code formatter that enforces a consistent coding style.
- **Ruff's Capability:** While Ruff can fix some formatting issues, it does **not** fully replace `black`.
- **Action:** **Keep `black`** for comprehensive code formatting.

### **4. `mypy`**
- **Purpose:** Performs static type checking in Python.
- **Ruff's Capability:** Ruff does **not** perform type checking.
- **Action:** **Keep `mypy`** for type safety and static analysis.

### **5. `coveralls`**
- **Purpose:** Uploads coverage data to Coveralls.io for test coverage reporting.
- **Ruff's Capability:** Ruff does **not** handle test coverage.
- **Action:** **Keep `coveralls`** for coverage reporting.

### **6. `sphinx`**
- **Purpose:** Generates documentation from source code.
- **Ruff's Capability:** Ruff does **not** handle documentation generation.
- **Action:** **Keep `sphinx`** for creating and managing documentation.

### **7. `conda` Environments**
- **Purpose:** Manages project dependencies and environments.
- **Ruff's Capability:** Ruff does **not** manage environments.
- **Action:** **Keep `conda`** for environment management.

### **8. `docker`, `compileall`, `next-version`, etc.**
- **Purpose:** Various tasks like building Docker images, compiling Python scripts, and version management.
- **Ruff's Capability:** Ruff does **not** handle these tasks.
- **Action:** **Keep these tools** as needed for your project workflow.

---

## **Revised Makefile Example**

Based on the above analysis, here's how you can adjust your Makefile to remove unnecessary tools when using Ruff:

```makefile
.DEFAULT_GOAL := help

MODULE=iotemplateapp
PYTHONPATH=${MODULE} docs scripts tests

ARCH:=$(shell uname -m)
OS:=$(shell uname -s)

ifeq (${OS},Linux)
	DOCKER2EXE_DIR=linux-amd64
	DOCKER2EXE_SCRIPT=sh
	DOCKER2EXE_TARGET=linux/amd64
else ifeq (${OS},Darwin)
	DOCKER2EXE_SCRIPT=zsh
	ifeq ($(ARCH),arm64)
		DOCKER2EXE_DIR=darwin-arm64
		DOCKER2EXE_TARGET=darwin/arm64
	else ifeq ($(ARCH),x86_64)
		DOCKER2EXE_DIR=darwin-amd64
		DOCKER2EXE_TARGET=darwin/amd64
	endif
endif

export ENV_FOR_DYNACONF=test
export LANG=en_US.UTF-8

## =============================================================================
## make Script       The purpose of this Makefile is to support the whole
##                   software development process for an application. It
##                   contains also the necessary tools for the CI activities.
##                   -----------------------------------------------------------
##                   The available make commands are:
## -----------------------------------------------------------------------------
## help:               Show this help.
## -----------------------------------------------------------------------------
## action:             Run the GitHub Actions locally.
action: action-std
## dev:                Format, lint and test the code.
dev: format lint tests
## docs:               Check the API documentation, create and upload the user documentation.
docs: sphinx
## everything:         Do everything precheckin
everything: dev docs
## final:              Format, lint and test the code and create the documentation.
final: format lint docs tests
## format:             Format the code with Black.
format: black docformatter
## lint:               Lint the code with ruff, Bandit, vulture, and Mypy.
lint: ruff bandit vulture mypy
## pre-push:           Preparatory work for the pushing process.
pre-push: format lint tests next-version docs
## tests:              Run all tests with pytest.
tests: pytest
## -----------------------------------------------------------------------------

help:
	@sed -ne '/@sed/!s/## //p' ${MAKEFILE_LIST}

# Run the GitHub Actions locally.
# https://github.com/nektos/act
# Configuration files: .act_secrets & .act_vars
action-std:         ## Run the GitHub Actions locally: standard.
	@echo "Info **********  Start: action ***************************************"
	@echo "Copy your .aws/credentials to .aws_secrets"
	@echo "----------------------------------------------------------------------"
	act --version
	@echo "----------------------------------------------------------------------"
	act --quiet \
		--secret-file .act_secrets \
		--var IO_LOCAL='true' \
		--verbose \
		-P ubuntu-latest=catthehacker/ubuntu:act-latest \
		-W .github/workflows/github_pages.yml
	act --quiet \
		--secret-file .act_secrets \
		--var IO_LOCAL='true' \
		--verbose \
		-P ubuntu-latest=catthehacker/ubuntu:act-latest \
		-W .github/workflows/standard.yml
	@echo "Info **********  End:   action ***************************************"

# Bandit is a tool designed to find common security issues in Python code.
# https://github.com/PyCQA/bandit
# Configuration file: none
bandit:             ## Find common security issues with Bandit.
	@echo "Info **********  Start: Bandit ***************************************"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	bandit --version
	@echo "----------------------------------------------------------------------"
	bandit -c pyproject.toml -r ${PYTHONPATH}
	@echo "Info **********  End:   Bandit ***************************************"

# The Uncompromising Code Formatter
# https://github.com/psf/black
# Configuration file: pyproject.toml
black:              ## Format the code with Black.
	@echo "Info **********  Start: black ****************************************"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	black --version
	@echo "----------------------------------------------------------------------"
	black ${PYTHONPATH}
	@echo "Info **********  End:   black ****************************************"

# Byte-compile Python libraries
# https://docs.python.org/3/library/compileall.html
# Configuration file: none
compileall:         ## Byte-compile the Python libraries.
	@echo "Info **********  Start: Compile All Python Scripts *******************"
	python3 --version
	@echo "----------------------------------------------------------------------"
	python3 -m compileall
	@echo "Info **********  End:   Compile All Python Scripts *******************"

# Miniconda - Minimal installer for conda.
# https://docs.conda.io/en/latest/miniconda.html
# Configuration file: none
conda-dev:          ## Create a new environment for development.
	@echo "Info **********  Start: Miniconda create development environment *****"
	conda config --set always_yes true
	conda --version
	echo "PYPI_PAT=${PYPI_PAT}"
	@echo "----------------------------------------------------------------------"
	conda env remove -n ${MODULE} 2>/dev/null || echo "Environment '${MODULE}' does not exist."
	conda env create -f config/environment_dev.yml
	@echo "----------------------------------------------------------------------"
	conda info --envs
	conda list
	@echo "Info **********  End:   Miniconda create development environment *****"

conda-prod:         ## Create a new environment for production.
	@echo "Info **********  Start: Miniconda create production environment ******"
	conda config --set always_yes true
	conda --version
	@echo "----------------------------------------------------------------------"
	conda env remove -n ${MODULE} 2>/dev/null || echo "Environment '${MODULE}' does not exist."
	conda env create -f config/environment.yml
	@echo "----------------------------------------------------------------------"
	conda info --envs
	conda list
	@echo "Info **********  End:   Miniconda create production environment ******"

# Requires a public repository !!!
# Python interface to coveralls.io API
# https://github.com/TheKevJames/coveralls-python
# Configuration file: none
coveralls:          ## Run all the tests and upload the coverage data to coveralls.
	@echo "Info **********  Start: coveralls ************************************"
	pytest --cov=${MODULE} --cov-report=xml --random-order tests
	@echo "----------------------------------------------------------------------"
	coveralls --service=github
	@echo "Info **********  End:   coveralls ************************************"

# Formats docstrings to follow PEP 257
# https://github.com/PyCQA/docformatter
# Configuration file: pyproject.toml
docformatter:       ## Format the docstrings with docformatter.
	@echo "Info **********  Start: docformatter *********************************"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	docformatter --version
	@echo "----------------------------------------------------------------------"
	docformatter --in-place -r ${PYTHONPATH}
#	docformatter -r ${PYTHONPATH}
	@echo "Info **********  End:   docformatter *********************************"

# Creates Docker executables
# https://github.com/rzane/docker2exe
# Configuration files: .dockerignore & Dockerfile
docker:             ## Create a docker image.
	@echo "Info **********  Start: Docker ***************************************"
	@echo "OS               =${OS}"
	@echo "ARCH             =${ARCH}"
	@echo "DOCKER2EXE_DIR   =${DOCKER2EXE_DIR}"
	@echo "DOCKER2EXE_SCRIPT=${DOCKER2EXE_SCRIPT}"
	@echo "DOCKER2EXE_TARGET=${DOCKER2EXE_TARGET}"
	@echo "----------------------------------------------------------------------"
	docker ps -a
	@echo "----------------------------------------------------------------------"
	@sh -c 'docker ps -a | grep -q "${MODULE}" && docker rm --force ${MODULE} || echo "No existing container to remove."'
	@sh -c 'docker image ls | grep -q "${MODULE}" && docker rmi --force ${MODULE}:latest || echo "No existing image to remove."'
	docker system prune -a -f
	docker build --build-arg PYPI_PAT=${PYPI_PAT} -t ${MODULE} .
	@echo "----------------------------------------------------------------------"
	rm -rf app-${DOCKER2EXE_DIR}
	mkdir app-${DOCKER2EXE_DIR}
	chmod +x dist/docker2exe-${DOCKER2EXE_DIR}
	./dist/docker2exe-${DOCKER2EXE_DIR} --name ${MODULE} \
									    --image ${MODULE}:latest \
									    --embed \
									    -t ${DOCKER2EXE_TARGET} \
									    -v ./data:/app/data \
									    -v ./logging_cfg.yaml:/app/logging_cfg.yaml \
									    -v ./settings.io_aero.toml:/app/settings.io_aero.toml
	mkdir app-${DOCKER2EXE_DIR}/data
	mv dist/${MODULE}-${DOCKER2EXE_DIR} app-${DOCKER2EXE_DIR}/${MODULE}
	chmod +x app-${DOCKER2EXE_DIR}/${MODULE}
	cp logging_cfg.yaml                           app-${DOCKER2EXE_DIR}/
	cp run_iotemplateapp.${DOCKER2EXE_SCRIPT}     app-${DOCKER2EXE_DIR}/
	chmod +x app-${DOCKER2EXE_DIR}/*.${DOCKER2EXE_SCRIPT}
	cp settings.io_aero.toml                      app-${DOCKER2EXE_DIR}/
	@echo "Info **********  End:   Docker ***************************************"

# isort your imports, so you don't have to.
# https://github.com/PyCQA/isort
# Configuration file: pyproject.toml
# Removed `isort` as Ruff handles import sorting.

# Mypy: Static Typing for Python
# https://github.com/python/mypy
# Configuration file: pyproject.toml
mypy:               ## Find typing issues with Mypy.
	@echo "Info **********  Start: Mypy *****************************************"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	mypy --version
	@echo "----------------------------------------------------------------------"
	mypy ${PYTHONPATH}
	@echo "Info **********  End:   Mypy *****************************************"

mypy-stubgen:       ## Autogenerate stub files.
	@echo "Info **********  Start: Mypy *****************************************"
	@echo "MODULE=${MODULE}"
	@echo "----------------------------------------------------------------------"
	rm -rf out
	stubgen --package ${MODULE}
	cp -f out/${MODULE}/* ./${MODULE}/
	rm -rf out
	@echo "Info **********  End:   Mypy *****************************************"

next-version:       ## Increment the version number.
	@echo "Info **********  Start: next_version *********************************"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	python3 --version
	@echo "----------------------------------------------------------------------"
	python3 scripts/next_version.py
	@echo "Info **********  End:   next version *********************************"

# Pylint is a tool that checks for errors in Python code.
# https://github.com/PyCQA/pylint/
# Configuration file: .pylintrc
# Removed `pylint` if not needed; otherwise keep it.

# pytest: helps you write better programs.
# https://github.com/pytest-dev/pytest/
# Configuration file: pyproject.toml
pytest:             ## Run all tests with pytest.
	@echo "Info **********  Start: pytest ***************************************"
	@echo "CONDA     =${CONDA_PREFIX}"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	pytest --version
	@echo "----------------------------------------------------------------------"
	pytest --dead-fixtures tests
	pytest --cache-clear --cov=${MODULE} --cov-report term-missing:skip-covered --cov-report=lcov -v tests
	@echo "Info **********  End:   pytest ***************************************"

pytest-ci:          ## Run all tests with pytest after test tool installation.
	@echo "Info **********  Start: pytest ***************************************"
	@echo "CONDA     =${CONDA_PREFIX}"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	pip3 install pytest pytest-cov pytest-deadfixtures pytest-helpers-namespace pytest-random-order
	@echo "----------------------------------------------------------------------"
	pytest --version
	@echo "----------------------------------------------------------------------"
	pytest --dead-fixtures tests
	pytest --cache-clear --cov=${MODULE} --cov-report term-missing:skip-covered -v tests
	@echo "Info **********  End:   pytest ***************************************"

pytest-first-issue: ## Run all tests with pytest until the first issue occurs.
	@echo "Info **********  Start: pytest ***************************************"
	@echo "CONDA     =${CONDA_PREFIX}"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	pytest --version
	@echo "----------------------------------------------------------------------"
	pytest --cache-clear --cov=${MODULE} --cov-report term-missing:skip-covered -rP -v -x tests
	@echo "Info **********  End:   pytest ***************************************"

pytest-ignore-mark: ## Run all tests without marker with pytest."
	@echo "Info **********  Start: pytest ***************************************"
	@echo "CONDA     =${CONDA_PREFIX}"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	pytest --version
	@echo "----------------------------------------------------------------------"
	pytest --dead-fixtures -m "not no_ci" tests
	pytest --cache-clear --cov=${MODULE} --cov-report term-missing:skip-covered --cov-report=lcov -m "not no_ci" -v tests
	@echo Info **********  End:   pytest ***************************************

pytest-issue:       ## Run only the tests with pytest which are marked with 'issue'.
	@echo Info **********  Start: pytest ***************************************
	@echo CONDA     =${CONDA_PREFIX}
	@echo PYTHONPATH=${PYTHONPATH}
	@echo "----------------------------------------------------------------------"
	pytest --version
	@echo "----------------------------------------------------------------------"
	pytest --dead-fixtures tests
	pytest --cache-clear --capture=no --cov=${MODULE} --cov-report term-missing:skip-covered -m issue -rP -v -x tests
	@echo "Info **********  End:   pytest ***************************************"

pytest-module:      ## Run test of a specific module with pytest.
	@echo "Info **********  Start: pytest ***************************************"
	@echo "CONDA     =${CONDA_PREFIX}"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "TESTMODULE=tests/${TEST-MODULE}.py"
	@echo "----------------------------------------------------------------------"
	pytest --version
	@echo "----------------------------------------------------------------------"
	pytest --cache-clear --cov=${MODULE} --cov-report term-missing:skip-covered -v tests/${TEST-MODULE}.py
	@echo "Info **********  End:   pytest ***************************************"

# https://github.com/astral-sh/ruff
# Configuration file: pyproject.toml
ruff:               ## An extremely fast Python linter and code formatter.
	@echo "Info **********  Start: ruff *****************************************"
	ruff --version
	@echo "----------------------------------------------------------------------"
	ruff check --fix
	@echo "Info **********  End:   ruff *****************************************"

sphinx:             ## Create the user documentation with Sphinx.
	@echo "Info **********  Start: sphinx ***************************************"
	sphinx-apidoc --version
	sphinx-build --version
	@echo "----------------------------------------------------------------------"
	sudo rm -rf docs/build/*
	sphinx-apidoc -o docs/source ${MODULE}
	sphinx-build -M html docs/source docs/build
	sphinx-build -b rinoh docs/source docs/build/pdf
	@echo "Info **********  End:   sphinx ***************************************"

version:            ## Show the installed software versions.
	@echo "Info **********  Start: version **************************************"
	python3 --version
	pip3 --version
	@echo "Info **********  End:   version **************************************"

# Find dead Python code
# https://github.com/jendrikseipp/vulture
# Configuration file: pyproject.toml
vulture:            ## Find dead Python code.
	@echo "Info **********  Start: vulture **************************************"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	vulture --version
	@echo "----------------------------------------------------------------------"
	vulture ${PYTHONPATH}
	@echo "Info **********  End:   vulture **************************************"

## =============================================================================
```

### **Key Changes:**
1. **Removed `isort`:**
   - **Before:**
     ```makefile
     ## format:             Format the code with Black and docformatter.
     format: isort black docformatter
     ```
   - **After:**
     ```makefile
     ## format:             Format the code with Black.
     format: black docformatter
     ```
   - **Reason:** Ruff handles import sorting, making `isort` redundant.

2. **Optional Removal of `pylint`:**
   - **Before:**
     ```makefile
     lint: ruff bandit vulture pylint mypy
     ```
   - **After (if removing `pylint`):**
     ```makefile
     lint: ruff bandit vulture mypy
     ```
   - **Reason:** Ruff covers many linting tasks previously handled by `pylint`. However, evaluate if Ruff's linting suffices for your project's needs before removing `pylint`.

3. **Adjusted `format` Target:**
   - **Removed `isort` from the `format` target as Ruff handles import sorting.**

### **Other Considerations:**
- **`docformatter` is retained** because Ruff does not handle docstring formatting.
- **Security (`bandit`), dead code detection (`vulture`), type checking (`mypy`), and documentation (`sphinx`)** remain essential and should be kept.
- **`black` remains for comprehensive code formatting** that Ruff does not fully replace.

---

## **Final Recommendations**

1. **Evaluate Ruff’s Coverage:**
   - Before removing tools like `pylint`, ensure that Ruff's linting capabilities meet your project's requirements. Run Ruff extensively to verify that it catches all necessary issues.

2. **Maintain Essential Tools:**
   - **Security:** Keep `bandit` to ensure your code remains secure.
   - **Dead Code Detection:** Retain `vulture` to identify and remove unused code.
   - **Type Checking:** Continue using `mypy` for type safety.
   - **Documentation:** Keep `sphinx` and `docformatter` for maintaining and formatting documentation.

3. **Simplify Your Workflow:**
   - Removing redundant tools like `isort` can streamline your Makefile and reduce maintenance overhead.
   - Ensure that the remaining tools are well-integrated and complement each other to maintain code quality and consistency.

4. **Continuous Integration (CI):**
   - Update your CI pipelines to reflect the changes in the Makefile, ensuring that only the necessary tools are invoked during automated checks.

5. **Documentation and Team Alignment:**
   - Document the changes to the Makefile and inform your team to ensure everyone is aware of the new setup.
   - Provide guidelines on how to use Ruff alongside the retained tools for optimal code quality.
