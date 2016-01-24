# Twitter Bot for DoorKeeper

## このスクリプトでできること
### twbot.rb
* Doorkeeperのグループを指定して開催予定のイベントをつぶやく

### eventChecker.rb
* Doorkeeperのグループを指定して開催予定のイベントをYAMLでファイルに保存する
    * イベント当日の締め切り後に開催中のイベントを告知する際に情報を利用できるようにするため

## 動作環境(確認済み)
* Ruby 2.1
* Gem
    * bundler (1.11.0)
    * Twitter (5.15.0)
    * dotenv (2.0.2)

## 利用方法
* .envファイルに各種情報を記載する
    * TwitterのアプリAPI
    * Doorkeeperで検索するグループ名(グループIDでも可)
    * イベント名とハッシュタグを対応させるYAMLファイルを指定（オプション）
    * 告知時につけるランダムメッセージのYAMLファイルを指定（オプション）
        * YAMLファイルはローカルのファイルもしくはGithubなどのRaw表示用URLなどが利用可能

* bundleコマンドを利用して必要なGemをインストールする
* Cronを利用して定期的につぶやかせる
    * 例(毎週水曜日の9,12,17,21時0分につぶやく)
        * 0 9,12,17,21 * * 3 /bin/bash -lc 'path/to/twbot.rb'

## License
This software is released under the MIT License, see LICENSE.txt.

このソフトウェアはMIT Licenseの元で公開されています、LICENSE.txtをご覧ください