# Use the official Miniconda base image
FROM continuumio/miniconda3:latest

# Set the working directory inside the container
WORKDIR /app

# Argument for PYPI_PAT
ARG PYPI_PAT
ENV PYPI_PAT=${PYPI_PAT}

# Copy the environment file and application code to the container
COPY environment.yml .

# Install dependencies from the environment file
RUN conda env create -f environment.yml

# Copy the necessary files
COPY entrypoint.sh .
COPY iotemplateapp/ ./iotemplateapp/
COPY run_io_template_app.sh .
COPY scripts/ ./scripts/

# Set environment variables
ENV ENV_FOR_DYNACONF=prod
ENV PYTHONPATH=.

# Make the scripts executable
RUN chmod +x entrypoint.sh
RUN chmod +x run_io_template_app.sh

# Set the entrypoint
ENTRYPOINT ["./entrypoint.sh"]

# Command to run the script and keep the container running
CMD ["./run_io_template_app.sh", "&&", "tail", "-f", "/dev/null"]
