#!/bin/bash

# Usage: ./setup.sh [user_name](default 'sandbox') [user_id](default '1000') [user_group_id](default '1000')

set -e

# Script input parameters
USER_NAME=${1:-"sandbox"}
USER_UID=${2:-"1000"}
USER_GID=${3:-"1000"}

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use gosu, sudo, su, or add "USER root" (better) to your Dockerfile before running this script.'
    exit 1
fi

# ** Shell customization section **
if [ "${USER_NAME}" = "root" ]; then 
    user_rc_path="/root"
else
    user_rc_path="/home/${USER_NAME}"
fi

# Restore user .bashrc defaults from skeleton file if it doesn't exist or is empty
if [ ! -f "${user_rc_path}/.bashrc" ] || [ ! -s "${user_rc_path}/.bashrc" ] ; then
    cp  /etc/skel/.bashrc "${user_rc_path}/.bashrc"
fi

# Restore user .profile defaults from skeleton file if it doesn't exist or is empty
if  [ ! -f "${user_rc_path}/.profile" ] || [ ! -s "${user_rc_path}/.profile" ] ; then
    cp  /etc/skel/.profile "${user_rc_path}/.profile"
fi

if [ -z "${USER}" ]; then export USER=$(whoami); fi
if [[ "${PATH}" != *"$HOME/.local/bin"* ]]; then export PATH="${PATH}:$HOME/.local/bin"; fi


# Bash prompt
bash_prompt_format="$(cat \
<<'EOF'

__bash_prompt() {
    local userpart='`export XIT=$? \
        && [ ! -z "${GITHUB_USER}" ] && echo -n "\[\033[0;32m\]@${GITHUB_USER} " || echo -n "\[\033[0;32m\]\u " \
        && [ "$XIT" -ne "0" ] && echo -n "\[\033[1;31m\]➜" || echo -n "\[\033[0m\]➜"`'
    local gitbranch='`\
        if [ "$(git config --get codespaces-theme.hide-status 2>/dev/null)" != 1 ]; then \
            export BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null); \
            if [ "${BRANCH}" != "" ]; then \
                echo -n "\[\033[0;36m\](\[\033[1;31m\]${BRANCH}" \
                && if git ls-files --error-unmatch -m --directory --no-empty-directory -o --exclude-standard ":/*" > /dev/null 2>&1; then \
                        echo -n " \[\033[1;33m\]✗"; \
                fi \
                && echo -n "\[\033[0;36m\]) "; \
            fi; \
        fi`'
    local lightblue='\[\033[1;34m\]'
    local removecolor='\[\033[0m\]'
    PS1="${userpart} ${lightblue}\w ${gitbranch}${removecolor}\$ "
    unset -f __bash_prompt
}
__bash_prompt

EOF
)"

echo "${bash_prompt_format}" >> "${user_rc_path}/.bashrc"
echo 'export PROMPT_DIRTRIM=4' >> "${user_rc_path}/.bashrc"

echo "Done!"
