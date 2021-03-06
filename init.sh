#!/bin/bash
set -eu

#===========================================
# Bootstrap {{{
#-------------------------------------------
has() {
    type ${1:?} >/dev/null 2>&1
    return $?
}

paint() {
    local end="\033[m"
    local bold="\033[1m"
    local under="\033[4m"
    local reverse="\033[7m"
    local black="\033[30m"
    local red="\033[31m"
    local green="\033[32m"
    local yellow="\033[33m"
    local blue="\033[34m"
    local magenta="\033[35m"
    local cyan="\033[36m"
    local white="\033[37m"
    local none=""

    local text="${1:?}"
    local color="$end"
    local attrs="$end"

    case "${2:?}" in
        black | red | green | yellow | blue | purple | cyan | gray | white | none)
            eval color="\$$2"
            ;;
    esac

    for attr in ${@:3}; do
        case "$attr" in
            bold | under | reverse)
                eval tmp="\$$attr"
                attrs=("${attrs[@]}" $tmp)
        esac
    done
    attrs=$(echo ${attrs[@]} | tr -d " ")

    printf "${attrs}${color}${text}${end}"
}

info() {
    #printf "${TERM_BLUE}%s${TERM_END}\n" "$*"
    paint "$*\n" "white"
}

fail() {
    #printf "${TERM_BOLD}${TERM_UNDER}${TERM_RED}%s${TERM_END}\n" "$*" 1>&2
    paint "$*\n" "red" "bold" 1>&2
}

#-------------------------------------------
# Bootstrap_END }}}
#===========================================

#===========================================
# Initalize {{{
#-------------------------------------------
catch() {
    fail "terminating..."
    if [ -d "$DOTPATH" ]; then
        rm -f "$DOTPATH"
        exit 1
    fi
}

dotfiles_download() {
    info "download dotfiles..."

    if [ -d "$DOTPATH" ]; then
        fail "$DOTPATH: already exists"
        exit 1
    fi

    if has "git"; then
        git clone --recursive "$DOTFILES_GITHUB" "$DOTPATH"
    elif has "curl" || has "wget"; then
        local tarball="https://github.com/jamiroq/dotfiles/archive/master.tar.gz"
        mkdir -p "$DOTPATH"
        if has "curl"; then
            curl -L "$tarball"
        elif has "wget"; then
            wget -O - "$tarball"
        fi | tar xvz -C "$DOTPATH" --strip-components 1
    else
        fail "git or curl, wget required"
        exit 1
    fi
}

dotfiles_deploy() {
    info "Deploying dotfiles..."

    if [ ! -d $DOTPATH ]; then
        fail "$DOTPATH: not found"
        exit 1
    fi

    cd "$DOTPATH" && make deploy

    info "Deployed"

}

dotfiles_install() {
    # Download dotfiles repository
    dotfiles_download &&

    # Deploy dotfiles to DOTPATH
    dotfiles_deploy
}

homebrew_preinstall() {
    info "Pre-installing..."

    # For RedHat
    if [ -f /etc/redhat-release ]; then
        sudo yum groupinstall 'Development Tools' && \
        sudo yum install curl file git

    # For Debian
    elif [ -f /etc/debian_version ]; then
        sudo apt install build-essential curl file git

    else
        fail "OS not supported"
        exit 1
    fi
}

homebrew_install() {
    echo "homebrew installing..."
    local linuxbrew_installer="https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh"
    sh -c "$(curl -fsSL $linuxbrew_installer)"
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
}

tools_install() {
    brew upgrade
    brew install vim
    brew install zsh
    brew install tmux
    brew install ripgrep
    brew install ghq
}

packages_install() {
    homebrew_preinstall &&
    homebrew_install &&
    tools_install
}

#-------------------------------------------
# Initialize_END }}}
#===========================================

#===========================================
# Main {{{
#-------------------------------------------
# Set DOTPATH as default variable
if [ -z "${DOTPATH:-}" ]; then
    DOTPATH=~/.dotfiles
    export DOTPATH
fi

DOTFILES_GITHUB="https://github.com/jamiroq/dotfiles.git"
export DOTFILES_GITHUB

# [case] source xx.sh || [case] bash xx.sh
[[ $- = *i* || "$0" = "${BASH_SOURCE:-}" ]] && exit

# [case] bash -c "$(cat xx.sh)" || [case] cat xx.sh | bash
if [ -n "${BASH_EXECUTION_STRING:-}" ] || [ -p /dev/stdin ]; then

    trap catch INT ERR
    dotfiles_install
    packages_install

    # Restart shell if specified "bash -c $(curl -L {URL})"
    # not restart:
    #   curl -L {URL} | bash
    if [ -p /dev/stdin ]; then
        info "Now continue with Rebooting shell"
    else
        info "Restarting shell..."
        exec "${SHELL:-/bin/zsh}"
    fi
fi

#-------------------------------------------
# Main_END }}}
#===========================================

