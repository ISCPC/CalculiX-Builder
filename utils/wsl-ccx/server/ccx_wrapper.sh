#!/bin/bash
#CCX_REMOTE_HOST=
#CCX_REMOTE_PORT=
#CCX_REMOTE_DIR=

#. /opt/intel/oneapi/setvars.sh
echo "WSLENV=$WSLENV"
echo "OMP_NUM_THREADS=$OMP_NUM_THREADS"
echo "CCX_REMOTE_WORK_DIR=$CCX_REMOTE_WORK_DIR"
echo "CCX_WORK_DIR=$CCX_WORK_DIR"
echo "CCX_DEFAULT_SOLVER=$CCX_DEFAULT_SOLVER"

cd "$CCX_WORK_DIR"

if [ "${CCX_REMOTE_HOST}" = "" ]
then
    if [ -d /opt/intel/oneapi ]
    then
        MKL_PATH=/opt/intel/oneapi/mkl/latest/lib/intel64:/opt/intel/oneapi/compiler/latest/linux/compiler/lib/intel64_lin
    else
        MKL_PATH=/opt/intel/mkl/lib/intel64_lin:/opt/intel/lib/intel64_lin
    fi
    export LD_LIBRARY_PATH=${MKL_PATH}:${LD_LIBRARY_PATH}
    ${HOME}/local/bin/ccx_2.19_MT $1
else
    if [ "${CCX_REMOTE_PORT}" != "" ]
    then
        SSH_OPTIONS="-p ${CCX_REMOTE_PORT}"
    fi
    if [ "${CCX_REMOTE_DIR}" = "" ]
    then
        echo "ERROR: CCX_REMOTE_DIR is not specified."
        exit 1
    fi
    echo "Sending data to ${CCX_REMOTE_DIR}..."
    rsync -e "ssh ${SSH_OPTIONS}" * ${CCX_REMOTE_HOST}:${CCX_REMOTE_DIR}
    ssh -p ${CCX_REMOTE_PORT} ${CCX_REMOTE_HOST} OMP_NUM_THREADS=${OMP_NUM_THREADS} CCX_REMOTE_DIR=${CCX_REMOTE_DIR} CCX_DEFAULT_SOLVER=${CCX_DEFAULT_SOLVER} ./local/bin/ccx_sxat.sh $1
    echo "Collecting result..."
    rsync -e "ssh ${SSH_OPTIONS}" ${CCX_REMOTE_HOST}:${CCX_REMOTE_DIR}/* .
fi
