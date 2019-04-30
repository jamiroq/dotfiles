# LANG
export LANG="en_US.UTF-8"

# EDITOR
export EDITOR=vim

# PAGER
export PAGER=less
export LESS='--NO-INIT --QUIT-IF-ONE-SCREEN --RAW-CONTROL-CHARS --ignore-case -P ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
export LESSCHARSET='utf-8'

export LESS_TERMCAP_mb=$'\E[01;33m'
export LESS_TERMCAP_md=$'\E[01;37m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[00;44;37m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

## ls colors (for BSD ls)
export LSCOLORS=gxfxcxdxbxegedabagacad
## ls colors (for GNU ls)
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

## Treat as word character
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

## HISTORY
export HISTFILE=$HOME/.zsh_history #履歴の保存先
export HISTSIZE=100000 #メモリに展開する履歴の数
export SAVEHIST=100000 #保存する履歴の数
