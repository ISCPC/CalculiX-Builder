# CalculiX-Builder
## About
本ツールはCalculiXのビルドを簡単に行うためのツールです。
コンフィグレーションにより、ExodusII出力、IntelMKL(PARDISO)、SX-Aurora対応の
実行モジュールを作成可能です。

- [CalculiX](http://www.calculix.de/)
- [CalculiX-extras](https://www.openaircraft.com/calculix-extras/)

## Build
### 1. 依存パッケージのインストール
#### 1.1 BLAS/LAPACKのインストール(必須)
- Ubuntu: 以下のパッケージをインストール
```
% sudo apt install libblas-dev liblapack-dev
```
- CentOS: 以下のパッケージをインストール
```
% sudo yum install epel-release atlas-devel lapack-devel blas-devel
```

#### 1.2 PARDISO(Intel-MKL)のインストール(Optional)
Intelの公式サイトの手順にてインストールする。
- apt(Debian系:Debian, Ubuntu,Linux Mint等): [インストール手順(英文)](https://software.intel.com/content/www/us/en/develop/articles/installing-intel-free-libs-and-python-apt-repo.html)
- rpm(RedHat系:RedHat, CentOS等): [インストール手順(英文)](https://software.intel.com/content/www/us/en/develop/articles/installing-intel-free-libs-and-python-yum-repo.html)

#### 1.3 ExodusIIのインストール(Optional)
- Ubuntu: 以下のパッケージをインストール
```
% sudo apt install libexodusii5 bexodusii-dev
```
- CentOS: 以下のパッケージをインストール
```
% sudo yum install exodusii exodusii-devel
```

### 2. submoduleソースの取得
パッチのベースとなるccx 及び前提ライブラリ(ARPACK, SPOOLES)のソースを取得します。
```
% cd ~/CalculiX-Builder
% git submodule update --init --recursive
```

### 3. Makefileの設定
使用したい機能に合わせてOPTSを修正します。
- `WITH_EXODUSII={true|false}`  : ExodusII出力(-o exo)をサポート(libexodus.so が必要)
- `WITH_MKL={true|false}`       : IntelMKL(SOLVER=PARDISO)をサポート(Intel-MKL library が必要)
- `WITH_MKL_STATIC={true|false}`: IntelMKLをstatic linkしたモジュールを作成
- `WITH_AURORA={ture|false}`    : SX-AuroraのVEを用いたソルバ(SOLVER=HETEROSOLVER,CGONVE)をサポート

### 4. ビルド
```
% make
```
マルチコアで並列ビルドをする場合は以下。

```
% make NPROCS=<number of cores>
```

## Install
任意の場所に以下のファイルをコピー
- `src/ccx_{version}_MT` : ccx実行モジュール
