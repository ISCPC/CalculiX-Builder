# CalculiX-Builder
## About
This is a tool for building Calculix-ccx module more easily.
You can enable additional functions such as ExodusII output, IntelMKL(PARDISO)
or SX-Aurora suport by configuration.

- [CalculiX](http://www.calculix.de/)
- [CalculiX-extras](https://www.openaircraft.com/calculix-extras/)

## Build
### 1. Install dependent package
#### 1.1 Install BLAS/LAPACK \[Required\]
- Ubuntu: Install following packages
```
% sudo apt install libblas-dev liblapack-dev
```
- CentOS: Install following packages
```
% sudo yum install epel-release atlas-devel lapack-devel blas-devel
```

#### 1.2 Install PARDISO(Intel-MKL) \[Optional\]
Install Intel-MKL packages by following URL.
- apt(Debian, Ubuntu, Linux Mint, ...): [Installing Intel® Performance Libraries and Intel® Distribution for Python Using APT Repository](https://software.intel.com/content/www/us/en/develop/articles/installing-intel-free-libs-and-python-apt-repo.html)
- rpm(RedHat, CentOS, ...): [Installing Intel® Performance Libraries and Intel® Distribution for Python Using YUM Repository](https://software.intel.com/content/www/us/en/develop/articles/installing-intel-free-libs-and-python-yum-repo.html)

#### 1.3 Install ExodusII \[Optional\]
- Ubuntu: Install following packages
```
% sudo apt install libexodusii5 libexodusii-dev
```
- CentOS: Install following packages
```
% sudo yum install exodusii exodusii-devel
```

#### 1.4 Install preCICE \[Optional\]
Install preCICE by [instruction on the preCICE official site](https://github.com/precice/precice/wiki/Building:-Using-CMake).
Currently, this Builder supports Only preCICE v2.x.

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
- `WITH_MKL_STATIC={true|false}`: Link IntelMKL statically
- `WITH_PRECICE={true|false}`   : preCICE-adapter support

SX-Aurora specific options:
- `WITH_AURORA={ture|false}`     : solvers using SX-Aurora VE (SOLVER=HETEROSOLVER,CGONVE)
- `WITH_AURORA_AVEO={ture|false}`: Use[AVEO](https://github.com/SX-Aurora/aveo) instead of VEO \[Experimental\]
- `AVEOPATH=[AVEO install path]` : Specify AVEO library path \[Experimental\]

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
