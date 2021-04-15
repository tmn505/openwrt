# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021-2022 Tomasz Maciej Nowak <tmn505@gmail.com>

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

define Build/xburst-sdcard
	rm -fR $@.boot
	mkdir -p $@.boot

	$(CP) $(IMAGE_KERNEL) $@.boot/uImage

	mkimage -A mips -O linux -T script -C none \
		-n '$(DEVICE_TITLE) OpenWrt bootscript' \
		-d bootscript.txt \
		$@.boot/boot.scr

	$(CP) $@ $@.rootfs

	SIGNATURE="$(IMG_PART_SIGNATURE)" \
	$(SCRIPT_DIR)/gen_image_generic.sh \
		$@ \
		$(CONFIG_TARGET_KERNEL_PARTSIZE) $@.boot \
		$(CONFIG_TARGET_ROOTFS_PARTSIZE) $@.rootfs \
		2048
endef

DTS_DIR := $(DTS_DIR)/ingenic

define Device/Default
  PROFILES := Default
  BLOCKSIZE := 64k
  DEVICE_DTS_DIR := ../dts
  DEVICE_DTS = $(1)
  KERNEL_LOADADDR := 0x80100000
  KERNEL := kernel-bin | append-dtb | lzma | uImage lzma
  KERNEL_INITRAMFS := kernel-bin | append-dtb | lzma | uImage lzma
  SUPPORTED_DEVICES := $(subst _,$(comma),$(1))
endef

define Device/zoomgo_zx10
  DEVICE_VENDOR := ZoomGo
  DEVICE_MODEL := Media Stick
  DEVICE_ALT0_VENDOR := Damai
  DEVICE_ALT0_MODEL := NW5030
  DEVICE_PACKAGES := cypress-firmware-43430-sdio kmod-brcmfmac kmod-fs-vfat wpad-basic-wolfssl
  IMAGES := factory.bin sysupgrade.bin sdcard.img.gz
  IMAGE/factory.bin = append-kernel | pad-to $$$$(BLOCKSIZE) | append-rootfs | pad-rootfs | check-size 10240k
  IMAGE/sysupgrade.bin = append-kernel | pad-to $$$$(BLOCKSIZE) | append-rootfs | pad-rootfs | append-metadata | check-size
  IMAGE/sdcard.img.gz = append-rootfs | pad-extra 128k | xburst-sdcard | gzip | append-metadata
  IMAGE_SIZE := 16064k
  KERNEL_SIZE := 8192k
  UIMAGE_NAME := NW5030
endef
TARGET_DEVICES += zoomgo_zx10

$(eval $(call BuildImage))
