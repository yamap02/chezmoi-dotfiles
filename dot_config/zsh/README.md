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
