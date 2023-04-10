# Cross-Step Terminal ポスター生成ツール
このツールは、たくさんの画像からポスター用テクスチャを生成するツールです。
このツールはRubyで書かれており、RMagickを要求します。

## Requirement
このツールを動かすためには、以下のソフトウェアが必要です。

- Ruby 3.2.0 (2.x系でも動くと思うけど)
- ImageMagick

## Installation
1. リポジトリをクローンする
```shell
git clone https://github.com/JO3QMA/TPoS.git
```

2. Bundle Install
```shell
bundle install
```

3. 設定ファイルを編集
```shell
vi config.yml
```

## Usage
`source`フォルダーに画像を入れ、以下のコマンドを実行することで、ポスターが生成されます。
```shell
ruby main.rb
```

## License
MIT License

## Author
JO3QMA