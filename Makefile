# =============================================================================
# make Script       The purpose of this Makefile is to support the whole
#                   software development process for an application. It
#                   contains also the necessary tools for the CI activities.
# =============================================================================

.DEFAULT_GOAL := help

.PHONY: action \
        conda-dev \
        conda-prod \
        dev \
        docker \
        docs \
        everything \
        final \
        format \
        lint \
        mypy-stubgen \
        pre-push \
        pytest-ci \
        pytest-first-issue \
        pytest-ignore-mark \
        pytest-issue \
        pytest-module \
        tests \
        version

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

# =============================================================================
# Helper Functions
# =============================================================================

define CHECK_TOOL
	@command -v $(1) >/dev/null 2>&1 || { echo >&2 "$(1) is required but not installed. Aborting."; exit 1; }
endef

# =============================================================================
# Makefile Targets
# =============================================================================

## Show this help.
help:
	@echo "========================================================================"
	@echo "Recommended Makefile Targets:"
	@echo "------------------------------------------------------------------------"
	@awk 'BEGIN { ESC = sprintf("%c", 27); } /^[a-zA-Z0-9_-]+:.*?## .*$$/ { \
		target = $$1; \
		gsub(/:/, "", target); \
		desc = substr($$0, index($$0, "## ") + 3); \
		# Assign color based on target, default to cyan \
		if (target == "dev" || target == "docs" || target == "everything" || target == "final" || target == "format" || target == "lint" || target == "pre-push" || target == "tests") { \
			color = ESC "[31m"; # Red \
		} else { \
			color = ESC "[36m"; # Cyan \
		} \
		printf "  %s%-25s%s %s\n", color, target, ESC "[0m", desc; \
	}' $(MAKEFILE_LIST)

## Ensure all required tools are installed.
check-tools:
	$(call CHECK_TOOL,bandit)
	$(call CHECK_TOOL,black)
	$(call CHECK_TOOL,coveralls)
	$(call CHECK_TOOL,docformatter)
	$(call CHECK_TOOL,docker)
	$(call CHECK_TOOL,mypy)
	$(call CHECK_TOOL,pylint)
	$(call CHECK_TOOL,pytest)
	$(call CHECK_TOOL,ruff)
	$(call CHECK_TOOL,sphinx-apidoc)
	$(call CHECK_TOOL,sphinx-build)
	$(call CHECK_TOOL,stubgen)
	$(call CHECK_TOOL,vulture)

## Clean build artifacts and temporary files.
clean:
	@echo "Info **********  Start: Clean ***************************************"
	rm -rf docs/build
	rm -rf *.pyc __pycache__
	rm -rf dist
	rm -rf app-*
	@echo "Info **********  End:   Clean ***************************************"

# =============================================================================
# Tool Targets
# =============================================================================

action: ## action: Run the GitHub Actions locally.
action: action-std

## Run the GitHub Actions locally: standard.
action-std:
	@echo "Info **********  Start: action ***************************************"
	@echo "Copy your .aws/credentials to .aws_secrets"
	@echo "----------------------------------------------------------------------"
	bin/act.exe --version
	@echo "----------------------------------------------------------------------"
	bin/act.exe --quiet \
				--secret-file .act_secrets \
				--var IO_LOCAL='true' \
				-P ubuntu-latest=catthehacker/ubuntu:act-latest \
				-W .github/workflows/github_pages.yml
	bin/act.exe --quiet \
				--secret-file .act_secrets \
				--var IO_LOCAL='true' \
				-P ubuntu-latest=catthehacker/ubuntu:act-latest \
				-W .github/workflows/standard.yml
	@echo "Info **********  End:   action ***************************************"

## Find common security issues with Bandit.
bandit:
	@echo "Info **********  Start: Bandit ***************************************"
	bandit --version
	@echo "----------------------------------------------------------------------"
	bandit -c pyproject.toml -r ${PYTHONPATH} --severity-level high --severity-level medium
	@echo "Info **********  End:   Bandit ***************************************"

## Format the code with Black.
black:
	@echo "Info **********  Start: black ****************************************"
	black --version
	@echo "----------------------------------------------------------------------"
	black ${PYTHONPATH}
	@echo "Info **********  End:   black ****************************************"

## Byte-compile the Python libraries.
compileall:
	@echo "Info **********  Start: Compile All Python Scripts *******************"
	python3 --version
	@echo "----------------------------------------------------------------------"
	python3 -m compileall ${PYTHONPATH}
	@echo "Info **********  End:   Compile All Python Scripts *******************"

