# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (c) 2022 Tomasz Maciej Nowak <tmn505@gmail.com>

define KernelPackage/i2c-ingenic
  SUBMENU := $(I2C_MENU)
  TITLE := Ingenic I2C driver
  KCONFIG := CONFIG_I2C_JZ4780
  DEPENDS := +kmod-i2c-core
  FILES := $(LINUX_DIR)/drivers/i2c/busses/i2c-jz4780.ko
  AUTOLOAD := $(call AutoProbe,i2c-jz4780,)
endef

define KernelPackage/i2c-ingenic/description
  Supports Ingenic SoC I2C controller starting from JZ4780.
endef

$(eval $(call KernelPackage,i2c-ingenic))


define KernelPackage/pcs-xpcs
  SUBMENU := $(NETWORK_DEVICES_MENU)
  TITLE := Helper functions for Synopsys DesignWare XPCS controllers
  HIDDEN := 1
  DEPENDS := +kmod-phylink
  KCONFIG := CONFIG_PCS_XPCS
  FILES := $(LINUX_DIR)/drivers/net/pcs/pcs_xpcs.ko
  AUTOLOAD := $(call AutoProbe,pcs_xpcs,1)
endef

$(eval $(call KernelPackage,pcs-xpcs))


define KernelPackage/spi-ingenic
  SUBMENU := $(SPI_MENU)
  TITLE := Ingenic SPI driver
  KCONFIG := CONFIG_SPI_INGENIC
  FILES := $(LINUX_DIR)/drivers/spi/spi-ingenic.ko
  AUTOLOAD := $(call AutoProbe,spi-ingenic,)
endef

define KernelPackage/spi-ingenic/description
  Supports Ingenic SoC SPI controller starting from JZ4750.
endef

$(eval $(call KernelPackage,spi-ingenic))


define KernelPackage/stmmac-ingenic
  SUBMENU := $(NETWORK_DEVICES_MENU)
  TITLE := STMicroelectronics Multi-Gigabit Ethernet support
  DEPENDS := +kmod-mii +kmod-of-mdio +kmod-pcs-xpcs +kmod-ptp
  KCONFIG := \
       CONFIG_DWMAC_GENERIC \
       CONFIG_DWMAC_INGENIC \
       CONFIG_DWMAC_PLATFORM \
       CONFIG_STMMAC_ETH \
       CONFIG_STMMAC_PLATFORM
  FILES := \
       $(LINUX_DIR)/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.ko \
       $(LINUX_DIR)/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.ko \
      $(LINUX_DIR)/drivers/net/ethernet/stmicro/stmmac/stmmac-platform.ko \
       $(LINUX_DIR)/drivers/net/ethernet/stmicro/stmmac/stmmac.ko
  AUTOLOAD := $(call AutoProbe,dwmac-generic dwmac-ingenic,1)
endef

define KernelPackage/stmmac-ingenic/description
  Kernel driver for the Ingenic Ethernet IP built around a Synopsys IP Core.
endef

$(eval $(call KernelPackage,stmmac-ingenic))


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
