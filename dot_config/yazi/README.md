# yazi config

`ranger` から `yazi` へ移行するための最小構成です。主対象は `keymap.toml` で、`ranger/rc.conf` で日常的に使っていた移動・選択・コピー/カット・検索・タブ・ソート・ディレクトリジャンプを `yazi` に寄せています。キーマップ以外も、どこまでを明示設定し、どこからを既定値に委ねるかを追跡しやすいようにしています。

## ファイル構成

- `yazi.toml`: キーマップ以外の既定値を明文化するためのメモを置いています。挙動を変える設定はまだ追加していません。
- `keymap.toml`: `ranger` の主要キーマップ移植先です。
- `plugins/smart-enter.yazi/main.lua`: `ranger` の `l` / `Enter` に近づけるため、ディレクトリなら入る・ファイルなら開く `smart-enter` をローカル実装しています。
- `tests/test_keymap.py`: 主要キーマップが壊れていないかを確認する回帰テストです。
- `../zsh/function.zsh`: `yazi` 終了後にターミナル側も移動先ディレクトリへ追従させる shell wrapper です。

## 反映した主な互換

- 移動: `h/j/k/l`, `H/L`, `J/K`, `<Enter>`
- 検索と絞り込み: `/`, `n`, `N`, `f`
- 選択: `<Space>`, `v`, `uv`, `V`, `uV`
- コピー系: `yy`, `dd`, `pp`, `dD`, `cw`
- パスコピー: `yp`, `yd`, `yn`, `y.`
- タブ: `gn`, `gc`, `<Tab>`, `<BackTab>`
- ソートと表示: `on`, `om`, `os`, `or`, `zh`, `<C-h>`
- ジャンプ: `gh`, `ge`, `gu`, `gd`, `gl`, `go`, `gv`, `gm`, `gM`, `gs`, `gr`, `g/`

## 既定値を明文化

根拠は Yazi 公式の configuration overview と shipped tag の preset files です。

- Docs overview: `https://yazi-rs.github.io/docs/configuration/overview/`
- Default preset root: `https://github.com/sxyazi/yazi/tree/shipped/yazi-config/preset`
- General defaults: `yazi-default.toml`
- Key defaults: `keymap-default.toml`

`font family` / `font size` / `line height` は、公式の `yazi.toml` 設定項目に存在しないため、Yazi ではなくターミナルエミュレータ側の設定に従います。これは公式 docs からの推論で、`yazi` 側では上書きしていません。

現在このディレクトリで既定値のまま使っている代表項目:

- `ratio = [1, 4, 3]`
- `sort_by = "alphabetical"`
- `sort_sensitive = false`
- `sort_reverse = false`
- `sort_dir_first = true`
- `sort_translit = false`
- `linemode = "none"`
- `show_hidden = false`
- `show_symlink = true`
- `scrolloff = 5`
- `wrap = "no"`
- `tab_size = 2`
- `max_width = 600`
- `max_height = 900`
- `image_delay = 30`
- `image_filter = "triangle"`
- `image_quality = 75`

配色・アイコン・プレビュー見た目は `theme.toml` を作っていないため、公式 shipped preset の dark/light theme 既定値をそのまま使います。

キーマップは `keymap.toml` で `prepend_keymap` を使っているため、ここで明示していないキーは公式 shipped preset の `keymap-default.toml` を維持します。つまり custom key は既存 default keymap の前に差し込まれ、未定義キーを潰しません。

現在も有効な公式 default keymap の代表例:

- `q`: quit
- `o` / `O`: open / open interactive
- `y` / `x` / `p`: yank copy / yank cut / paste
- `.`: hidden toggle
- `s` / `S`: search via `fd` / `rg`
- `z` / `Z`: plugin `fzf` / `zoxide`
- `,a` `,n` `,m` `,s`: alphabetical / natural / mtime / size sort
- `t`, `1..9`, `[` / `]`: tab create, numbered tab switch, previous/next tab

- 独自差分: 明示的に変更しているのは `keymap.toml` と `plugins/smart-enter.yazi/main.lua` のみです。

font size のような表示系を変更したくなった場合は、まず `yazi` ではなく使用中のターミナルエミュレータ側設定を見ます。そのうえで Yazi 側にも設定を追加したら、この節と `yazi.toml` のメモを同時に更新します。

## 未移植のもの

`ranger` 独自の bookmark 永続化、`uq` の closed-tab restore、`gL` の hovered path 追従、task view の詳細な操作、`bulkrename` 入力カーソル位置の完全再現まではまだ入れていません。必要ならここから追加します。

## テスト

```sh
python3 /Users/user/.config/yazi/tests/test_keymap.py
```
