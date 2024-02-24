# CalculiX for SX-Aurora TSUBASA
## 1. About
本ドキュメントは、CalculiXをSX-Aurora TSUBASA上で動作させる方法を説明します。

## 2. Build & Install
### 2.1 vesolverのインストール
vesolverを以下からダウンロードして、任意のディレクトリに展開します。
(以下の例では、~/local配下に展開)
```
% wget https://github.com/ISCPC/vesolver/releases/download/Release_20240224_beta/vesolver_20240224_beta.tar.gz
% cd ~/local
% tar xf <Path to vesolver>/vesolver_20240224_beta.tar.gz
```

### 2.2 VEsolver対応版ccxのインストール
[README.md](https://github.com/ISCPC/CalculiX-Builder/blob/develop/README.md)参照。

SX-Aurora固有のオプションは以下になります。
- `WITH_AURORA={ture|false}`     : SX-AuroraのVEを用いたソルバ(SOLVER=SXAT_*)をサポート
- `VESOLVER_PATH=<Path to vesolver>` : 2.1でvesolverを展開したPATH(デフォルト:~/local)

作成されたモジュールは以下にインストールされます。
- ccx_2.21_MT: $(PREFIX)/bin/ccx_2.21_MT


### 2.3 rccxのインストール(Optional)
rccxを使用することで、PrePoMax等Windows上のアプリケーションからネットワーク経由で
SX-Aurora TSUBASA上のccxを呼び出すことができます。詳細はutils/rccx/READMEを参照。


## 3. Additional Solver for SX-Aurora TSUBASA
SX-Aurora用(WITH_AURORA指定)のccxでは以下の既存のソルバに加え、SX-Aurora TSUBASA
のVE(Vector Engine)を利用した以下のソルバが追加されます。

- SXAT_HS: SX-Aurora TSUBASA用に実装された直接法による大規模疎行列連立1次方程式ソルバである[HeteroSolver](https://www.hpc.nec/documents/sdk/SDK_NLC/UsersGuide/heterosolver/c/ja/index.html)を使用します。
- SXAT_SCALING: CalculiXに実装されている反復法ソルバITERATIVESCALINGをSX-Aurora TSUBASAのVE(Vector Engine)上で高速に実行します。本ソルバは[SBLAS](https://www.hpc.nec/documents/sdk/SDK_NLC/UsersGuide/sblas/c/ja/index.html)を利用することで、ベクトル化+OpenMPによる高速化が図られています。


## 4. Usage
### 4.1 環境設定(各種ライブラリのパス設定等)
指定例)
```
% export PATH=/opt/nec/ve/bin:${PATH}
% source /opt/nec/ve/nlc/2.2.0/bin/nlcvars.sh
% export OMP_NUM_THREADS=8
% export DISTROOT=${HOME}/local   <== vesolverを展開したPATHを指定
% export VESOLVER_PATH=${DISTROOT}/ve/lib/libvesolver.so
% export VE_LD_LIBRARY_PATH=${DISTROOT}/ve/lib:${VE_LD_LIBRARY_PATH}
```


### 4.2 ソルバの指定
使用するソルバの指定は、以下の2つのいずれかの方法で行います。
 
- .inpファイルによる指定方法  
各解析処理記述子のオプションとして、SOLVER=SXAT_HSもしくはSXAT_SCALINGを指定します。

指定例） 
```
** Step-1 ++++++++++++++++++++++++++++++++++++++++++++++++++
*Step
*Static, SOLVER=SXAT_HS
```

- 環境変数による指定方法
環境変数CCX_DEFAULT_SOLVERにSXAT_HSもしくはSXAT_SCALINGを指定します。

指定例） 
```
% export CCX_DEFAULT_SOLVER=SXAT_SCALING
```
