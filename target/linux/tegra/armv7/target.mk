ARCH := arm
BOARDNAME := NVIDIA Tegra ARMv7
CPU_TYPE := cortex-a9
CPU_SUBTYPE := vfpv3-d16
KERNELNAME := zImage dtbs

define Target/Description
	Build firmware image for NVIDIA Tegra ARMv7 SoC devices.
endef
