# CalculiX-Builder
## About
本ツールはCalculiXのビルドを簡単に行うためのツールです。
コンフィグレーションにより、ExodusII出力、IntelMKL(PARDISO)、SX-Aurora対応の
実行モジュールを作成可能です。

- [CalculiX](http://www.calculix.de/)
- [CalculiX-extras](https://www.openaircraft.com/calculix-extras/)

## Build
### 1. 依存パッケージのインストール
#### 1.1 ビルドツールおよびBLAS/LAPACKのインストール(必須)
- Ubuntu: 以下のパッケージをインストール
```
% sudo apt install git make patch libblas-dev liblapack-dev
```
- CentOS7: 以下のパッケージをインストール
```
% sudo yum install git make patch epel-release atlas-devel lapack-devel blas-devel
```
- AlmaLinux 8: 以下のパッケージをインストール
```
% sudo dnf install git make patch
% sudo dnf install --enablerepo=powertools lapack-devel blas-devel
```

#### 1.2 PARDISO(Intel-MKL)のインストール(Optional)
現在Intel-MKLは、Intel® oneAPI Base Toolkit の一部として提供されています。
[Get the Intel® oneAPI Base Toolkit](https://www.intel.com/content/www/us/en/developer/tools/oneapi/base-toolkit-download.html)よりインストールしてください。

#### 1.3 ExodusIIのインストール(Optional)
- Ubuntu: 以下のパッケージをインストール
```
% sudo apt install libexodusii5 libexodusii-dev
```
- CentOS: 以下のパッケージをインストール
```
% sudo yum install exodusii exodusii-devel
```

- AlmaLinux 8: RPMパッケージなし

#### 1.4 preCICEインストール(Optional)
[preCICE公式の手順](https://github.com/precice/precice/wiki/Building:-Using-CMake)にてインストールする。
現状本ビルダーで対応しているバージョンはpreCICE v2.xです。

### 2. CalculiX-Builder ソースの取得
CalculiX-Builder及びパッチのベースとなるccx 及び前提ライブラリ(ARPACK, SPOOLES)のソースを取得します。
```
% git clone https://github.com/ISCPC/CalculiX-Builder.git
% cd ~/CalculiX-Builder
% git submodule update --init --recursive
```

### 3. Makefileの設定
使用したい機能に合わせてMakefileを修正します。
- `WITH_EXODUSII={true|false}`  : ExodusII出力(-o exo)をサポート(libexodus.so が必要)
- `WITH_MKL={true|false}`       : IntelMKL(SOLVER=PARDISO)をサポート(Intel-MKL library が必要)
- `WITH_MKL_STATIC={true|false}`: IntelMKLをstatic linkしたモジュールを作成
- `WITH_PRECICE={true|false}`   : preCICE-adapterを有効にします。

SX-Aurora固有のオプション
- `WITH_AURORA={ture|false}`     : SX-AuroraのVEを用いたソルバ(SOLVER=HETEROSOLVER,CGONVE)をサポート

また、PREFIXにより作成した実行モジュール・ライブラリのインストール先を指定可能です。
(defaultは/opt/local配下)

### 4. ビルド
```
% make
```
マルチコアで並列ビルドをする場合は以下。

```
% make NPROCS=<number of cores>
```

## Install
```
% make install
```
