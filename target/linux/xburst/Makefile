# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021 Tomasz Maciej Nowak <tmn505@gmail.com>

include $(TOPDIR)/rules.mk

ARCH := mipsel
BOARD := xburst
BOARDNAME := Ingenic XBurst
FEATURES := boot-part dt fpu gpio ramdisk rootfs-part rtc small_flash squashfs usb usbgadget source-only
CPU_TYPE := xburst

KERNEL_PATCHVER := 5.10
KERNEL_TESTING_PATCHVER := 5.10

define Target/Description
	Build firmware images for Ingenic XBurst SoC based boards.
endef

include $(INCLUDE_DIR)/target.mk

DEFAULT_PACKAGES += e2fsprogs mkf2fs partx-utils

$(eval $(call BuildTarget))
