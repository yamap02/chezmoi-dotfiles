alias quit='exit'
# alias rezsh='exec zsh'

if builtin command -v eza > /dev/null 2>&1; then
  alias e='eza --icons'
  alias ea='eza -a --icons'
  alias el='eza -l --icons'
  alias ela='eza -aal --icons'
  alias et='eza -T -L 3 --icons -I "node_modules|.git|.cache|.venv|__pycache__"'
  alias eta='eza -a -T -L 3 --icons -I "node_modules|.git|.cache|.venv|__pycache__"'
elif builtin command -v exa > /dev/null 2>&1; then
  alias e='exa --icons'
  alias ea='exa -a --icons'
  alias el='exa -l --icons'
  alias ela='exa -aal --icons'
  alias et='exa -T -L 3 --icons -I "node_modules|.git|.cache|.venv|__pycache__"'
  alias eta='exa -a -T -L 3 --icons -I "node_modules|.git|.cache|.venv|__pycache__"'
fi

# alias rm='rm -iv'

# ls
# 標準コマンド名 (ls/cat/wc/grep など) は上書きしない (例外: rm→rmtrash)。
# Claude Code などの非対話実行でも zsh 設定が読まれ、挙動が変わって失敗するため。
alias l='ls -F --color=auto -1'
alias ll='ls -F --color=auto -lh'
alias la='ls -F --color=auto -a'
alias lla='ll -a'
alias ltr='ll -tr'
alias l.='ls -F --color=auto -d .[a-zA-Z]*'
# colorize
# alias grep='grep --color=auto'

# My
# alias r='ranger-cd'
alias r='yazi'
alias lg='lazygit'
alias ld='lazydocker'
# alias S='shutdown -h now'
alias S='sudo shutdown -h now'
alias mkd='mkdir -p'
alias n='nvim'
# alias n='~/nvim.appimage'
alias p='python'
command -v unar >/dev/null 2>&1 && alias un='unar'
##tmux
# alias t='tmux'
# alias ta='tmux a'
# alias tk='tmux kill-server'
# alias tl='tmux list-sessions'
# alias tks='tmux kill-session'
# alias tmux-copy='tmux save-buffer - | pbcopy'
alias unzipS='unzip -Ocp932'  ###shift>utf-8
# alias pa="pipenv shell"
command -v poetry >/dev/null 2>&1 && alias pa="poetry shell"
# alias yayy="yes | yay -Syu ; paccache -r; paccache -ruk0"
# alias ls="exa"
# alias tree="exa"

command -v docker-compose >/dev/null 2>&1 && alias up-d="docker-compose up -d"
command -v docker-compose >/dev/null 2>&1 && alias down="docker-compose down"
# alias diff="colordiff"


alias visudo='env EDITOR=nvim sudo -E visudo'
##git
alias G='git add . && git commit -a --allow-empty-message -m "" && git push'
alias gs='git switch'


# alias diff='diff --color=always -bwB'
# alias less='less -RS --use-color'
command -v rmtrash >/dev/null 2>&1 && alias rm='rmtrash'
# alias rmdir='rmdirtrash'

# chmod
alias 644='chmod 644'
alias 755='chmod 755'
alias 777='chmod 777'

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# Translate-shell
alias ja='trans :ja'
alias en='trans :en'

# Change directory to Parent Dir
alias ..='cd ..'
alias ...='cd ../..'

# Clipboard
# alias pbcopy='xsel --input --clipboard'
# alias pbpaste='xsel --output --clipboard'

# move prompt to bottom of terminal
alias move-buttom='tput cup $(($(stty size|cut -d " " -f 1))) 0 && tput ed'

(command -v batcat > /dev/null 2>&1) && alias bat='batcat'

[[ "$OSTYPE" != darwin* ]] && alias open='xdg-open'

# Linux 専用 (iproute2 / systemd / Arch)。macOS には実体が無いので定義しない
if [[ "$OSTYPE" == linux* ]]; then
  alias R='systemctl reboot -i'
  alias T='sudo timeshift-launcher'
  alias yayyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy="yes | yay -Syu --overwrite \"/usr/lib/node_modules/npm/node_modules/*\" ; paccache -r; paccache -ruk0"
  alias fa='sudo pacman-mirrors --fasttrack && sudo pacman -Syy'
fi

# g++
alias g+='g++ -std=c++17 -g2 -Og -DLOCAL_DEBUG -Wall -Wextra -Wshadow -Wconversion -fsanitize=address,undefined -ftrapv'

# nim
alias nimr='nim cpp --hints:off --run'
alias nimfr='nim cpp -d:release --opt:speed --multimethods:on --warning[SmallLshouldNotBeUsed]:off --hints:off --run'
