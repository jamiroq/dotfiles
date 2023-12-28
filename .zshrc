#===============================================================================
# for zsh version 5.7.1
#===============================================================================

#===============================================================================
# プロンプト Prompt_decoration {{{
#-------------------------------------------------------------------------------
autoload -Uz colors
colors

## 環境変数をプロンプトに展開
setopt prompt_subst

## PROMPT:左側に表示される通常のプロンプト
PROMPT="%F{cyan}%m%f:%F{green}%n%f [%~]"$'\n%(!.%F{red}#%f.>) '

## PROMPT2:2桁以上のコマンドを入力する際に表示されるプロンプト
PROMPT2="%{${fg[green]}%}%_> %{${reset_color}%}"

## RPROMPT:右側に表示されるプロンプト
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}(+)%f"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}(-)%f"
zstyle ':vcs_info:*' formats '%F{green}%c%u [%b]%f'
zstyle ':vcs_info:*' actionformats '[%b|%a]'

function _update_vcs_info() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _update_vcs_info

#-------------------------------------------------------------------------------
# Prompt_decoration_END }}}
#===============================================================================

#===============================================================================
# エイリアス Alias {{{
#-------------------------------------------------------------------------------
case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac

if [[ $(uname -r) =~ 'Microsoft' ]]; then
    alias clip="clip.exe"
elif [[ $(uname) == 'Linux' ]]; then
    alias clip="xsel"
elif [[ $(uname) == 'Darwin' ]]; then
    alias clip="pbcopy"
fi

# default command
alias g='git'
alias la='ls -lahF'
alias ll='ls -lhF'
alias rm='rm -i'
alias mv='mv -i'
alias vivi='vim ~/.vimrc'
alias gfind='find . -type f -print | xargs grep'

# lvできちんと表示されるようにする
alias lv='lv -c -T8192'

#-------------------------------------------------------------------------------
# Alias_END }}}
#===============================================================================

#===============================================================================
# キーバインド keybind {{{
#-------------------------------------------------------------------------------
## Emacs風キーバインドにする
bindkey -e

# コマンド入力中にマニュアルを表示できるrun-help(ESC-H)を有効にする
autoload -Uz run-help
bindkey "^k" run-help

## ^Oでlsを実行
function _ls_command() {
    zle kill-whole-line
    zle -U ls$'\n'
}
zle -N _ls_command
bindkey '^O' _ls_command

## ^Gでghqで管理するリポジトリに移動
function ghq-look () {
    res=$(ghq list --full-path | fzf --prompt='cd-ghq >')
    if [ -n "$res" ]; then
        BUFFER="cd $res"
    fi
    zle accept-line
}
zle -N ghq-look
bindkey '^G' ghq-look

## ^Sでコマンドラインスタックを実行する(Required NO_FLOW_CONTROL)
show_buffer_stack() {
    zle -M "stack: ${BUFFER}"
    zle push-line-or-edit
}
zle -N show_buffer_stack
bindkey '^S' show_buffer_stack

# Ensure precmds are run after cd
fzf-redraw-prompt() {
  local precmd
  for precmd in $precmd_functions; do
    $precmd
  done
  zle reset-prompt
}
zle -N fzf-redraw-prompt

fzf-cd-widget() {
  local cmd="command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type d -print 2> /dev/null | cut -b3-"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local dir="$(eval "$cmd" | fzf +m)"
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  cd "$dir"
  unset dir # ensure this doesn't end up appearing in prompt expansion
  local ret=$?
  zle fzf-redraw-prompt
  return $ret
}
zle     -N    fzf-cd-widget
bindkey '^T' fzf-cd-widget

# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected=( $(fc -rl 1 | perl -ne 'print if !$seen{(/^\s*[0-9]+\s+(.*)/, $1)}++' | fzf) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}
zle     -N   fzf-history-widget
bindkey '^R' fzf-history-widget

#-------------------------------------------------------------------------------
# Keybind_END }}}
#===============================================================================

