# CalculiX-Aurora
## About
本ドキュメントは、SX-Aurora上で動作させる方法を説明します。

## Build & Install
### 1. ccxのインストール
[README.md](https://github.com/ISCPC/CalculiX-Builder/blob/develop/README.md)参照。

### 2. libccx.soのインストール
```
% export PATH=/opt/nec/ve/bin:${PATH}
% source /opt/nec/ve/nlc/2.0.0/bin/nlcvars.sh
% cd ccx/velib/libccx
% make
```
任意の場所に以下のファイルをコピーし、CCX_VEO_LIBRARYで置き場所を指定する。
```
% export CCX_VEO_LIBRARY=<Path to libccx.so>/libccx.so
```

### 3. rccxのインストール(Optional)
rccxを使用することで、PrePoMax等Windows上のアプリケーションからネットワーク経由で
SX-Aurora TSUBASA上のccxを呼び出すことができます。詳細はutils/rccx/READMEを参照。


## Usage
- .inpファイルの修正  
各解析処理記述子のオプションとして、SOLVER=HETEROSOLVERもしくはCGONVEを指定する.
指定例）
```
** Step-1 ++++++++++++++++++++++++++++++++++++++++++++++++++
*Step
*Static, SOLVER=HETEROSOLVER
```

現状、SOLVERで指定可能な解析はSTATICのみ。それ以外の解析で指定した場合の動作は不定です。

- 環境変数の設定  
指定例)
```
% export PATH=/opt/nec/ve/bin:${PATH}
% source /opt/nec/ve/nlc/2.0.0/bin/nlcvars.sh
% export CCX_VEO_LIBRARY_PATH=/home/iscpc/lib/libccx.so
% export OMP_NUM_THREADS=12
```
