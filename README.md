# Twitter Bot for Histudy

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