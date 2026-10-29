typeset antidote_path=/opt/homebrew/opt/antidote/share/antidote/antidote.zsh
[[ -r "$antidote_path" ]] || antidote_path="$HOME/.antidote/antidote.zsh"
if [[ ! -r "$antidote_path" ]]; then
  print -u2 "zsh: antidote is not installed; skipping plugins"
  unset antidote_path
  return 0
fi

source "$antidote_path"
unset antidote_path

# zsh_plugins.txt から生成する静的ファイルはキャッシュに置く。txt が更新されると再生成される
zstyle ':antidote:bundle' file "$ZDOTDIR/zsh_plugins.txt"
zstyle ':antidote:static' file "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh_plugins.zsh"
zstyle ':antidote:bundle' use-friendly-names on

function _zsh_plugins_without_atuin() { ! (( $+commands[atuin] )) }

antidote load
_bind_history_substring_search
