typeset -g ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"

for zsh_config in environment base function alias bindkey plugins completion external_tool_init; do
  typeset zsh_config_path="$ZDOTDIR/$zsh_config.zsh"
  [[ -r "$zsh_config_path" ]] || {
    print -u2 "zsh: missing config: $zsh_config_path"
    return 1
  }
  source "$zsh_config_path"
done
