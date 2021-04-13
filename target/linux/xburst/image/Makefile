# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021 Tomasz Maciej Nowak <tmn505@gmail.com>

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

define Build/append-md5sum
	dd if=$@ bs=256k count=1 conv=notrunc | $(STAGING_DIR_HOST)/bin/mkhash md5 -N >> $@
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
  DEVICE_PACKAGES := cypress-firmware-43430-sdio kmod-brcmfmac kmod-fs-ext4 kmod-fs-vfat wpad-basic-wolfssl
  IMAGES := factory.bin sysupgrade.bin
  IMAGE/factory.bin = append-kernel | append-rootfs | pad-rootfs | check-size
  IMAGE/sysupgrade.bin = append-rootfs | pad-rootfs | sysupgrade-tar rootfs=$$$$@ | append-metadata | check-size
  IMAGE_SIZE := 10240k
  KERNEL := kernel-bin | append-dtb | lzma | uImage lzma | pad-to 2097120 | append-md5sum
  KERNEL_SIZE := 2048k
  UIMAGE_NAME := NW5030
endef
TARGET_DEVICES += zoomgo_zx10

$(eval $(call BuildImage))
