# User guide for the repository `IO-TEMPLATE-APP`

`IO-TEMPLATE-APP` is a template repository for creating Python applications. 
This document describes how to use this repository to create a new repository. 
In the following instructions, we assume that the new repository should be named `my-app` and the application to be created with it should be named `myapp`.

## I. Requirements

Regarding operating system, Ubuntu version 20.04 and above and Windows version 10 and above are supported. An existing Python 3 installation is required.
Furthermore, the use of an IDE or a text editor that can replace texts across files is useful.

## II. Repository creation

### 1. Create the new repository `my-app`

As described [here](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template), the new repository my-app must first be created.

### 2. Create a local copy of the new repositoy `my-app`

    git clone https://github.com/io-aero/my-app

### 3. Delete the two files with the User's Guide

    `user_guide.md`
    `user_guide.pdf`

### 4. Rename the following file directories and files

| Old name                  | New name         |
|:--------------------------|:-----------------|
| `iotemplateapp`           | `myapp`        |
| `run_io_template_app.bat` | `run_my_app.bat` |
| `run_io_template_app.sh`  | `run_my_app.sh`  |

### 5. Replacing texts in the new repository `my-app`

It is absolutely necessary to respect the capitalization!

| Old text           | New text   |
|:-------------------|:-----------|
| `IO-TEMPLATE-APP`  | `MY-APP`  |
| `IO_TEMPLATE_APP`  | `MY_APP`  |
| `io-template-app`  | `my-app`  |
| `io_template_app`  | `my_app`  |
| `iotemplateapp`    | `myapp`   |

### 6. Store your AWS access rights in file `~/.aws/credentials`

    [default]
    aws_access_key_id=...
    aws_secret_access_key=...

### 7. Test the current state of the new application

#### 7.1 If Miniconda is required 

- Install Miniconda
- Run `make conda-dev`
- Run `make final`

#### 7.2 If Miniconda is not required

- Run `make pipenv-dev`
- Run `make final`

### 8. Define GitHub Actions secrets

Under 'settings' -> 'Secrets and variables' -> 'Actions' -> Tab 'Secrets' define the following 'New repository secret's:

    AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY
    GLOBAL_USER_EMAIL

### 9. Define GitHub repository variables

Under 'settings' -> 'Secrets and variables' -> 'Actions' -> Tab 'Variables' define the following 'New repository variable's:

| Name        | Value  | Reason            |
|-------------|--------|-------------------|
| `CONDA`     | `true` | Include Miniconda |
| `COVERALLS` | `true` | Run coveralls.io  |

### 10. Commit and push all changes to the repository as 'Base version'
