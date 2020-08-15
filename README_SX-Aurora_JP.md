# CalculiX for SX-Aurora TSUBASA
## 1. About
本ドキュメントは、CalculiXをSX-Aurora TSUBASA上で動作させる方法を説明します。

## 2. Build & Install
### 2.1 ccx及びlibccx.soのインストール
VE上で実行するライブラリ(libccx.so)をビルドするための環境設定を行います。
```
% export PATH=/opt/nec/ve/bin:${PATH}
% source /opt/nec/ve/nlc/2.0.0/bin/nlcvars.sh
```

[README.md](https://github.com/ISCPC/CalculiX-Builder/blob/develop/README.md)参照。
SX-Aurora固有のオプションは以下になります。
- `WITH_AURORA={ture|false}`     : SX-AuroraのVEを用いたソルバ(SOLVER=SX-AUR_*)をサポート
- `WITH_AURORA_AVEO={ture|false}`: 標準のVEOの代わりに[AVEO](https://github.com/SX-Aurora/aveo)を使用
- `AVEOPATH=[AVEO install path]` : AVEOのライブラリがインストールされているパスを指定

作成されたモジュールは以下にインストールされます。
- ccx_2.16_MT: $(PREFIX)/bin/ccx_2.16_MT
- libccx.so: $(PREFIX)/ve/lib/libccx.so

上記以外の場所のlibccx.soを使用したい場合は、CCX_VEO_LIBRARY_PATHで指定可能です。

```
% export CCX_VEO_LIBRARY_PATH=<Path to libccx.so>/libccx.so
```

### 2.2 rccxのインストール(Optional)
rccxを使用することで、PrePoMax等Windows上のアプリケーションからネットワーク経由で
SX-Aurora TSUBASA上のccxを呼び出すことができます。詳細はutils/rccx/READMEを参照。


## 3. Additional Solver for SX-Aurora TSUBASA
SX-Aurora用(WITH_AURORA指定)のccxでは以下の既存のソルバに加え、SX-Aurora TSUBASA
のVE(Vector Engine)を利用した以下のソルバが追加されます。

- SX-AUR_HS: SX-Aurora TSUBASA用に実装された直接法による大規模疎行列連立1次方程式ソルバである[HeteroSolver](https://www.hpc.nec/documents/sdk/SDK_NLC/UsersGuide/heterosolver/c/ja/index.html)を使用します。
- SX-AUR_SCALING: CalculiXに実装されている反復法ソルバITERATIVESCALINGをSX-Aurora TSUBASAのVE(Vector Engine)上で高速に実行します。本ソルバは[SBLAS](https://www.hpc.nec/documents/sdk/SDK_NLC/UsersGuide/sblas/c/ja/index.html)を利用することで、ベクトル化+OpenMPによる高速化が図られています。


## 4. Usage
### 4.1 環境設定(各種ライブラリのパス設定等)
指定例)
```
% export PATH=/opt/nec/ve/bin:${PATH}
% source /opt/nec/ve/nlc/2.0.0/bin/nlcvars.sh
% export CCX_VEO_LIBRARY_PATH=/home/iscpc/lib/libccx.so
% export OMP_NUM_THREADS=8
```

### 4.2 ソルバの指定
使用するソルバの指定は、以下の2つのいずれかの方法で行います。
 
【注意】現状、SOLVERで指定可能な解析はSTATICのみ。それ以外の解析で指定した場合の動作は不定です。

- .inpファイルによる指定方法  
各解析処理記述子のオプションとして、SOLVER=SX-AUR_HSもしくはSX-AUR_SCALINGを指定します。
指定例） 
```
** Step-1 ++++++++++++++++++++++++++++++++++++++++++++++++++
*Step
*Static, SOLVER=SX-AUR_HS
```

- 環境変数による指定方法
環境変数CCX_DEFAULT_SOLVERにSX-AUR_HSもしくはSX-AUR_SCALINGを指定します。
指定例） 
```
% export CCX_DEFAULT_SOLVER=SX-AUR_SCALING
```
