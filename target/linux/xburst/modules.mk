# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (c) 2022 Tomasz Maciej Nowak <tmn505@gmail.com>

define KernelPackage/usb-phy-ingenic
  SUBMENU := $(USB_MENU)
  TITLE := Ingenic USB PHY
  DEPENDS := +kmod-usb-core
  KCONFIG := CONFIG_JZ4770_PHY
  FILES := $(LINUX_DIR)/drivers/usb/phy/phy-jz4770.ko
  AUTOLOAD := $(call AutoLoad,21,phy-jz4770,1)
endef

define KernelPackage/usb-phy-ingenic/description
  Supports Ingenic SoC USB PHY starting from JZ4770.
endef

$(eval $(call KernelPackage,usb-phy-ingenic))
