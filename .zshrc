### for ruby ###
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
### for foundation ###
export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす
export PAGER=less        # less
export LESS='-R'         # colorful less
bindkey -e               # キーバインドをemacsモードに設定
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
### for cd ###
setopt AUTO_CD           # ディレクトリ名入力で cd する
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
### for completion ###
# 補完機能を有効にする
autoload -U compinit; compinit
# 補完候補を一覧で表示する(d)
setopt auto_list
# 補完キー連打で補完候補を順に表示する(d)
setopt auto_menu
# 補完候補をできるだけ詰めて表示する
setopt list_packed
# 補完候補にファイルの種類も表示する
setopt list_types
# Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
bindkey "^[[Z" reverse-menu-complete
# 補完時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
### ls ###
# 色の設定
export LSCOLORS=Dxfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
### prompt ###
# プロンプトに色を付ける
PROMPT='
[%F{yellow}%~%f@%F{green}LOCAL%f] `vcs_echo`
%(?.$.%F{red}$%f) '
# プロンプト定義内で変数置換やコマンド置換を扱う
setopt prompt_subst
# Git のブランチをプロンプトに表示
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' max-exports 6 # formatに入る変数の最大数
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%b@%r' '%c' '%u'
zstyle ':vcs_info:git:*' actionformats '%b@%r|%a' '%c' '%u'
function vcs_echo {
    local st branch color
    STY= LANG=en_US.UTF-8 vcs_info
    st=`git status 2> /dev/null`
    if [[ -z "$st" ]]; then return; fi
    branch="$vcs_info_msg_0_"
    if   [[ -n "$vcs_info_msg_1_" ]]; then color=${fg[green]} #staged
    elif [[ -n "$vcs_info_msg_2_" ]]; then color=${fg[red]} #unstaged
    elif [[ -n `echo "$st" | grep "^Untracked"` ]]; then color=${fg[blue]} # untracked
    else color=${fg[cyan]}
    fi
    echo "%{$color%}(%{$branch%})%{$reset_color%}" | sed -e s/@/"%F{yellow}@%f%{$color%}"/
}
### homebrew ###
export PATH=/Applications/Docker.app/Contents/Resources/bin:$PATH
### alias ###
alias c='clear && ls'
alias reload='source ~/.zshrc'
alias la='ls -a'
alias cd='cdls'
alias v='vi'
alias mkdate="mkdir `date '+%Y_%m_%d'`"
alias work="cd ~/Work"
alias brama="cd ~/Work/brama"
# for git
alias g='git'
alias gsw='g switch'
alias grs='g restore'
alias gst='g status'
alias gd='g diff'
alias gl='g log'
alias gb='g branch -a'
alias ga='g add'
alias gc='g commit'
alias gunstage='g reset . HEAD^'
alias gstsh='g stash --include-untracked'
alias gfirstcommit='g commit --allow-empty -m "first commit"'
# ktlint
alias asktlint='./gradlew ktlint'
alias asktformat='./gradlew ktlintFormat'
# for ssh
alias rsakeygen='ssh-keygen -t rsa -b 4096 -C "takathemax@gmail.com"'
alias rsakeygenprivate='ssh-keygen -t rsa -b 4096 -C "takathemax@gmail.com"'
### function ###
#コマンドを間違えると罵られる設定
function command_not_found_handler(){
  echo "は？$1とか何言ってんの？\nコマンドぐらいちゃんと覚えてよね！バカ！！"
}
# cd したら ls する
cdls(){
  \cd "$@" && ls
}
# base64
##
bs64e(){
  \echo "$@"|base64
}
##
bs64d(){
  \echo "$@"|base64 -D
}
