# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2017-2019 Tomasz Maciej Nowak <tmn505@gmail.com>
# Copyright (C) 2022 Koen Vandeputte <koen.vandeputte@citymesh.com>

DEVICE_VARS += BOOT_SCRIPT UBOOT

define Build/tegra-sdcard
	rm -fR $@.boot
	mkdir -p $@.boot
	$(CP) $(KDIR)/$(KERNEL_NAME) $@.boot
	$(if $(DEVICE_DTS),\
		$(foreach dtb,$(DEVICE_DTS),$(CP) $(DTS_DIR)/$(dtb).dtb $@.boot), \
		$(CP) $(DTS_DIR)/*.dtb $@.boot)
	mkimage -A arm -O linux -T script -C none -a 0 -e 0 \
		-n '$(DEVICE_TITLE) OpenWrt bootscript' \
		-d $(BOOT_SCRIPT) \
		$@.boot/boot.scr

	SIGNATURE="$(IMG_PART_SIGNATURE)" \
	$(SCRIPT_DIR)/gen_image_generic.sh \
		$@ \
		$(CONFIG_TARGET_KERNEL_PARTSIZE) $@.boot \
		$(CONFIG_TARGET_ROOTFS_PARTSIZE) $(IMAGE_ROOTFS) \
		2048

	$(if $(UBOOT),dd if=$(STAGING_DIR_IMAGE)/$(UBOOT).img of=$@ bs=512 skip=1 seek=1 conv=notrunc)
endef

define Device/Default
  BOOT_SCRIPT := bootscript-cortexa57
  DTS_DIR := $(DTS_DIR)/nvidia
  KERNEL_NAME := Image
  KERNEL_INSTALL := 1
  KERNEL := kernel-bin
  IMAGES := sdcard.img.gz dtb
  IMAGE/sdcard.img.gz := tegra-sdcard | gzip | append-metadata
  IMAGE/dtb := install-dtb
  PROFILES := Default
endef

define Device/jetson_nano_devkit
  DEVICE_VENDOR := NVIDIA
  DEVICE_MODEL := Jetson Nano
  DEVICE_VARIANT := Development Kit
  DEVICE_DTS := tegra210-p3450-0000
  DEVICE_PACKAGES := kmod-r8169 wpad-basic-mbedtls
endef
TARGET_DEVICES += jetson_nano_devkit
