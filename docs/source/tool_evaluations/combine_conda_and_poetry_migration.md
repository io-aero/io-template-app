# Combine Conda and Poetry - Migration from Conda and Pip

To integrate **Conda** and **Poetry** in your Python development workflow, you'll leverage Conda for environment management and handling non-Python dependencies, while Poetry will manage Python-specific dependencies and packaging. This approach combines the strengths of both tools, ensuring a robust and reproducible development environment.

Below is a comprehensive guide on how to transition your existing `environment.yml` and `environment_dev.yml` files to use Conda and Poetry together.

---

## **1. Overview of the Integration**

- **Conda**:
  - **Role**: Manage environments, Python versions, and non-Python dependencies.
  - **Advantages**:
    - Handles complex dependencies, including system-level libraries.
    - Facilitates reproducible environments across different machines.

- **Poetry**:
  - **Role**: Manage Python dependencies, handle packaging, and versioning.
  - **Advantages**:
    - Simplifies dependency resolution with `pyproject.toml` and `poetry.lock`.
    - Provides tools for building and publishing Python packages.

---

## **2. Setting Up Conda Environment with Poetry**

### **2.1. Create a Base `environment.yml`**

Your Conda `environment.yml` will handle the Python environment, install Poetry, and include any non-Python dependencies. Here's how you can structure it:

```yaml
name: iotemplateapp
channels:
  - conda-forge
dependencies:
  - python=3.12
  - pip
  - pyyaml
  - tomli
  - tomli-w
  - virtualenv
  - poetry
  # Add any additional non-Python dependencies here
```

**Notes:**
- **Poetry Installation**: Installing Poetry via Conda ensures it's available in your environment. Alternatively, you can install it via `pip` if preferred.
- **Non-Python Dependencies**: If you have system-level dependencies (e.g., `gcc`, `ffmpeg`), list them under `dependencies` before the `pip` section.

### **2.2. Create the Conda Environment**

Run the following command to create the environment:

```bash
conda env create -f environment.yml
```

Activate the environment:

```bash
conda activate iotemplateapp
```

---

## **3. Configuring Poetry**

### **3.1. Initialize Poetry in Your Project**

Navigate to your project directory and initialize a new Poetry project:

```bash
cd path/to/your/project
poetry init
```

Follow the prompts to set up your `pyproject.toml`. This file will manage your Python dependencies.

### **3.2. Configure Poetry to Use Conda's Python Interpreter**

Ensure Poetry uses the Python interpreter from your active Conda environment:

```bash
poetry env use $(which python)
```

This links Poetry's environment to the Conda-managed Python interpreter, ensuring consistency.

### **3.3. Define Dependencies in `pyproject.toml`**

Your `pyproject.toml` should specify both production and development dependencies. Here's an example based on your provided `environment_dev.yml`:

```toml
[tool.poetry]
name = "iotemplateapp"
version = "0.1.0"
description = "Your project description"
authors = ["Your Name <you@example.com>"]

[tool.poetry.dependencies]
python = "^3.12"
pyyaml = "^6.0"
tomli = "^2.0"
tomli-w = "^0.7"
# Private Git Repository Dependency
io-common = { git = "https://github.com/io-aero/io-common.git", branch = "main", extras = [], develop = false }

[tool.poetry.dev-dependencies]
bandit = "^1.7"
black = "^23.3"
coverage = "^7.2"
coveralls = "^3.3"
docformatter = "^1.7"
furo = "^2023.4.28"
mypy = "^1.4"
myst-parser = "^0.19"
ordered-set = "^4.1"
pylint = "^2.17"
pytest = "^7.4"
pytest-cov = "^4.0"
pytest-deadfixtures = "^1.5"
pytest-helpers-namespace = "^1.1"
pytest-random-order = "^1.0"
rinohtype = "^0.9"
ruff = "^0.0.291"
sphinx = "^7.2"
sphinx-autoapi = "^1.11.1"
types-pyyaml = "^6.0.12"
types-toml = "^0.10.13"
vulture = "^2.5"

[build-system]
requires = ["poetry-core>=1.0.0"]
build-backend = "poetry.core.masonry.api"
```

**Handling Private Git Dependencies:**

To include a private Git repository (e.g., `io-common`), you need to handle authentication securely. Here are two approaches:

