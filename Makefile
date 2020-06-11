#
# CalculiX-Builder: Build your customized ccx.
#   Currently with:
#   - Intel-MKL(PARDISO) support
#   - ExodusII support imported from https://www.openaircraft.com/calculix-extras/
#   - SX-Aurora support enhanced by ISCPC
#   - preCICE support imported from https://github.com/precice/calculix-adapter
# 

#
# Set install path
#
PREFIX = /opt/local
#PREFIX = $(HOME)/local

#
# Enable/Disable ExodusII support
#
WITH_EXODUSII=true

#
# Enable/Disable Intel-MKL(PARDISO) support
#
WITH_MKL=true
WITH_MKL_STATIC=false

#
# Enable/Disable SX-Aurora support
#
WITH_AURORA=false
WITH_AURORA_AVEO=false
AVEOPATH=$(PREFIX)

#
# Enable/Disable preCICE support
#
WITH_PRECICE=false


#####################################################
# In General, You don't have to touch blow.
#####################################################
OPTS = WITH_EXODUSII=$(WITH_EXODUSII)
OPTS += WITH_MKL=$(WITH_MKL) WITH_MKL_STATIC=$(WITH_MKL_STATIC)
OPTS += WITH_AURORA=$(WITH_AURORA) WITH_AURORA_AVEO=$(WITH_AURORA_AVEO) AVEOPATH=$(AVEOPATH)
OPTS += WITH_PRECICE=$(WITH_PRECICE)

#CC=gcc-4.8
#FC=gfortran-4.8
#OPTS += CC=$(CC) FC=$(FC)

CCX_BIN = ccx_2.16_MT
CCX_CMD = src/$(CCX_BIN)
INSTALL = /usr/bin/install

ARPACKLIB = lib/ARPACK/libarpack_INTEL.a
SPOOLESLIB = lib/SPOOLES/spooles.a lib/SPOOLES/MT/src/spoolesMT.a
ifeq ($(WITH_AURORA),true)
VEOLIBCCX = ccx/velib/libccx/libccx.so
endif

all: $(CCX_CMD) $(VEOLIBCCX)

$(CCX_CMD): lib
	if [ ! -d src ]; then \
		cp -rp ccx/src .; \
		cd src; \
		for p in ../patches/*; do patch -p2 < $$p; done; \
	else \
		cd src; \
	fi; \
	$(MAKE) -j $(NPROCS) -f Makefile_MT $(OPTS)

lib: $(ARPACKLIB) $(SPOOLESLIB)

$(ARPACKLIB):
	cd lib/ARPACK; \
	$(MAKE) WORKDIR=$(PWD)/lib/ARPACK lib

$(SPOOLESLIB):
	cd lib/SPOOLES; \
	$(MAKE) -j ${NPROCS} lib; \
	cd MT; \
	$(MAKE) lib

$(VEOLIBCCX):
	cd ccx/velib/libccx; \
	$(MAKE)

install-veolib:
ifeq ($(WITH_AURORA),true)
	$(INSTALL) -D -t $(PREFIX)/ve/lib $(VEOLIBCCX)
endif

install: install-veolib
	$(INSTALL) -D -t $(PREFIX)/bin $(CCX_CMD)

clean-veolib:
ifeq ($(WITH_AURORA),true)
	cd $(PWD)/ccx/velib/libccx; $(MAKE) clean
endif

clean: clean-veolib
	rm -rf src

clean-all: clean
	rm $(ARPACKLIB); \
	cd $(PWD)/lib/ARPACK; $(MAKE) WORKDIR=$(PWD)/lib/ARPACK clean; \
	cd $(PWD)/lib/SPOOLES; $(MAKE) clean; cd MT; $(MAKE) clean;

