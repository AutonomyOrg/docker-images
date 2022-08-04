
# Ubuntu variant to use as base image (e.g. ubuntu-22.04, ubuntu-20.04, ubuntu-18.04)
ARG VARIANT="jammy"

FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

# Hadolint Dockerfile linter version
ARG HADOLINT_VERSION="2.10.0"

# Install additional packages
RUN wget --progress=dot:giga -c https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-Linux-x86_64 --output-document /usr/bin/hadolint \
 && chmod 755 /usr/bin/hadolint 
