# zsh config

日常のシェル操作に使う alias / function をこのディレクトリで管理しています。

## yazi integration

- `function.zsh` の `yazi()` は `command yazi --cwd-file ...` で実バイナリを起動します。
- `yazi` 終了時に `--cwd-file` へ書かれたパスを読み、シェル側の `cwd` をその移動先へ合わせます。
- `alias.zsh` の `r='yazi'` もこの wrapper を通るため、`r` から起動した場合も同じ動作になります。

## test

```sh
zsh /Users/user/.config/zsh/tests/test_yazi_wrapper.zsh
```

## 起動構成

`dot_zshrc` はこのディレクトリを固定順で読み込みます。設定ファイルが
見つからない場合は、起動を続けずエラーを stderr に表示します。

## antidote

プラグインは [antidote](https://github.com/mattmc3/antidote) で管理し、一覧は `zsh_plugins.txt` に書きます。
`zsh_plugins.txt` から生成した静的ファイル (`~/.cache/zsh/zsh_plugins.zsh`) を読むので、
txt を変えない限り起動時にプラグインの解決処理は走りません。

```sh
brew install antidote
antidote update   # プラグインを更新する
```

antidote がなければ警告を stderr に表示し、残りのシェル設定は読み込みます。
読み込み順は `plugins.zsh` → `completion.zsh` です。`zsh-completions` を fpath に足してから compinit します。
`kind:defer` のプラグイン (fzf-tab / autosuggestions / fast-syntax-highlighting) は
起動完了後にこの順で読み込まれます。

## fzf-tab

Tab 補完の候補を fzf で絞り込みます。設定は `completion.zsh` の末尾にあります。

- `<` / `>`: 補完候補のグループを切り替える
- `cd` ではディレクトリの中身、`nvim` / `cat` などではファイルの先頭をプレビューする

## 補完キャッシュ

起動時は `zcompdump` を再利用して、補完定義の安全性チェックを省略します。
補完関数を追加・更新した場合は、次回起動前にキャッシュを削除して再生成します。

```sh
rm -f "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
exec zsh
```

## atuin

Ctrl-R の履歴検索は [atuin](https://atuin.sh/) を使います。設定は `~/.config/atuin/config.toml` です。
上矢印は従来どおり `zsh-history-substring-search` に割り当てています。
atuin が未インストールの環境では `zsh-fzf-history-search` を代わりに読み込みます。

```sh
brew install atuin
atuin import zsh   # 既存の ~/.zsh_history を取り込む (初回のみ)
```
