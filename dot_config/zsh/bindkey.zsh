# Emacs 風のキーバインドを使用 (他に Vim 風もある)
bindkey -e

function ghq-fzf() {
  local src root
  src="$(ghq list | fzf)" || return
  if [ -n "$src" ]; then
    root="$(ghq root)" || return
    BUFFER="cd -- ${(q)root}/${(q)src}"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^g' ghq-fzf

# Shift+Tab で前の選択肢へ移動
bindkey '^[[Z' reverse-menu-complete
bindkey -s '^O' 'ranger-cd\n'

bindkey '^f' forward-word
# bindkey '^b' fbr
# bindkey '^[[F' forward-char
bindkey "^[[3~" delete-char #Del
bindkey "^[[1~" beginning-of-line #Home
bindkey "^[[4~" end-of-line # End

# "^S" history-incremental-search-forward
bindkey -r "^S"

function _bind_history_substring_search() {
  (( $+widgets[history-substring-search-up] )) || return 0
  [[ -n "$terminfo[kcuu1]" ]] && bindkey -M emacs "$terminfo[kcuu1]" history-substring-search-up
  [[ -n "$terminfo[kcud1]" ]] && bindkey -M emacs "$terminfo[kcud1]" history-substring-search-down
  bindkey -M emacs '^N' history-substring-search-down
}
_bind_history_substring_search

# Cmd-P (Ghostty が Ctrl-P として送信): 入力先頭に一致する履歴を遡る
bindkey -M emacs '^p' history-beginning-search-backward
