# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2017-2024 Tomasz Maciej Nowak <tmn505@gmail.com>

include $(TOPDIR)/rules.mk

BOARD := tegra
BOARDNAME := NVIDIA Tegra
FEATURES := audio boot-part display ext4 fpu gpio pci pcie rootfs-part rtc squashfs usb
SUBTARGETS := armv7

KERNEL_PATCHVER := 6.6

include $(INCLUDE_DIR)/target.mk

DEFAULT_PACKAGES += e2fsprogs mkf2fs partx-utils

define Target/Description
	Build firmware image for NVIDIA Tegra SoC devices.
endef

$(eval $(call BuildTarget))
