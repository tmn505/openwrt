define Device/compulab_trimslice
  DEVICE_VENDOR := CompuLab
  DEVICE_MODEL := TrimSlice
  DEVICE_DTS := tegra20-trimslice
  DEVICE_PACKAGES := kmod-leds-gpio kmod-r8169 kmod-rt2800-usb \
	kmod-rtc-em3027 kmod-usb-hid kmod-usb-storage wpad-basic-mbedtls
  UBOOT := trimslice-mmc
endef
TARGET_DEVICES += compulab_trimslice
