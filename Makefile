# Makefile for ccx with PARDISO

CCX_CMD = src/ccx_2.16_MT

ARPACKLIB = lib/ARPACK/libarpack_INTEL.a
SPOOLESLIB = lib/SPOOLES/spooles.a lib/SPOOLES/MT/src/spoolesMT.a

OPTS = WITH_EXODUSII=true
OPTS += WITH_MKL=true WITH_MKL_STATIC=false
OPTS += WITH_AURORA=false WITH_AURORA_AVEO=false AVEOPATH=$(HOME)/local

#CC=gcc-4.8
#FC=gfortran-4.8
#OPTS += CC=$(CC) FC=$(FC)

all: $(CCX_CMD)

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

clean:
	rm -rf src
