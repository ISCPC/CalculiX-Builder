//#include <sys/types.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
//#include <signal.h>
//#include <process.h>

#define MAX_STR_LEN 256

int main(int argc, char **argv) {
    pid_t pid;
    int status;

    char *inp_name = "Analysis-1";
    char *ncpu, *ccx_server, *ccx_user, *ccx_cmd, *ccx_solver;
    char cmd[MAX_STR_LEN];

    if (argc > 1) {
        inp_name = argv[1];
    }

    ccx_server = getenv("CCX_SERVER");
    if (ccx_server == NULL) {
        ccx_server = "ccx_server";
    }

    ccx_user = getenv("CCX_USER");
    if (ccx_user == NULL) {
        ccx_user = "guest";
    }

    ccx_cmd = getenv("CCX_CMD");
    if (ccx_cmd == NULL) {
        ccx_cmd = "ccx_wrapper";
    }

    ccx_solver = getenv("CCX_DEFAULT_SOLVER");
    if (ccx_solver == NULL) {
        ccx_solver = "DEFAULT";
    }

    ncpu = getenv("OMP_NUM_THREADS");
    if (ncpu == NULL) {
        ncpu = "1";
    }

    snprintf(cmd, MAX_STR_LEN, "ssh.exe %s@%s %s %s %s %s",
            ccx_user, ccx_server, ccx_cmd, ccx_solver, ncpu, inp_name);
    system(cmd);
}
