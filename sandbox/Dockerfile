FROM ubuntu:18.04

# Options for setup script
ARG USER_NAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Docker image metadata
LABEL org.opencontainers.image.title="Sandbox"
LABEL org.opencontainers.image.description="VSCode development sandbox"
LABEL org.opencontainers.image.source="https://github.com/AutonomyOrg/docker-images/sandbox"
LABEL org.opencontainers.image.license=Apache-2.0

# Install setup script
COPY scripts/*.sh /tmp/scripts/

# Configure basic features
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    sudo \
    # Create non-root user
 && groupadd --gid $USER_GID $USER_NAME \
 && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USER_NAME \
    # Add non-root user to sudo
 && echo $USER_NAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER_NAME \
 && chmod 0440 /etc/sudoers.d/$USER_NAME \
    # Execute setup script
 && bash /tmp/scripts/setup.sh "${USER_NAME}" "${USER_UID}" "${USER_GID}" \
    # Clean up final image
 && apt-get clean -y \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/scripts

# Set default user to the non-root user
USER $USER_NAME