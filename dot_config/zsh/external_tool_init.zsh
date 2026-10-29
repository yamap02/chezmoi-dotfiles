(command -v pyenv > /dev/null 2>&1) && eval "$(pyenv init --path)"
(command -v direnv > /dev/null 2>&1) && eval "$(direnv hook zsh)"
(command -v starship > /dev/null 2>&1) && eval "$(starship init zsh)"
(command -v rbenv > /dev/null 2>&1) && eval "$(rbenv init -)"
# Ctrl-R を atuin の履歴検索にする。上矢印は history-substring-search のまま使う
(command -v atuin > /dev/null 2>&1) && eval "$(atuin init zsh --disable-up-arrow)"
