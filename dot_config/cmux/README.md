# cmux 設定

このディレクトリは cmux のグローバル設定を管理します。

## 方針

- cmux の現行標準ファイル `cmux.json` と公式スキーマを使用する
- 最小モードと控えめな通知で、ローカル開発の視認性を保つ
- URL は cmux 内蔵ブラウザへ横取りせず、macOS の既定ブラウザで開く
- ペイン移動は `Command+Option+矢印`、タブ移動は `Command+J/K` を使う
- cmux 再起動時に AI エージェントを自動実行しない

`cmux.json` のスキーマは cmux upstream の現行スキーマを参照します。