1. **Using Environment Variables in `pyproject.toml`:**

   Unfortunately, Poetry doesn't natively support environment variable interpolation in `pyproject.toml`. Instead, you can use Poetry's [dependency groups](https://python-poetry.org/docs/dependency-groups/) or manage authentication via Git credentials.

2. **Using Git Credential Helpers:**

   Configure Git to use credential helpers that can securely store and provide your credentials when accessing private repositories.

   ```bash
   git config --global credential.helper store
   ```

   Then, clone the repository manually once to store the credentials:

   ```bash
   git clone https://github.com/io-aero/io-common.git
   ```

   After this, Poetry should be able to access the repository without embedding credentials in the URL.

**Alternatively, Use Poetry's `source` Configuration:**

You can define custom sources with authentication in Poetry's configuration.

```bash
poetry config http-basic.io-aero IoAeroMachineUser $PYPI_PAT
```

Then, reference the package without embedding credentials:

```toml
io-common = { git = "https://github.com/io-aero/io-common.git", branch = "main" }
```

This approach keeps your credentials out of `pyproject.toml`.

### **3.4. Install Dependencies with Poetry**

After configuring `pyproject.toml`, install the dependencies:

```bash
poetry install
```

This command will create a `poetry.lock` file, ensuring reproducible installs across environments.

---

## **4. Handling Development vs. Production Environments**

### **4.1. Production Environment**

For production, you typically exclude development dependencies to keep the environment lean.

**Steps:**

1. **Create a Separate Conda Environment for Production:**

   ```yaml
   # environment_prod.yml
   name: iotemplateapp
   channels:
     - conda-forge
   dependencies:
     - python=3.12
     - pyyaml
     - tomli
     - tomli-w
     - virtualenv
     - poetry
     # Add any additional non-Python dependencies here
   ```

2. **Initialize and Install with Poetry Without Dev Dependencies:**

   ```bash
   conda env create -f environment_prod.yml
   conda activate iotemplateapp
   poetry install --no-dev
   ```

### **4.2. Development Environment**

For development, include both production and development dependencies.

**Steps:**

1. **Use the Existing `environment.yml`:**

   ```yaml
   # environment_dev.yml
   name: iotemplateapp
   channels:
     - conda-forge
   dependencies:
     - python=3.12
     - pip
     - pyyaml
     - tomli
     - tomli-w
     - virtualenv
     - poetry
     # Add any additional non-Python dependencies here
   ```

2. **Initialize and Install with Poetry Including Dev Dependencies:**

   ```bash
   conda env create -f environment_dev.yml
   conda activate iotemplateapp
   poetry install
   ```

**Note:** Ensure that your `pyproject.toml` differentiates between production and development dependencies using `[tool.poetry.dependencies]` and `[tool.poetry.dev-dependencies]`.

---

## **5. Example Workflow**

### **5.1. Production Setup**

1. **Create `environment_prod.yml`:**

   ```yaml
   name: iotemplateapp
   channels:
     - conda-forge
   dependencies:
     - python=3.12
     - pyyaml
     - tomli
     - tomli-w
     - virtualenv
     - poetry
     # Add any additional non-Python dependencies here
   ```

2. **Create and Activate the Environment:**

   ```bash
   conda env create -f environment_prod.yml
   conda activate iotemplateapp
   ```

3. **Configure Poetry and Install Dependencies:**

   ```bash
   poetry env use $(which python)
   poetry install --no-dev
   ```

### **5.2. Development Setup**

1. **Create `environment_dev.yml`:**

   ```yaml
   name: iotemplateapp
   channels:
     - conda-forge
   dependencies:
     - python=3.12
     - pip
     - pyyaml
     - tomli
     - tomli-w
     - virtualenv
     - poetry
     # Add any additional non-Python dependencies here
   ```

2. **Create and Activate the Environment:**

   ```bash
   conda env create -f environment_dev.yml
   conda activate iotemplateapp
   ```

3. **Configure Poetry and Install Dependencies:**

   ```bash
   poetry env use $(which python)
   poetry install
   ```

---

## **6. Best Practices and Recommendations**

### **6.1. Avoid Mixing Package Managers for Python Packages**

- **Do Not Install Python Packages with Both Conda and Poetry/Pip**: This can lead to dependency conflicts and unpredictable behavior.
- **Use Conda for Non-Python Dependencies Only**: Let Poetry handle all Python-specific packages.

### **6.2. Securely Manage Private Repositories**

- **Use Git Credential Helpers**: To avoid embedding sensitive information in configuration files.
- **Leverage Poetry’s Authentication Mechanisms**: Configure credentials using Poetry’s settings to keep them secure.

### **6.3. Automate Environment Setup**

Create scripts or Makefiles to streamline the setup process, reducing manual errors and ensuring consistency across team members.

**Example `setup.sh`:**

```bash
#!/bin/bash

# Create Conda environment
conda env create -f environment_dev.yml

# Activate environment
conda activate iotemplateapp

# Configure Poetry to use Conda's Python
poetry env use $(which python)

# Install dependencies
poetry install
```

Make the script executable:

```bash
chmod +x setup.sh
```

Run the setup:

```bash
./setup.sh
```

### **6.4. Regularly Update Dependencies**

- **Poetry**: Use `poetry update` to keep Python dependencies up-to-date.
- **Conda**: Update Conda packages as needed, ensuring compatibility with Poetry-managed dependencies.

### **6.5. Document the Workflow**

Maintain clear documentation for your team on how to set up and work within the Conda and Poetry integrated environment. Include instructions for environment creation, activating environments, and managing dependencies.

---

## **7. Final Thoughts**

Combining **Conda** and **Poetry** offers a powerful and flexible environment for Python development, especially in complex projects requiring both Python and non-Python dependencies. By following the structured approach outlined above, you can achieve:

- **Reproducible Environments**: Ensuring consistency across development, testing, and production.
- **Efficient Dependency Management**: Leveraging Poetry's robust handling of Python packages.
- **Scalability and Flexibility**: Easily managing both Python and system-level dependencies without conflicts.

Remember to regularly maintain and update your dependencies, secure your private repositories, and streamline your workflow to maximize the benefits of this integrated setup.