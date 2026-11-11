# T3 embeds a dark terminal inside its light UI. Set its ANSI palette explicitly
# so ls, git, prompts and other ANSI applications share readable Sonokai colors.
[[ -n ${T3CODE_PROJECT_ROOT:-} && -t 1 ]] || return 0

function t3_sonokai_colors() {
  local -a palette=(
    2c2e34 fc5d7c 9ed072 e7c664 76cce0 b39df3 76cce0 e2e2e3
    a0a0aa ff8097 b5e18b f0d98a 9bdded cbb7ff 9bdded f4f4f5
  )
  local index
  for index in {1..16}; do
    printf '\e]4;%d;#%s\e\\' "$((index - 1))" "${palette[index]}"
  done
  # Default text and cursor; leave the terminal background to the T3 theme.
  printf '\e]10;#e2e2e3\e\\\e]12;#e2e2e3\e\\'
}

t3_sonokai_colors

# Explicit defaults also cover fzf's 256-color gutter and dimmed matches.
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=fg:#e2e2e3,bg:#2c2e34,hl:#e7c664,fg+:#e2e2e3,bg+:#414550,hl+:#f0d98a,info:#b39df3,prompt:#9ed072,pointer:#fc5d7c,marker:#9ed072,spinner:#76cce0,header:#76cce0,border:#a0a0aa,gutter:#2c2e34"
