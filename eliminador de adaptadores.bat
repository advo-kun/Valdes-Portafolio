@echo off
SET VBOXMANAGE="D:\Archivos y programas\virtual box\VBoxManage.exe"
set VM_NAME=openwrt-proyecto

for /l %%i in (5,1,36) do (
   %VBOXMANAGE% modifyvm "%VM_NAME%" --nic%%i none
   echo NIC %%i eliminado.
)
pause
