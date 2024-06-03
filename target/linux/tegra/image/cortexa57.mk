define Device/nvidia_jetson-tx1
  DEVICE_VENDOR := NVIDIA
  DEVICE_MODEL := Jetson TX1 Developer Kit
  DEVICE_DTS := tegra210-p2371-2180
  DEVICE_PACKAGES := cypress-firmware-4354-sdio kmod-bluetooth kmod-brcmfmac \
	kmod-usb-gadget-serial kmod-usb-hid kmod-usb-net-rtl8152 kmod-usb-udc-tegra \
	kmod-usb-xhci-tegra t210-usb-firmware wpad-basic-mbedtls
  SUPPORTED_DEVICES := nvidia,p2371-2180
endef
TARGET_DEVICES += nvidia_jetson-tx1
