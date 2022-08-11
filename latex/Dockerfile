
FROM ghcr.io/autonomyorg/sandbox:0.0.1

# Docker image metadata
LABEL org.opencontainers.image.title="LateX"
LABEL org.opencontainers.image.description="LaTeX documents preparation sandbox"
LABEL org.opencontainers.image.source="https://github.com/AutonomyOrg/docker-images/latex"
LABEL org.opencontainers.image.license=Apache-2.0

# Switch (momentarily) to root user (rather than using 'sudo' or 'gosu', for instance)
USER root

# Installing basic dependencies
RUN apt-get update \
 && apt-get -y install --no-install-recommends \
    biber \
    cm-super curl \
    git \
    wget \
    latexmk \
    locales \
    make \ 
    pandoc \
    procps \
    python3-pygments \
    texlive \
    texlive-base \
    texlive-bibtex-extra \
    texlive-binaries \
    texlive-extra-utils \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    texlive-font-utils \
    texlive-formats-extra \
    texlive-lang-english \
    texlive-lang-european \
    texlive-lang-french \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-latex-recommended \
    texlive-luatex \
    texlive-pictures \
    xindy \
    xindy-rules \
 && apt-get autoremove -y \
 && apt-get clean -y \
 && rm -rf /var/lib/apt/lists/*

# Install additional fonts
RUN curl https://www.tug.org/fonts/getnonfreefonts/install-getnonfreefonts --output install-getnonfreefonts  --silent \
 && texlua install-getnonfreefonts \
 && rm -rf install-getnonfreefonts
 
# Generating locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
 && dpkg-reconfigure --frontend=noninteractive locales \
 && update-locale LANG=en_US.UTF-8

ENV LANGUAGE=en_US.UTF-8 LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Installing cpanm and missing latexindent dependencies
RUN curl -L http://cpanmin.us | perl - --self-upgrade \
 && cpanm Log::Dispatch::File YAML::Tiny File::HomeDir Unicode::GCString

# Switch back to default non-root user (which is 'sandbox', when using sandbox image as base image)
USER sandbox
