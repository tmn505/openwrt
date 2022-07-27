# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2022 Tomasz Maciej Nowak <tmn505@gmail.com>

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_SOURCE_URL := https://github.com/XBurst/CU1000-Neo.git
PKG_SOURCE_PROTO := git
PKG_SOURCE_VERSION := 86a213097bb4cec7ce8d8f3158a6477806766f1d
PKG_SOURCE_DATE := 2020-01-28
PKG_MIRROR_HASH := fc525a4b47209a06bb171d8fa3555863b83b3ff924403928b7858da907f3cc09

PKG_RELEASE := $(AUTORELEASE)

include $(INCLUDE_DIR)/u-boot.mk
include $(INCLUDE_DIR)/package.mk

define U-Boot/Default
  BUILD_TARGET := xburst
  UBOOT_IMAGE := u-boot-with-spl.bin
endef

define U-Boot/cu1000-neo
  NAME := YSH & ATIL CU1000-Neo
  BUILD_DEVICES := yna_cu1000-neo
  UBOOT_CONFIG := $(1)_uImage_msc0
#  UBOOT_CONFIG := $(1)_uImage_msc0 $(1)_uImage_sfc_nor
endef
UBOOT_TARGETS := cu1000-neo


define Download/ingenic-toolchain
  FILE := $(1)-$(PKG_SOURCE_DATE).tar.xz
  VERSION := 5dc1d872ead8fed8cf0896d79488a19de522a7a5
  PROTO := git
  URL := https://github.com/XBurst/CU1000-Neo.git
  MIRROR_HASH := 6c20d4e624eb50468487624ba78403ccb0844d0b2f4407da334cfc608919b4ef
  SUBDIR := $(1)
endef

define Build/Prepare
	$(eval $(call Download,ingenic-toolchain))
	$(call Build/Prepare/Default,)
	$(TAR) -C $(PKG_BUILD_DIR) -x --strip 1 -f $(DL_DIR)/ingenic-toolchain-$(PKG_SOURCE_DATE).tar.xz
endef

define Build/Configure
endef

define Build/Compile
	$(foreach target,$(UBOOT_CONFIG), \
		$(MAKE) -C $(PKG_BUILD_DIR)/u-boot \
			ARCH=$(LINUX_KARCH) \
			CROSS_COMPILE=$(PKG_BUILD_DIR)/toolchain/bin/mips-linux-gnu- \
			distclean; \
		$(MAKE) -C $(PKG_BUILD_DIR)/u-boot \
			ARCH=$(LINUX_KARCH) \
			CROSS_COMPILE=$(PKG_BUILD_DIR)/toolchain/bin/mips-linux-gnu- \
			$(target); \
		$(CP) $(PKG_BUILD_DIR)/u-boot/$(UBOOT_IMAGE) $(PKG_BUILD_DIR)/uboot-$(BUILD_DEVICES); \
	)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(STAGING_DIR_IMAGE)
	$(CP) $(PKG_BUILD_DIR)/uboot-$(BUILD_DEVICES) $(STAGING_DIR_IMAGE)/.
endef

define Package/u-boot/install
endef

$(eval $(call BuildPackage/U-Boot))
