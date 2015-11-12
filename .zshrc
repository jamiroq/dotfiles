#===============================================================================
# 2014/10/24
# for zsh version 5.0.7
# [author]: sz
#===============================================================================


#===============================================================================
# 環境変数 Variable {{{
#-------------------------------------------------------------------------------
export EDITOR=vim
export LANG=ja_JP.UTF-8
#-------------------------------------------------------------------------------
# Variable_END }}}
#===============================================================================

#===============================================================================
# カラー Color {{{
#-------------------------------------------------------------------------------
## 色情報の変数読み込み
autoload colors
colors

## ls colors
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# lessのオプションを環境変数で指定する
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case --quit-if-one-screen --RAW-CONTROL-CHARS'

## 補完候補の色づけ
zstyle ':completion:*' list-colors \
		'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
#-------------------------------------------------------------------------------
# Color_END }}}
#===============================================================================

#===============================================================================
# プロンプト Prompt_decoration {{{
#-------------------------------------------------------------------------------
## 環境変数をプロンプトに展開する(色を使う)
setopt prompt_subst
## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr
## PROMPT:左側に表示される通常のプロンプト
local Cname=$'%{\e[0;0m%}'
local Cdict=$'%{\e[0;0m%}'
local Cprom=$'%{\e[0;32m%}'
local Cdefault=$'%{\e[0;0m%}'
#PROMPT="$Cname%n %T$Cdefault"
PROMPT="%T %n$Cname$Cdefault"
	[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
	PROMPT="${PS1}$Cdefault@$Cprom%m"
PROMPT="${PS1}$Cdefault:[$Cdict%~$Cprom$Cdefault]$DEFAULT"$'\n $ '

## PROMPT2:2桁以上のコマンドを入力する際に表示されるプロンプト
PROMPT2="%{${fg[green]}%}%_> %{${reset_color}%}"

## SPROMPT:コマンドを打ち間違えたときのプロンプト
#SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"

## RPROMPT:右側に表示されるプロンプト。入力がかぶると自動消去
autoload -Uz add-zsh-hook
autoload -Uz colors
colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

autoload -Uz is-at-least
if is-at-least 4.3.10; then
  # check-for-changes need zsh version 4.3.10
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"
  zstyle ':vcs_info:git:*' unstagedstr "-"
  zstyle ':vcs_info:git:*' formats '(%s)-[%b] %c%u'
  zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a] %c%u'
fi

function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg
RPROMPT="%1(v|%F{green}%1v%f|)"
#-------------------------------------------------------------------------------
# Prompt_decoration_END }}}
#===============================================================================

#===============================================================================
# 履歴管理 history {{{
#-------------------------------------------------------------------------------
HISTFILE=$HOME/.zsh_history #履歴の保存先
HISTSIZE=100000 #メモリに展開する履歴の数
SAVEHIST=100000 #保存する履歴の数

## 複数のzshで実行したコマンドをヒストリに保存する
setopt inc_append_history
## 同一ホストで動いているzshで履歴 を共有
setopt share_history
## 履歴を :開始時刻:経過時間:コマンド の形で保存する。
setopt extended_history
## ヒストリを呼び出してから実行する間に一旦編集可能を止める
setopt hist_verify
## ヒストリの保存時に重複コマンドを古い方から削除
setopt hist_save_nodups
## コマンド行の余分な空白を詰めてヒストリに入れる
setopt hist_reduce_blanks
## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
## コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space
## history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store
## 補完時にヒストリを自動的に展開
setopt hist_expand
#-------------------------------------------------------------------------------
# History_END }}}
#===============================================================================

#===============================================================================
# 補完 Complement {{{
#-------------------------------------------------------------------------------
## 補完機能の強化
autoload -U compinit
compinit -u
## 補完候補を一覧表示
setopt auto_list
## 補完候補を詰めて表示
setopt list_packed
# 補完候補の表示を水平方向にする
setopt list_rows_first
## 補完候補一覧でファイルの種別をマーク表示
setopt list_types
## TABで補完候補を順に切り替える
setopt auto_menu
## Shift+Tabで補完候補を逆戻り
bindkey "\e[Z" reverse-menu-complete
## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
## --prefix=/usrなどの =以降も補完
setopt magic_equal_subst
## カッコの対応などを自動的に補完
setopt auto_param_keys
## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
#-------------------------------------------------------------------------------
# Complement_END }}}
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
alias du='du -h'
alias df='df -h'
alias dateh='date +%Y-%m%d-%H%M'
alias gfind='find . -type f -print | xargs grep'