conda-dev: ## Create a new environment for development.
	@echo "Info **********  Start: Miniconda create development environment *****"
	conda config --set always_yes true
	conda --version
	@echo "----------------------------------------------------------------------"
	conda env remove -n ${MODULE} >/dev/null 2>&1 || echo "Environment '${MODULE}' does not exist."
	conda env create -f config/environment_dev.yml
	@echo "----------------------------------------------------------------------"
	conda info --envs
	conda list
	@echo "Info **********  End:   Miniconda create development environment *****"

conda-prod: ## Create a new environment for production.
	@echo "Info **********  Start: Miniconda create production environment ******"
	conda config --set always_yes true
	conda --version
	@echo "----------------------------------------------------------------------"
	conda env remove -n ${MODULE} >/dev/null 2>&1 || echo "Environment '${MODULE}' does not exist."
	conda env create -f config/environment.yml
	@echo "----------------------------------------------------------------------"
	conda info --envs
	conda list
	@echo "Info **********  End:   Miniconda create production environment ******"

## Run all the tests and upload the coverage data to coveralls.
coveralls:
	@echo "Info **********  Start: coveralls ************************************"
	pytest --cov=${MODULE} --cov-report=xml --random-order tests
	@echo "----------------------------------------------------------------------"
	coveralls --service=github
	@echo "Info **********  End:   coveralls ************************************"

dev: ## dev: Format, lint and test the code.
dev: check-tools format lint tests

## Format the docstrings with docformatter.
docformatter:
	@echo "Info **********  Start: docformatter *********************************"
	docformatter --version
	@echo "----------------------------------------------------------------------"
	docformatter --in-place --recursive ${PYTHONPATH}
#	docformatter -r ${PYTHONPATH}
	@echo "Info **********  End:   docformatter *********************************"

# Docker: Create docker image.
docker: docker-clean docker-build docker-executable ## Create a docker image.

docker-clean:
	@echo "Info **********  Start: Docker Clean ***********************************"
	@command -v docker >/dev/null 2>&1 || { echo >&2 "Docker is required but not installed. Aborting."; exit 1; }
	docker ps -a | grep -q "${MODULE}" && docker rm --force ${MODULE} || echo "No existing container to remove."
	docker image ls | grep -q "${MODULE}" && docker rmi --force ${MODULE}:latest || echo "No existing image to remove."
	docker system prune -a -f
	@echo "Info **********  End:   Docker Clean ***********************************"

docker-build:
	@echo "Info **********  Start: Docker Build ***********************************"
	docker build --build-arg PYPI_PAT=${PYPI_PAT} -t ${MODULE} .
	@echo "Info **********  End:   Docker Build ***********************************"

docker-executable:
	@echo "Info **********  Start: Docker Executable ******************************"
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
	@echo "Info **********  End:   Docker Executable ******************************"

docs: ## docs: Create the user documentation.
docs: sphinx

everything: ## everything: Do everything pre-checkin
everything: check-tools dev docs

final: ## final: Format, lint and test the code and create the documentation.
final: check-tools format lint docs tests

format: ## format: Format the code with Black and docformatter.
format: black docformatter

lint: ## lint: Lint the code with ruff, Bandit, Vulture, Pylint and Mypy.
lint: ruff bandit vulture pylint mypy

## Find typing issues with Mypy.
mypy:
	@echo "Info **********  Start: Mypy *****************************************"
	mypy --version
	@echo "----------------------------------------------------------------------"
	mypy --ignore-missing-imports ${PYTHONPATH}
	@echo "Info **********  End:   Mypy *****************************************"

