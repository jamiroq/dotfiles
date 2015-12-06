#!/bin/bash
set -eu

############################################
# bootstrap.sh
############################################
has() {
    type ${1:?} >/dev/null 2>&1
    return $?
}

paint() {
    local end="\033[m"       ## 属性を標準に戻す
    local bold="\033[1m"     ## 強調（太字）
    local under="\033[4m"    ## 下線
    local reverse="\033[7m"  ## 反転
    local black="\033[30m"   ## 黒の文字に変更
    local red="\033[31m"     ## 赤の文字に変更
    local green="\033[32m"   ## 緑の文字に変更
    local yellow="\033[33m"  ## 黄色の文字に変更
    local blue="\033[34m"    ## 青の文字に変更
    local magenta="\033[35m" ## マゼンダの文字に変更
    local cyan="\033[36m"    ## シアンの文字に変更
    local white="\033[37m"   ## 白の文字に変更
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


############################################
# INIT
############################################
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
        if has "curl"; then
            curl -L "$tarball"

        elif has "wget"; then
            wget -O - "$tarball"

        fi | tar xvz -C "$DOTPATH"

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

############################################
# MAIN
############################################
# Set DOTPATH as default variable
if [ -z "${DOTPATH:-}" ]; then
    DOTPATH=~/.dotfiles
    export DOTPATH
fi

DOTFILES_GITHUB="https://github.com/jamiroq/dotfiles.git"
export DOTFILES_GITHUB

# [case] source xxxx.sh || [case] bash xxxx.sh
[[ $- = *i* || "$0" = "${BASH_SOURCE:-}" ]] && exit

# [case] bash -c "$(cat a.sh)" || [case] cat a.sh | bash
if [ -n "${BASH_EXECUTION_STRING:-}" ] || [ -p /dev/stdin ]; then

    trap catch INT ERR
    dotfiles_install

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

