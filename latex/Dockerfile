
FROM ghcr.io/autonomyorg/sandbox:0.0.1

# Docker image metadata
LABEL org.opencontainers.image.title="LateX"
LABEL org.opencontainers.image.description="LaTeX documents preparation sandbox"
LABEL org.opencontainers.image.source="https://github.com/AutonomyOrg/docker-images/latex"
LABEL org.opencontainers.image.license=Apache-2.0

# Installing basic dependencies
RUN sudo apt-get update \
 && sudo apt-get -y install --no-install-recommends \
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
 && sudo apt-get autoremove -y \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*

# Install additional fonts
RUN sudo curl https://www.tug.org/fonts/getnonfreefonts/install-getnonfreefonts --output install-getnonfreefonts  --silent \
 && sudo texlua install-getnonfreefonts \
 && sudo rm -rf install-getnonfreefonts
 
# Generating locales
RUN sudo sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
 && sudo dpkg-reconfigure --frontend=noninteractive locales \
 && sudo update-locale LANG=en_US.UTF-8

ENV LANGUAGE=en_US.UTF-8 LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Installing cpanm and missing latexindent dependencies
RUN sudo curl -L http://cpanmin.us | sudo perl - --self-upgrade \
 && sudo cpanm Log::Dispatch::File YAML::Tiny File::HomeDir Unicode::GCString
