# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (c) 2022 Tomasz Maciej Nowak <tmn505@gmail.com>

define KernelPackage/phy-ingenic-usb
  SUBMENU := $(USB_MENU)
  TITLE := Ingenic SoCs USB PHY
  DEPENDS := @!LINUX_5_15
  CONFLICTS := kmod-usb-phy-ingenic
  KCONFIG := CONFIG_PHY_INGENIC_USB
  FILES := $(LINUX_DIR)/drivers/phy/ingenic/phy-ingenic-usb.ko
  AUTOLOAD := $(call AutoLoad,21,phy-ingenic-usb,1)
endef

define KernelPackage/phy-ingenic-usb/description
  Supports Ingenic SoC USB PHY starting from JZ4770.
endef

$(eval $(call KernelPackage,phy-ingenic-usb))


define KernelPackage/usb-phy-ingenic
  SUBMENU := $(USB_MENU)
  TITLE := Ingenic USB PHY
  DEPENDS := @LINUX_5_15||LINUX_6_1 +kmod-usb-core
  KCONFIG := CONFIG_JZ4770_PHY
  FILES := $(LINUX_DIR)/drivers/usb/phy/phy-jz4770.ko
  AUTOLOAD := $(call AutoLoad,21,phy-jz4770,1)
endef

define KernelPackage/usb-phy-ingenic/description
  Supports Ingenic SoC USB PHY starting from JZ4770.
endef

$(eval $(call KernelPackage,usb-phy-ingenic))
