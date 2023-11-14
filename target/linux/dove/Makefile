# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2024 Tomasz Maciej Nowak <tmn505@gmail.com>

include $(TOPDIR)/rules.mk

ARCH := arm
BOARD := dove
BOARDNAME := Marvell Dove
FEATURES := boot-part fpu gpio pci pcie ramdisk rootfs-part rtc squashfs usb
CPU_TYPE := marvell-pj4
CPU_SUBTYPE := vfpv3-d16
SUBTARGETS := generic

KERNEL_PATCHVER := 6.1
KERNEL_TESTING_PATCHVER := 6.6

include $(INCLUDE_DIR)/target.mk

KERNELNAME := zImage dtbs

DEFAULT_PACKAGES += block-mount e2fsprogs kmod-fs-ext4 kmod-fs-f2fs kmod-fs-vfat \
	kmod-loop mkf2fs partx-utils uboot-envtools

define Target/Description
	Build firmware image for Marvell Dove (Armada 510) devices.
endef

$(eval $(call BuildTarget))
