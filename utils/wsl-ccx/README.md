### About
wsl-ccs is sample scripts to use CalculiX-ccx solver on WSL as PrePomax solver.
Furthermore, it inculues sample codes to use CaclculiX-ccx on an external server on cloud service.
wsl-ccx is consist of following three componets.

!!!Notice!!! wsl-ccs works ONLY with WSL2. It doesn't work with WSL1.

1) wsl-ccx.bat
   A batch script to call ccx_wapper.sh on WSL from PrePoMax. It runs on Windows.

2) ccx_wrapper.sh
   A Wrapper script to call ccx solver on WSL or on external server.

3) ccx_sxat.sh(optional)
   A script for external sever on which ccx solver run. It is used if you want to use ccx sovler on external server via the internet. 
   This script is an example script to call VE-supported ccx on SX-Aurora TSUBASA.

### Usage
#### Case 1: Use CalculiX-ccx on WSL2 
1. Put client/wsl-ccx.bat to arbitary place. Set following parameters in "Tools"->"CalculiX" on PrePoMax.
  - Set the path to wsl-ccx.bat by full-path in "CalculiX: Executable"
  - (Optional)Set "Number of preocesses"(default:1)
  - (Optional)Add the following variable in "Parallelization: Environment variables" 
      WSL_NAME: WSL instance name to use(If not set, the default instance is used.)

2. Put server/ccx_wrapper.sh into ~/local/bin on WSL.

#### Case 2: Use CalculiX-ccx on external server (e.g. SX-Aurora TSUBASA)
1. Confirm to be able to connect external server with ssh without password.
2. Put client/wsl-ccx.bat to arbitary place. Set following parameters in "Tools"->"CalculiX" on PrePoMax.
  - Set the path to wsl-ccx.bat by full-path in "CalculiX: Executable"
  - (Optional)Set "Number of preocesses"(default:1)
  - Add the following variable in "Parallelization: Environment variables" 
      WSL_NAME: WSL instance name to use(If not set, the default instance is used.)
      CCX_REMOTE_HOST: Hostname of external server (Set as user@hostname format)
      CCX_REMOTE_PORT: Port number for SSH connection to external server(optional)
      CCX_REMOTE_DIR: Work directory on external server
      CCX_DEFAULT_SOLVER: Default selver name(optional)
3. Put server/ccx_wrapper.sh into ~/local/bin on WSL2.
4. Put server/ccx_sxat.sh into ~/local/bin on external server.
   Please fix ccx_sxat.sh for the environment of your external server such as:
   - ccx version
   - SDK version (if you use VE-supported ccx)
   - Path to Intel-MKL (if you use PARDISO supported ccx)


### TIPS
#### How to setup ssh connection without password
This is how to setup ssh to connect external server from wsl2 without password.

```
$ ssh-keygen
（Press ENTER for all questions)
$ ssh-copy-id <Hostname or IP adderess to external server>
（Enter password to login external server)
```

if you cannot access your server directly, add the contents in ~/.ssh/id_rsa.pub
to ~/.ssh/authorized_keys on your external server manually.

#### How to use SSH portforwading for the server which needs to access via gateway
You can use SSH portforwarding to connect your external server which needs to access via gateway server. This is an example to establish SSH portforwarding connection.

1) Establish SSH portfording connection with ssh command on WSL.
```
$ ssh <hostname or IP address of gateway> -L 10022:<hostname or IP address of external server>:22
```

2) During ssh command above is working, you can connect external server directly from another WSL terminal with following command.

```
$ ssh <username>@localhost:10022
```
