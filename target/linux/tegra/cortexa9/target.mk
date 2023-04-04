ARCH:=arm
BOARDNAME:=Tegra with Cortex-A9
CPU_TYPE:=cortex-a9
CPU_SUBTYPE:=vfpv3-d16
KERNELNAME:=zImage dtbs

define Target/Description
        Build firmware images for nVIDIA Tegra (Cortex-A9) based boards.
endef
