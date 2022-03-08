# CalculiX for SX-Aurora TSUBASA
## 1. About
This document describes how to use CalculiX on SX-Aurora TSUBASA.

## 2. Build & Install
### 2.1 Install vesolver
Download vesolver library fron following URL and extract it on ~/local.
```
% wget https://github.com/ISCPC/vesolver/releases/download/Release_20220212_beta/vesolver_20220212_beta.tar.gz
% cd ~/local
% tar xf <Path to vesolver>/vesolver_20220212_beta.tar.gz
```

### 2.2 Build and install ccx with SX-Aurora VE support
Refer [README.md](https://github.com/ISCPC/CalculiX-Builder/blob/develop/README.md) for build.

SX-Aurora specific options:
- `WITH_AURORA={ture|false}`     : solvers using SX-Aurora VE (SOLVER=SX-AUR_*)
- `VESOLVER_PATH=<Path to vesolver>` : path to vesolver installed at 2.1. (default: ~/local)

By default, CalculiX-Builder install modules into following path.
- ccx_2.18_MT: $(PREFIX)/bin/ccx_2.18_MT

### 2.3 Install rccx \[Optional\]
Remote ccx(rccx) enables you to use ccx on SX-Aurora TSUBASA from the applications
on your Windows PC such as PrePoMax. Please refer utils/rccx/README.


## 3. Additional Solver for SX-Aurora TSUBASA
Ccx for SX-Aurora, built with WITH_AURORA=true, supports addtional solvers
which uses VE(Vector Engine) on SX-Aurora TSUBASA as follows. 

- SX-AUR_HS: Use [HeteroSolver](https://www.hpc.nec/documents/sdk/SDK_NLC/UsersGuide/heterosolver/c/ja/index.html) which is direct methods solver tuned for SX-Aurora TSUBASA.
- SX-AUR_SCALING: Use iterative solver tuned for SX-Aurora TSUBASA. This solver uses the same algorithm with ITERATIVESCALING solver impletened on the original ccx. But by using [SBLAS](https://www.hpc.nec/documents/sdk/SDK_NLC/UsersGuide/sblas/c/ja/index.html) library on VE, outstanding performance improvement acheived.


## 4. Usage
### 4.1 Configure Environment variables
Example)
```
% export PATH=/opt/nec/ve/bin:${PATH}
% source /opt/nec/ve/nlc/2.2.0/bin/nlcvars.sh
% export OMP_NUM_THREADS=8
% export DISTROOT=${HOME}/local   <== path to directory where you extracted vesolver
% export VESOLVER_PATH=${DISTROOT}/ve/lib/libvesolver.so
% export VE_LD_LIBRARY_PATH=${DISTROOT}/ve/lib:${VE_LD_LIBRARY_PATH}
```

### 4.2 Specify solver

There are two ways to use solvers for SX-Aurora TSUBASA.
 
- By editing .inp file
Add SOLVER=SX-AUR_HS of SX-AUR_SCALING option to procedure description.

Example） 
```
** Step-1 ++++++++++++++++++++++++++++++++++++++++++++++++++
*Step
*Static, SOLVER=SX-AUR_HS
```

- By using environment variable
Set SX-AUR_HS or SX-AUR_SCALING to CCX_DEFAULT_SOLVER

Example） 
```
% export CCX_DEFAULT_SOLVER=SX-AUR_SCALING
```