# Docker command
alias dl='docker ps -l -q'

# lvできちんと表示されるようにする
alias lv='lv -c -T8192'
#-------------------------------------------------------------------------------
# Alias_END }}}
#===============================================================================

#===============================================================================
# キーバインド keybind {{{
#-------------------------------------------------------------------------------
## Emacs風キーバンイドにする
bindkey -e
# 文字の途中でカーソルの右を無視して補完
bindkey '^t' expand-or-complete-prefix
## 今入力している内容から始まるヒストリを探す
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# コマンド入力中にマニュアルを表示できるrun-help(ESC-H)を有効にする
[ -n "`alias run-help`" ] && unalias run-help
autoload run-help
# C-xhをrun-helpにする。
bindkey "^xh" run-help
#-------------------------------------------------------------------------------
# Keybind_END }}}
#===============================================================================

#===============================================================================
# オプション Options {{{
#-------------------------------------------------------------------------------
## ビープを鳴らさない
setopt no_beep
## Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt NO_flow_control
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
## "Ctrl + w" 直前の/までバックスペース
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
## コアダンプサイズを制限
limit coredumpsize 102400
#-------------------------------------------------------------------------------
# Utility_END }}}
#===============================================================================

#===============================================================================
# 拡張 Extension {{{
#-------------------------------------------------------------------------------
#^qでコマンドラインスタックを実行する｡さらに､退避されたコマンドの表示を行う｡
show_buffer_stack() {
  POSTDISPLAY="
stack: $LBUFFER"
  zle push-line-or-edit
}
zle -N show_buffer_stack
setopt noflowcontrol
bindkey '^Q' show_buffer_stack

# 表示されているコマンドをクリップボードに記録
pbcopy-buffer(){
    print -rn $BUFFER | pbcopy
    zle -M "pbcopy: ${BUFFER}"
}
zle -N pbcopy-buffer
bindkey '^x^p' pbcopy-buffer
#-------------------------------------------------------------------------------
# Extesion_END }}}
#===============================================================================


#===============================================================================
## ~/.zshrc.mineファイルがあれば、内容を読み込んで実行
## (実験的な設定は.zshrc.mineに記述)
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
#===============================================================================

#:finish
#===============================================================================
# 倉庫 Archive {{{
#-------------------------------------------------------------------------------

## コマンド名に / が含まれているとき PATH 中のサブディレクトリを探す
#setopt path_dirs
## =command を command のパス名に展開する
#setopt equals
## スペルチェック
#setopt correct
## TABでグロブを展開する
#setopt glob_complete
## 戻り値が 0 以外の場合終了コードを表示する
#setopt print_exit_value
## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
#setopt auto_resume
## 複数のリダイレクトやパイプなど、必要に応じて tee や cat の機能が使われる
#setopt multios
## 出力時8ビットを通す
#setopt print_eight_bit
### ファイルの削除にゴミ箱を使う
#TRASHDIR=~/.trash

#del () {
#        local path
#        for path in "$@"; do
#                # ignore any arguments
#                if [[ "$path" = -* ]]; then
#                        echo "del doesn't understand any arguments. Should use /bin/rm."
#                        return
#                else
#                        # create trash if necessary
#                        if [ ! -d $TRASHDIR ]; then
#                                /bin/mkdir -p $TRASHDIR
#                        fi
#
#                        local dst=${path##*/}
#                        # append the time if necessary
#                        while [ -e $TRASHDIR"/$dst" ]; do
#                                dst="$dst "$(date +%H-%M-%S)
#                        done
#                        /bin/mv "$path" $TRASHDIR/"$dst"
#                fi
#        done
#}
### ゴミ箱を空にする
#alias trash-look="ls -al $TRASHDIR/ 2> /dev/null"
#alias trash-clean="/bin/rm -R -f $TRASHDIR/*"

#-------------------------------------------------------------------------------
# Archive_END }}}
#===============================================================================
