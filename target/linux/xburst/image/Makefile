# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021-2022 Tomasz Maciej Nowak <tmn505@gmail.com>

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

define Build/cloner
	rm -R -f $@.cloner
	mkdir -p \
		$@.cloner/configs/$(call tolower,$(SOC)) \
		$@.cloner/ddrs/$(shell awk -F',' '/^current_type/ {gsub(/"/,"",$$2); printf $$2}' $(DEVICE_NAME).cfg) \
		$@.cloner/firmwares \
		$@.cloner/images
	$(CP) $(STAGING_DIR_HOST)/share/cloner/configs/*.cfg \
		$@.cloner/configs
	$(CP) $(DEVICE_NAME).cfg \
		$@.cloner/configs/$(call tolower,$(SOC))
	$(CP) $(STAGING_DIR_HOST)/share/cloner/ddrs/ddr.cfg \
		$@.cloner/ddrs
	$(CP) $(STAGING_DIR_HOST)/share/cloner/ddrs/$(shell awk -F',' '/^current_type/ {gsub(/"/,"",$$2); printf $$2}' $(DEVICE_NAME).cfg)/$(shell awk -F'=' '/^current_ddr/ {printf $$2}' $(DEVICE_NAME).cfg) \
		$@.cloner/ddrs/$(shell awk -F',' '/^current_type/ {gsub(/"/,"",$$2); printf $$2}' $(DEVICE_NAME).cfg)
	$(CP) $(STAGING_DIR_HOST)/share/cloner/firmwares/$(call tolower,$(SOC)) \
		$@.cloner/firmwares
	-$(CP) $(UBOOT_PATH) $@.cloner/images/bootloader.bin
	mv -f $@ $@.cloner/images/firmware.bin
	$(SED) \
		'/\[language\]/,+3d; \
		s/^board=.*/board=$(DEVICE_NAME).cfg/; \
		s/^platform=.*/platform="$(PLATFORM_SERIES),$(call tolower,$(SOC))"/; \
		s/^current=.*/current=$(shell printf $(SOC) | tr -d '0123456789')/' \
		$@.cloner/configs/platforms.cfg
	(cd $@.cloner; TZ=UTC $(STAGING_DIR_HOST)/bin/zip -u -9 -p -g -X -r $@ configs ddrs firmwares images;)
endef

define Build/lzo
	$(STAGING_DIR_HOST)/bin/lzop -9 -f -o $@.new $@
	@mv $@.new $@
endef

define Build/xburst-sdcard
	rm -fR $@.boot
	mkdir -p $@.boot

	$(CP) $(IMAGE_KERNEL) $@.boot/uImage

	mkimage -A mips -O linux -T script -C none \
		-n '$(DEVICE_TITLE) OpenWrt bootscript' \
		-d bootscript.txt \
		$@.boot/boot.scr

	$(CP) $@ $@.rootfs

	GUID="$(IMG_PART_DISKGUID)" \
	SIGNATURE="$(IMG_PART_SIGNATURE)" \
	$(SCRIPT_DIR)/gen_image_generic.sh \
		$@ \
		$(CONFIG_TARGET_KERNEL_PARTSIZE) $@.boot \
		$(CONFIG_TARGET_ROOTFS_PARTSIZE) $@.rootfs \
		2048
endef

DTS_DIR := $(DTS_DIR)/ingenic

DEVICE_VARS += PLATFORM_SERIES
define Device/Default
  PROFILES := Default
  BLOCKSIZE := 64k
  DEVICE_DTS = $(1)
  IMAGES := sysupgrade.bin
  IMAGE/sysupgrade.bin = append-kernel | pad-to $$$$(BLOCKSIZE) | append-rootfs | pad-rootfs | append-metadata | check-size
  KERNEL_LOADADDR := 0x80100000
  KERNEL := kernel-bin | append-dtb | lzma | uImage lzma
  SUPPORTED_DEVICES := $(subst _,$(comma),$(1))
endef

define Device/yna_cu1000-neo
  DEVICE_VENDOR := YSH & ATIL
  DEVICE_MODEL := CU1000-Neo
  DEVICE_DTS := cu1000-neo
  DEVICE_PACKAGES := cypress-firmware-43430-sdio kmod-brcmfmac kmod-hwmon-ads7828 \
	kmod-i2c-ingenic kmod-phy-smsc kmod-serial-sc16is7xx-spi kmod-spi-ingenic \
	kmod-stmmac-ingenic wpad-basic-wolfssl
  IMAGE_SIZE := 32512k
  KERNEL := kernel-bin | append-dtb | lzo | uImage lzo
  KERNEL_INITRAMFS := kernel-bin | append-dtb | lzo | uImage lzo
  KERNEL_SIZE := 3072k
endef
TARGET_DEVICES += yna_cu1000-neo

define Device/zoomgo_zx10
  DEVICE_VENDOR := ZoomGo
  DEVICE_MODEL := Media Stick
  DEVICE_ALT0_VENDOR := Damai
  DEVICE_ALT0_MODEL := NW5030
  DEVICE_DTS_DIR := ../dts
  DEVICE_PACKAGES := cypress-firmware-43430-sdio kmod-brcmfmac wpad-basic-wolfssl
  IMAGES += cloner.ingenic factory.bin sdcard.img.gz
  IMAGE/cloner.ingenic = append-kernel | pad-to $$$$(BLOCKSIZE) | append-rootfs | pad-rootfs | check-size 10240k | cloner
  IMAGE/factory.bin = append-kernel | pad-to $$$$(BLOCKSIZE) | append-rootfs | pad-rootfs | check-size 10240k
  IMAGE/sdcard.img.gz = append-rootfs | pad-extra 128k | xburst-sdcard | gzip | append-metadata
  IMAGE_SIZE := 16064k
  KERNEL_SIZE := 8192k
  PLATFORM_SERIES := 0
  SOC := X1000
  UIMAGE_NAME := NW5030
endef
TARGET_DEVICES += zoomgo_zx10

$(eval $(call BuildImage))
