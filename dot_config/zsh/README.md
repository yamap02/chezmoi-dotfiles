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

## zinit

シェル起動時に zinit を clone しません。必要な場合は一度だけインストールします。

```sh
command mkdir -p "$HOME/.zinit"
command git clone https://github.com/zdharma-continuum/zinit.git "$HOME/.zinit/bin"
```

zinit がなければ警告を stderr に表示し、残りのシェル設定は読み込みます。
