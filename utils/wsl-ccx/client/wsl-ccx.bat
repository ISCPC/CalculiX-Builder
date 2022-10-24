@echo off

REM check environment variables
set CCX_WORK_DIR=%CD%
set WSLENV=OMP_NUM_THREADS:CCX_REMOTE_WORK_DIR:CCX_WORK_DIR/p:CCX_REMOTE_HOST:CCX_REMOTE_PORT:CCX_REMOTE_DIR:CCX_DEFAULT_SOLVER

if not defined OMP_NUM_THREADS (
	set OMP_NUM_THREADS=1
)

echo CCX_REMOTE_WORK_DIR = %CCX_REMOTE_WORK_DIR%
echo OMP_NUM_THREADS = %OMP_NUM_THREADS%
echo WSL_NAME = %WSL_NAME%

REM Run ccx
if defined WSL_NAME (
	echo "Call ccx on WSL named %WSL_NAME%."
	wsl -d %WSL_NAME% ~/local/bin/ccx_wrapper.sh %1 %OMP_NUM_THREADS% %CCX_REMOTE_WORK_DIR%
) else (
	echo "Call ccx on default WSL environment."
	wsl ~/local/bin/ccx_wrapper.sh %1 %OMP_NUM_THREADS% %CCX_REMOTE_WORK_DIR%
)