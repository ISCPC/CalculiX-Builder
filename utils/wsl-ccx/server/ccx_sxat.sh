#!/bin/bash

# For Release version
DISTROOT=${HOME}/local

# For Testing version
#DISTROOT=../..

# Set Command version
CCX_SUFFIX=2.19_MT

if [ $# -gt 0 ]
then
    INPFILE=$1
    shift
fi

if [ "${EXODUS}" = "yes" ]
then
    CMD_OPT="-o exo"
fi

echo "### Solve ${INPFILE} with ${CMD} ###"
echo "OMP_NUM_THREADS=${OMP_NUM_THREADS}"
echo "CCX_REMOTE_DIR=${CCX_REMOTE_DIR}"

# Set Command/Library Path
CMDPATH=${DISTROOT}/bin
export VESOLVER_PATH=${DISTROOT}/ve/lib/libvesolver.so

export LD_LIBRARY_PATH=/opt/intel/oneapi/compiler/latest/linux/compiler/lib/intel64_lin:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=/opt/intel/oneapi/mkl/latest/lib/intel64:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=${DISTROOT}/lib:${LD_LIBRARY_PATH}
export VE_LD_LIBRARY_PATH=${DISTROOT}/ve/lib:${VE_LD_LIBRARY_PATH}
#export VEORUN_BIN=/opt/nec/ve/veos/libexec/aveorun

export PATH=/opt/nec/ve/bin:${PATH}
source /opt/nec/ve/nlc/2.0.0/bin/nlcvars.sh
source /opt/nec/ve/mpi/2.5.0/bin/necmpivars.sh

# Run Solver
cd ${CCX_REMOTE_DIR}
${CMDPATH}/ccx_${CCX_SUFFIX} ${INPFILE} ${CMD_OPT}
