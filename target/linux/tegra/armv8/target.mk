ARCH := aarch64
BOARDNAME := NVIDIA Tegra ARMv8
CPU_TYPE := cortex-a57
FEATURES += usbgadget
KERNELNAME := Image dtbs

define Target/Description
	Build firmware images for NVIDIA Tegra ARMv8 SoC based boards.
endef
