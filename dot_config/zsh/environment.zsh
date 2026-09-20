# Interactive-only environment and integrations.
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 60% --reverse --border --bind=ctrl-j:down,ctrl-k:up'
export FZF_ALT_C_COMMAND='fd --type=d --hidden --follow --exclude=.git'
export GOPATH="${GOPATH:-$HOME/.go}"
export TERMINFO_DIRS="$HOME/.local/share/terminfo:/usr/share/terminfo"
path=("$HOME/.gem/ruby/3.0.0/bin"(N-/) $path)
export AUTO_NOTIFY_THRESHOLD=30
export AUTO_NOTIFY_IGNORE=(docker man espanso sleep nvim poetry ranger timeshift python tmux htop lazydocker lazygit)
export VBOX_USB=usbfs
if [[ "$OSTYPE" == darwin* ]]; then
  path=(
    /opt/homebrew/opt/openjdk/bin(N-/)
    "$HOME/.antigravity/antigravity/bin"(N-/)
    "$HOME/.antigravity-ide/antigravity-ide/bin"(N-/)
    "$HOME/.lmstudio/bin"(N-/)
    $path
  )
  [[ -r "$HOME/.iterm2_shell_integration.zsh" ]] && source "$HOME/.iterm2_shell_integration.zsh"
fi
[[ -r "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"
