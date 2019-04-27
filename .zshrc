#===============================================================================
# for zsh version 5.0.8
#===============================================================================

#===============================================================================
# プロンプト Prompt_decoration {{{
#-------------------------------------------------------------------------------
autoload -Uz colors
colors

## 環境変数をプロンプトに展開
setopt prompt_subst

## PROMPT:左側に表示される通常のプロンプト
if [ -n "${SSH_CONNECTION}" ]; then
    PROMPT="%F{cyan}%m %n%f:[%~]"$'\n$ '
else
    PROMPT="%n:[%~]"$'\n$ '
fi

## PROMPT2:2桁以上のコマンドを入力する際に表示されるプロンプト
PROMPT2="%{${fg[green]}%}%_> %{${reset_color}%}"

## RPROMPT:右側に表示されるプロンプト
autoload -Uz vcs_info
autoload -Uz is-at-least
if is-at-least 4.3.10; then
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr "+"
    zstyle ':vcs_info:git:*' unstagedstr "-"
    zstyle ':vcs_info:git:*' formats '(%s)-[%b] %c%u'
    zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a] %c%u'
else
    zstyle ':vcs_info:*' enable git svn hg bzr
    zstyle ':vcs_info:*' formats '(%s)-[%b]'
    zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
    zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
    zstyle ':vcs_info:bzr:*' use-simple true
fi

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="%F{green}${vcs_info_msg_0_}%f"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _update_vcs_info_msg

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

# default command
alias la='ls -lahF'
alias ll='ls -lhF'
alias rm='rm -i'
alias mv='mv -i'
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

#-------------------------------------------------------------------------------
# Keybind_END }}}
#===============================================================================

#===============================================================================
# 履歴管理 history {{{
#-------------------------------------------------------------------------------
## 履歴を :開始時刻:経過時間:コマンド の形で保存する。
setopt extended_history
## 複数のzshで実行したコマンドをヒストリに保存する
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
## TABでグロブを展開する
#setopt glob_complete

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

#^qでコマンドラインスタックを実行する(Required NO_FLOW_CONTROL)
show_buffer_stack() {
    zle -M "stack: ${BUFFER}"
    zle push-line-or-edit
}
zle -N show_buffer_stack
bindkey '^Q' show_buffer_stack

#-------------------------------------------------------------------------------
# Utility_END }}}
#===============================================================================

#===============================================================================
## ~/.zshrc.mineファイルがあれば、内容を読み込んで実行
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
#===============================================================================
