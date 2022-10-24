# CalculiX-Builder
## About
This is a tool for building Calculix-ccx module more easily.
You can enable additional functions such as ExodusII output, IntelMKL(PARDISO)
or SX-Aurora suport by configuration.

- [CalculiX](http://www.calculix.de/)
- [CalculiX-extras](https://www.openaircraft.com/calculix-extras/)

## Build
### 1. Install dependent package
#### 1.1 Install build tools and BLAS/LAPACK \[Required\]
- Ubuntu: Install following packages
```
% sudo apt install git make patch libblas-dev liblapack-dev
```
- CentOS: Install following packages
```
% sudo yum install git make patch epel-release atlas-devel lapack-devel blas-devel
```
- AlmaLinux 8: Install following packages
```
% sudo dnf install git make patch
% sudo dnf install --enablerepo=powertools lapack-devel blas-devel
```

#### 1.2 Install PARDISO(Intel-MKL) \[Optional\]
Now, Intel-MKL is a part of Intel® oneAPI Base Toolkit.
Please install from [Get the Intel® oneAPI Base Toolkit][https://www.intel.com/content/www/us/en/developer/tools/oneapi/base-toolkit-download.html]

#### 1.3 Install ExodusII \[Optional\]
- Ubuntu: Install following packages
```
% sudo apt install libexodusii5 libexodusii-dev
```
- CentOS: Install following packages
```
% sudo yum install exodusii exodusii-devel
```
- AlmaLinux 8/RockyLinux 8: No RPM packages

#### 1.4 Install preCICE \[Optional\]
Install preCICE by [instruction on the preCICE official site](https://github.com/precice/precice/wiki/Building:-Using-CMake).
Currently, CalculiX-Builder supports ONLY preCICE v2.x.

### 2. get sources for CalculiX-Builder
Get CalculiX-Builder from this repository and the base ccx sources and required libraries such as ARPACK and SPOOLES as submodules.
```
% git clone https://github.com/ISCPC/CalculiX-Builder.git
% cd CalculiX-Builder
% git submodule update --init --recursive
```

### 3. Edit Makefile
Edit Makefile to enable/disable optional functions.
- `WITH_EXODUSII={true|false}`  : ExodusII Output(-o exo) support(require libexodus.so)
- `WITH_MKL={true|false}`       : IntelMKL(SOLVER=PARDISO) support(require Intel-MKL library)
- `WITH_MKL_STATIC={true|false}`: Link IntelMKL(PARDISO) statically
- `WITH_PRECICE={true|false}`   : preCICE-adapter support

SX-Aurora specific options:
- `WITH_AURORA={ture|false}`     : solvers using SX-Aurora VE (SOLVER=HETEROSOLVER,CGONVE)

You can specify install path by editting PREFIX. By default, the modules are installed under /opt/local.

### 4. Build
```
% make
```

For bulilding with multiple core:

```
% make NPROCS=<number of cores>
```

## Install
```
% make install
```
