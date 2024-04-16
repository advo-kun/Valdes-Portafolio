@echo off
:: Configurar la ruta al ejecutable VBoxManage
set /p VBOXMANAGE="Introduce la ruta completa a VBoxManage.exe (ej. D:\Archivos y programas\virtual box\VBoxManage.exe): "

:: Asegurarse de que las comillas están correctamente configuradas para la variable VBOXMANAGE
SET VBOXMANAGE="%VBOXMANAGE%"

:: Configurar el nombre de la máquina virtual eliminando espacios adicionales al principio y al final
set /p VM_NAME="Introduce el nombre de la máquina virtual (ej. openwrt-proyecto): "
set VM_NAME=%VM_NAME: =%

:: Solicitar el rango de adaptadores de red a configurar
set /p NIC_START="Introduce el número inicial del adaptador de red a configurar : "
set /p NIC_END="Introduce el número final del adaptador de red a configurar : "

:: Validar que los números introducidos son enteros y lógicos
if "%NIC_START%" LSS "1" (
    echo Número inicial no válido. Estableciendo en 1 por defecto.
    set NIC_START=1
)
if "%NIC_END%" LEQ "%NIC_START%" (
    echo Número final no válido. Debe ser mayor que el número inicial.
    set NIC_END=%NIC_START%
)

:: Comenzar la configuración de las interfaces de red
echo Configurando las interfaces de red desde NIC %NIC_START% hasta NIC %NIC_END%...

:: Bucle para configurar cada interfaz de red en el rango especificado
for /l %%i in (%NIC_START%,1,%NIC_END%) do (
   %VBOXMANAGE% modifyvm "%VM_NAME%" --nic%%i intnet
   if errorlevel 1 (
       echo Error configurando NIC %%i
   ) else (
       echo NIC %%i configurada como 'intnet'.
   )
)

:: Pausar la ejecución para que el usuario vea el resultado
pause

