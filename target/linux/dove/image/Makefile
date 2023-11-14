# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2024 Tomasz Maciej Nowak <tmn505@gmail.com>

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

define Build/dove-combined
	rm -f -R $@.boot
	mkdir -p $@.boot

	$(CP) $(IMAGE_KERNEL) $@.boot/uImage

	mkimage -A arm -O linux -T script -C none -a 0 -e 0 \
		-n '$(DEVICE_TITLE) OpenWrt bootscript' \
		-d bootscript.txt \
		$@.boot/boot.scr

	sed -e 's,@PTUUID@,$(IMG_PART_SIGNATURE),' \
		wloader.txt > $@.boot/wloader.cfg

	$(CP) $@ $@.rootfs

	KERNELPARTTYPE="6" \
	SIGNATURE="$(IMG_PART_SIGNATURE)" \
	$(SCRIPT_DIR)/gen_image_generic.sh \
		$@ \
		$(CONFIG_TARGET_KERNEL_PARTSIZE) $@.boot \
		$(CONFIG_TARGET_ROOTFS_PARTSIZE) $@.rootfs \
		2048
endef

define Device/Default
  DEVICE_DTS = dove-$(subst _,-,$(1))
  IMAGES := combined.img.gz
  IMAGE/combined.img.gz := append-rootfs | pad-extra 128k | dove-combined | gzip | append-metadata
  KERNEL_LOADADDR := 0x00008000
  KERNEL_NAME := zImage
  KERNEL := kernel-bin | append-dtb | uImage none
  PROFILES := Default
endef

define Device/wyse_tx0
  DEVICE_VENDOR := Wyse
  DEVICE_MODEL := Tx0 (T10/T50)
  DEVICE_DTS_DIR := ../dts-$(KERNEL_PATCHVER)
  BLOCKSIZE := 64k
  IMAGES += sysupgrade.bin
  IMAGE/sysupgrade.bin := append-kernel | pad-to $$$$(BLOCKSIZE) | append-rootfs | pad-rootfs | append-metadata | check-size 7168k
endef
TARGET_DEVICES += wyse_tx0

$(eval $(call BuildImage))
