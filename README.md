# TegakiPot-iOS
## How to Contribution
※Synxを使いフォルダ構成が変わっていることもあるので、mergeされた後は必ず最新の状態にしてから編集してください。

### フォルダ構成
フォルダ構成としては
- Utilityフォルダ　... 一般的なユーティリティーファイルを入れています。ライブラリなどに依存せず全体で使いたいファイルはここに入れてください。
- Modelフォルダ ... 自作のライブラリ(?)などを入れていきます。分類ごとにフォルダを作成して何に関するファイルかわかるようにしてください。またクラス名の衝突に注意してください。
- その他 ... 基本的にViewControllerごとにフォルダができています。TableViewやCollectionViewのセルも含まれる場合があります。

### 命名規則
命名規則はクラス・構造体・列挙体名がUpperCamelCase、メソッド・変数・定数などその他の名前をlowerCamelCaseで原則統一します。CamelCaseとは単語ごとに頭文字を大文字にするものです。

### APIについて
APIに関してはWebのJSONの仕様に合わせなければ原則エラーを吐くようになっています。[こちら](https://github.com/xuzijian629/TegakiPot-API/tree/dev)を参考に適宜コメントアウトを解除して使用してください。

### 大まかな流れ
Contributionの大まかな流れは

1. 最新の状態のリポジトリをclone or pull or forkする
2. features/hogeの形式でブランチを切る
3. 変更が終わったらプルリクエストを作成する。

です。コンフリクトが置きた場合の対処も含め、マージはすべてコチラ側で行います。

### Contributor

- @touyou
- @Kinokkory
- @keyhachi
