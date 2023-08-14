# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2017-2019 Tomasz Maciej Nowak <tmn505@gmail.com>

include $(TOPDIR)/rules.mk

BOARD:=tegra
BOARDNAME:=NVIDIA Tegra
FEATURES:=audio boot-part display ext4 fpu gpio pci pcie rootfs-part rtc squashfs usb targz
SUBTARGETS:=cortexa9 cortexa57

KERNEL_PATCHVER:=6.1
KERNEL_TESTING_PATCHVER:=6.1

include $(INCLUDE_DIR)/target.mk

DEFAULT_PACKAGES += e2fsprogs mkf2fs partx-utils

$(eval $(call BuildTarget))
