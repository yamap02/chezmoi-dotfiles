if [[ ! -r "$HOME/.zinit/bin/zinit.zsh" ]]; then
  print -u2 "zsh: zinit is not installed; skipping plugins"
  return 0
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk


# コマンドラインの色付け
zinit light zdharma/fast-syntax-highlighting

# コマンドラインに入力されている文字列をもとに薄い色でコマンドを提案
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
zinit light zsh-users/zsh-autosuggestions

# Ctrl+x -> Ctrl+b で Git ブランチを表示してインタラクティブに絞り込みして切り替え
# zinit ice wait'!3' lucid atload"bindkey '^x^b' anyframe-widget-checkout-git-branch"

zinit wait'!1' atinit'zpcompinit' lucid light-mode for \
  zsh-users/zsh-completions

zinit wait'!3' lucid light-mode for \
  mollifier/cd-gitroot \
  paulirish/git-open \
  Tarrasch/zsh-bd \
  MichaelAquilina/zsh-auto-notify \
  joshskidmore/zsh-fzf-history-search \
  zsh-users/zsh-history-substring-search
