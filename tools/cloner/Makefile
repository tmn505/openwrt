# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (c) 2022 Tomasz Maciej Nowak <tmn505@gmail.com>

include $(TOPDIR)/rules.mk

PKG_NAME := cloner
PKG_VERSION := 2.5.30-ubuntu_alpha

PKG_SOURCE := $(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL := ftp://ftp.ingenic.com.cn/DevSupport/Tools/USBBurner/
PKG_HASH := 6edd9d56b14e306c283d73aa55b33862f5829f0828cf7bcddb9e686c0dacc74a

HOST_BUILD_PARALLEL := 1

include $(INCLUDE_DIR)/host-build.mk

define Host/Compile
endef

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOST)/share/$(PKG_NAME)
	$(CP) \
		$(HOST_BUILD_DIR)/configs \
		$(HOST_BUILD_DIR)/ddrs \
		$(HOST_BUILD_DIR)/firmwares \
		$(STAGING_DIR_HOST)/share/$(PKG_NAME)
endef

define Host/Clean
	rm -f -R $(STAGING_DIR_HOST)/share/$(PKG_NAME)
endef

$(eval $(call HostBuild))
