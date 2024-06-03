# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2017-2024 Tomasz Maciej Nowak <tmn505@gmail.com>

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

define Build/tegra-sdcard
	rm -fR $@.boot
	mkdir -p $@.boot
	$(CP) $(KDIR)/$(KERNEL_NAME) $@.boot
	$(if $(DEVICE_DTS),\
		$(foreach dtb,$(DEVICE_DTS),$(CP) $(DEVICE_DTS_DIR)/$(dtb).dtb $@.boot), \
		$(CP) $(DEVICE_DTS_DIR)/*.dtb $@.boot)
	mkimage -A arm -O linux -T script -C none -a 0 -e 0 \
		-n '$(DEVICE_TITLE) OpenWrt bootscript' \
		-d $(SUBTARGET)-bootscript \
		$@.boot/boot.scr
	$(CP) $@ $@.rootfs

	SIGNATURE="$(IMG_PART_SIGNATURE)" \
	$(SCRIPT_DIR)/gen_image_generic.sh \
		$@ \
		$(CONFIG_TARGET_KERNEL_PARTSIZE) $@.boot \
		$(CONFIG_TARGET_ROOTFS_PARTSIZE) $@.rootfs \
		2048

	$(if $(UBOOT),dd if=$(STAGING_DIR_IMAGE)/$(UBOOT).img of=$@ bs=512 skip=1 seek=1 conv=notrunc)
endef

DEVICE_VARS += UBOOT

define Device/Default
  DEVICE_DTS_DIR := $$(DTS_DIR)/nvidia
  IMAGES := sdcard.img.gz
  IMAGE/sdcard.img.gz := append-rootfs | pad-extra 128k | tegra-sdcard | gzip | append-metadata
  KERNEL_NAME := $(if $(CONFIG_ARCH_64BIT),Image,zImage)
  KERNEL := kernel-bin
  PROFILES := Default
endef

include $(SUBTARGET).mk

$(eval $(call BuildImage))
