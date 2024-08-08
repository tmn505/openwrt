#
# Copyright (C) 2017-2024 Tomasz Maciej Nowak <tmn505@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_VERSION := 2024.04
PKG_RELEASE := 1

PKG_HASH := 18a853fe39fad7ad03a90cc2d4275aeaed6da69735defac3492b80508843dd4a

PKG_MAINTAINER := Tomasz Maciej Nowak <tmn505@gmail.com>

UBOOT_USE_INTREE_DTC := 1

include $(INCLUDE_DIR)/u-boot.mk
include $(INCLUDE_DIR)/package.mk

define U-Boot/Default
  BUILD_TARGET := tegra
  HIDDEN := y
endef

define U-Boot/jetson-tx1
  NAME := NVIDIA Jetson TX1
  BUILD_SUBTARGET := cortexa57
  BUILD_DEVICES := nvidia_jetson-tx1
  UBOOT_CONFIG := p2371-2180
endef
UBOOT_TARGETS += jetson-tx1

define U-Boot/trimslice
  NAME := CompuLab TrimSlice
  BUILD_SUBTARGET := cortexa9
  BUILD_DEVICES := compulab_trimslice
  UBOOT_IMAGE := trimslice-mmc.img trimslice-spi.img
  SOC := tegra20
  VENDOR := compulab
endef
UBOOT_TARGETS += trimslice

define Build/bct-image
	$(CP) $(PKG_BUILD_DIR)/u-boot-dtb-tegra.bin $(PKG_BUILD_DIR)/u-boot.bin
	$(foreach bct,$(basename $(UBOOT_IMAGE)), \
		cd $(PKG_BUILD_DIR); \
		cbootimage -s $(SOC) -gbct \
			$(STAGING_DIR_HOST)/share/cbootimage-configs/$(SOC)/$(VENDOR)/$(VARIANT)/$(bct).bct.cfg \
			$(bct).bct; \
		cbootimage -s $(SOC) \
			$(STAGING_DIR_HOST)/share/cbootimage-configs/$(SOC)/$(VENDOR)/$(VARIANT)/$(bct).img.cfg \
			$(PKG_BUILD_DIR)/$(bct).img; \
		rm -f $(bct).bct; \
	)
endef

define Build/Compile
	$(call Build/Compile/U-Boot)
	$(if $(CONFIG_ARCH_64BIT),,$(call Build/bct-image))
endef

define Build/InstallDev
	$(INSTALL_DIR) $(STAGING_DIR_IMAGE)
	$(foreach img,$(UBOOT_IMAGE), \
		$(CP) $(PKG_BUILD_DIR)/$(img) $(STAGING_DIR_IMAGE)/;)
endef

$(eval $(call BuildPackage/U-Boot))
