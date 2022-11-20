### 概要
wsl-ccxは、PrePoMaxのソルバとしてWSL上で動作するCalculiX-ccxを使用するためのサンプルスクリプト群です。
また、応用例としてWSL経由でクラウド上にある外部の計算サーバ上のCalculiX-ccxを使用する機能も追加してあります。
wsl-ccxは以下の3つのコンポーネントからなります。

!!!注意!!! 本サンプルスクリプトはWSL2のみで動作します。WSL1では正しく動作しません。

1) wsl-ccx.bat
   PrePoMaxからWSL上のccxを呼び出すためのバッチスクリプト

2) ccx_wrapper.sh
   WSL上でccxを呼び出すためのラッパースクリプト

3) ccx_sxat.sh(optional)
   ネットワーク経由で外部の計算サーバに接続する際に、外部サーバ側に置くスクリプト。
   本スクリプトは、外部に設置したSX-Aurora TSUBASA上のVE対応版CalculiXを呼び出す例。

### 使用方法
【使用方法1】WSL2上のCalculiX-ccxを使用する 
1. Windowsの任意の場所に、client/wsl-ccx.batを配置。PrePoMaxの"Tools"->"CalculiX"で以下の設定行う。
  - "CalculiX: Executable"に、wsl-ccx.batをフルパスで指定
  - (Optional)実行時の使用CPUコア数を指定(デフォルトは1)
  - (Optional)"Parallelization: Environment variables"に以下のパラメータを設定する。
      WSL_NAME: 使用するWSL2インスタンス名を指定(省略時にはデフォルトインスタンス使用)

2. server/ccx_wrapper.shをWSL2上の ~/local/bin内に配置。

【使用方法2】外部のサーバ(例えばSX-Aurora TSUBASA)上のCaluliX-ccxを使用する
1. 外部のサーバにwsl2からパスワードなしでssh接続できることを確認する。
2. Windowsの任意の場所に、client/wsl-ccx.batを配置。PrePoMaxの"Tools"->"CalculiX"で以下の設定行う。
  - "CalculiX: Executable"に、wsl-ccx.batをフルパスで指定
  - (Optional)実行時の使用CPUコア数を指定(デフォルトは1)
  - "Parallization: Environment variables" に以下のパラメータを設定する
      WSL_NAME: 使用するWSL2インスタンス名を指定(省略時にはデフォルトインスタンス使用)
      CCX_REMOTE_HOST: 外部サーバのホスト名を user@hostname の形式で指定する。
      CCX_REMOTE_PORT: 外部サーバへのssh接続時のポート番号を指定する(optional)
      CCX_REMOTE_DIR: 外部サーバ上での作業ディレクトリを指定する
      CCX_DEFAULT_SOLVER: デフォルトで使用するソルバを指定する(optional)
3. server/ccx_wrapper.shをWSL2上の ~/local/bin内に配置。
4. server/ccx_sxat.shを外部のサーバ上の~/local/bin内に配置。
   ccx_sxat.shの内容は、外部サーバでのccx動作環境によって適宜修正してください。
   - 使用するccxのバージョン
   - (SX-Aurara TSUBASAの場合)使用するSDKのバージョン
   - (PARDISOを使用する場合)Intel-MKLのライブラリパス


### 参考情報
1. パスワードなしsshでログインできるようにする方法
WSL2環境から、外部サーバへパスワードなしで接続するための設定です。
ssh

```
$ ssh-keygen
（聞いてくる質問には全てENTER)
$ ssh-copy-id <外部サーバのホスト名orIPアドレス>
（外部サーバにログインするためのパスワードを入力）
```

もし、ゲートウェイ越しのアクセス等で直接SSH接続できない場合は、
WSL環境上の~/.ssh/id_rsa.pub を内容を、外部サーバ上の~/.ssh/authorized_keysに
追記して下さい。

2. 外部サーバがゲートウェイサーバ経由での接続が必要な場合
SSHポートフォワーディングを使用することで、ゲートウェイ越しの外部サーバに直接接続できるようにすることが可能です。設定例を以下に示します。

1) WSL2のターミナルから、以下のコマンドでポートフォワーディングを確立します。
```
$ ssh <ゲートウェイのホスト名orIPアドレス> -L 10022:<外部サーバのホスト名orIPアドレス>:22
```

2) 上記が動作している状態で、WSL2の別ターミナルから、以下のコマンドで外部サーバに直接ssh接続できます。

```
$ ssh <username>@localhost:10022
```
