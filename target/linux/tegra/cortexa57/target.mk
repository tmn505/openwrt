ARCH := aarch64
BOARDNAME := NVIDIA Tegra Cortex-A57
CPU_TYPE := cortex-a57
FEATURES += usbgadget
KERNELNAME := Image dtbs

define Target/Description
	Build firmware images for NVIDIA Tegra Cortex-A57 based boards.
endef