mypy-stubgen: ## Autogenerate stub files.
	@echo "Info **********  Start: Mypy Stubgen **********************************"
	rm -rf out
	stubgen --package ${MODULE}
	cp -f out/${MODULE}/* ./${MODULE}/
	rm -rf out
	@echo "Info **********  End:   Mypy Stubgen **********************************"

## Increment the version number.
next-version:
	@echo "Info **********  Start: next_version *********************************"
	@echo "PYTHONPATH=${PYTHONPATH}"
	@echo "----------------------------------------------------------------------"
	python3 --version
	@echo "----------------------------------------------------------------------"
	python3 scripts/next_version.py
	@echo "Info **********  End:   next version *********************************"

pre-push: ## pre-push: Preparatory work for the pushing process.
pre-push: check-tools format lint tests next-version docs

## Lint the code with Pylint.
pylint:
	@echo "Info **********  Start: Pylint ***************************************"
	pylint --version
	@echo "----------------------------------------------------------------------"
	pylint --rcfile=.pylintrc ${PYTHONPATH}
	@echo "Info **********  End:   Pylint ***************************************"

## Run all tests with pytest.
pytest:
	@echo "Info **********  Start: pytest ***************************************"
	pytest --version
	@echo "----------------------------------------------------------------------"
	pytest --dead-fixtures tests
	pytest --cache-clear --cov=${MODULE} --cov-report term-missing:skip-covered --cov-report=lcov -v tests
	@echo "Info **********  End:   pytest ***************************************"

pytest-ci: ## Run all tests with pytest after test tool installation.
	@echo "Info **********  Start: pytest-ci *************************************"
	pip3 install pytest pytest-cov pytest-deadfixtures pytest-helpers-namespace pytest-random-order
	@echo "----------------------------------------------------------------------"
	pytest --version
	@echo "----------------------------------------------------------------------"
	pytest --dead-fixtures tests
	pytest --cache-clear --cov=${MODULE} --cov-report term-missing:skip-covered -v tests
	@echo "Info **********  End:   pytest-ci *************************************"

pytest-first-issue: ## Run all tests with pytest until the first issue occurs.
	@echo "Info **********  Start: pytest-first-issue ****************************"
	pytest --version
	@echo "----------------------------------------------------------------------"
	pytest --cache-clear --cov=${MODULE} --cov-report term-missing:skip-covered -rP -v -x tests
	@echo "Info **********  End:   pytest-first-issue ****************************"

pytest-ignore-mark: ## Run all tests without marker with pytest.
	@echo "Info **********  Start: pytest-ignore-mark ***************************"
	pytest --version
	@echo "----------------------------------------------------------------------"
	pytest --dead-fixtures -m "not no_ci" tests
	pytest --cache-clear --cov=${MODULE} --cov-report term-missing:skip-covered --cov-report=lcov -m "not no_ci" -v tests
	@echo "Info **********  End:   pytest-ignore-mark ***************************"

pytest-issue: ## Run only the tests with pytest which are marked with 'issue'.
	@echo "Info **********  Start: pytest-issue *********************************"
	pytest --version
	@echo "----------------------------------------------------------------------"
	pytest --dead-fixtures tests
	pytest --cache-clear --capture=no --cov=${MODULE} --cov-report term-missing:skip-covered -m issue -rP -v -x tests
	@echo "Info **********  End:   pytest-issue *********************************"

pytest-module: ## Run test of a specific module with pytest.
	@echo "Info **********  Start: pytest-module ********************************"
	@echo "TESTMODULE=tests/${TEST-MODULE}.py"
	@echo "----------------------------------------------------------------------"
	pytest --version
	@echo "----------------------------------------------------------------------"
	pytest --cache-clear --cov=${MODULE} --cov-report term-missing:skip-covered -v tests/${TEST-MODULE}.py
	@echo "Info **********  End:   pytest-module ********************************"

## An extremely fast Python linter and code formatter.
ruff:
	@echo "Info **********  Start: ruff *****************************************"
	ruff --version
	@echo "----------------------------------------------------------------------"
	ruff check --fix ${PYTHONPATH}
	@echo "Info **********  End:   ruff *****************************************"

## Create the user documentation with Sphinx.
sphinx:
	@echo "Info **********  Start: sphinx ***************************************"
	sphinx-apidoc --version
	sphinx-build --version
	@echo "----------------------------------------------------------------------"
	rm -rf docs/build/*
	mkdir -p docs/build
	sphinx-apidoc -o docs/source ${MODULE}
	sphinx-build -M html docs/source docs/build
	sphinx-build -b rinoh docs/source docs/build/pdf
	@echo "Info **********  End:   sphinx ***************************************"

tests: ## tests: Run all tests with pytest.
tests: pytest

version: ## Show the installed software versions.
	@echo "Info **********  Start: version **************************************"
	python3 --version
	pip3 --version
	@echo "Info **********  End:   version **************************************"

## Find dead Python code.
vulture:
	@echo "Info **********  Start: vulture **************************************"
	vulture --version
	@echo "----------------------------------------------------------------------"
	vulture ${PYTHONPATH}
	@echo "Info **********  End:   vulture **************************************"

## =============================================================================