#===============================================================================
# 履歴管理 history {{{
#-------------------------------------------------------------------------------
## 履歴を :開始時刻:経過時間:コマンド の形で保存する。
setopt extended_history
## zshの終了を待たずコマンドをヒストリに保存する
setopt inc_append_history
## 同一ホストで動いているzshで履歴 を共有
setopt share_history
## ヒストリを呼び出してから実行する間に一旦編集可能を止める
setopt hist_verify
## コマンド行の余分な空白を詰めてヒストリに入れる
setopt hist_reduce_blanks
## 同じコマンドをヒストリに追加しない
setopt hist_ignore_all_dups
## コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space
## history & fc -l コマンドをヒストリリストから取り除く。
setopt hist_no_store
## 補完時にヒストリを自動的に展開
setopt hist_expand
## 今入力している内容から始まるヒストリを探す
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
#-------------------------------------------------------------------------------
# History_END }}}
#===============================================================================

#===============================================================================
# 補完 Complement {{{
#-------------------------------------------------------------------------------
## 補完機能の強化
autoload -Uz compinit
compinit -u
## 補完キーで補完候補を順次切替
setopt auto_menu
## 補完候補を一覧表示
setopt auto_list
## 補完候補を詰めて表示
setopt list_packed
# 補完候補の表示を水平方向にする
setopt list_rows_first
## 補完候補一覧でファイルの種別をマーク表示
setopt list_types
## --prefix=/usrなどの =以降も補完
setopt magic_equal_subst
## カッコの対応などを自動的に補完
setopt auto_param_keys
## 日本語などの8bitに対応
setopt print_eight_bit
## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
## 補完候補の色設定
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
## Ctrl+iで補完候補を送る
bindkey "^i" menu-complete
#-------------------------------------------------------------------------------
# Complement_END }}}
#===============================================================================

#===============================================================================
# オプション Options {{{
#-------------------------------------------------------------------------------
## ビープを鳴らさない
setopt no_beep
## Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt no_flow_control
## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr
## 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs

## "cd -[tab]" で移動したディレクトリ表示
setopt auto_pushd
## 同じディレクトリを pushd しない
setopt pushd_ignore_dups
## ディレクトリ名だけでcd
setopt auto_cd
## ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs
## 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash

## ファイル名の展開で数字を数値と解釈してソートする
setopt numeric_glob_sort
## コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments
# for, repeat, select, if, function などで簡略文法が使えるようになる
setopt short_loops
## {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl
## ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob
## Disuse ambiguous output redirect
setopt no_multios

## コアダンプサイズを制限
limit coredumpsize 102400
#-------------------------------------------------------------------------------
# Option_END }}}
#===============================================================================

#===============================================================================
# ユーティリティ Utility {{{
#-------------------------------------------------------------------------------
## ターミナルのタイトルにカレントディレクトリ名を表示
case "${TERM}" in
kterm*|xterm*)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
  }
  ;;
esac

## Ctrl+SとCtrl+Qの停止
if [[ -t 0 ]]; then
    stty stop undef
    stty start undef
fi

## ヒストリから失敗したコマンドを削除
remove_last_history_if_not_needed () {
  local last_status="$?"
  local HISTFILE=~/.zsh_history
  if [[ ${last_status} -ne 0 ]]; then
    fc -W
    ed -s ${HISTFILE} <<EOF >/dev/null
d
w
q
EOF
    fc -R
  fi
}
add-zsh-hook precmd remove_last_history_if_not_needed

## ヒストリに一部のコマンドを登録しない
zshaddhistory() {
    local line="${1%%$'\n'}"
    [[ ! "$line" =~ "^(cd|lazygit|la|ll|ls|rm|rmdir|vim|nvim)($| )" ]]
}
#-------------------------------------------------------------------------------
# Utility_END }}}
#===============================================================================

#===============================================================================
## ~/.zshrc.mineファイルがあれば、内容を読み込んで実行
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
#===============================================================================
