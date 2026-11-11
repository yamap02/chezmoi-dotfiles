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

# T3 の暗いターミナルで、入力中のコマンドと文字列を Sonokai の色で読みやすくする。
if [[ -n ${T3CODE_PROJECT_ROOT:-} ]] && (( $+functions[zsh-defer] )); then
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#a0a0aa'
  function _t3_sonokai_syntax_colors() {
    (( $+parameters[FAST_HIGHLIGHT_STYLES] )) || return
    local key
    for key in alias suffix-alias builtin function command precommand hashed-command; do
      FAST_HIGHLIGHT_STYLES[$key]='fg=#9ed072'
    done
    for key in single-quoted-argument double-quoted-argument; do
      FAST_HIGHLIGHT_STYLES[$key]='fg=#e7c664'
    done
    for key in single-hyphen-option double-hyphen-option; do
      FAST_HIGHLIGHT_STYLES[$key]='fg=#76cce0'
    done
    FAST_HIGHLIGHT_STYLES[unknown-token]='fg=#fc5d7c,bold'
    FAST_HIGHLIGHT_STYLES[comment]='fg=#a0a0aa'
    FAST_HIGHLIGHT_STYLES[default]='fg=#e2e2e3'
    FAST_HIGHLIGHT_STYLES[reserved-word]='fg=#b39df3'
    FAST_HIGHLIGHT_STYLES[path]='fg=#e2e2e3,underline'
  }
  zsh-defer _t3_sonokai_syntax_colors
fi
