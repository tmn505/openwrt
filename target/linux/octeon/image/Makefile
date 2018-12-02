#
# Copyright (C) 2009-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

define Device/Default
  PROFILES = Default $$(DEVICE_NAME)
  KERNEL_NAME := vmlinux.elf
  KERNEL_INITRAMFS_NAME := vmlinux-initramfs.elf
  KERNEL_DEPENDS = $$(wildcard $(DTS_DIR)/$$(DEVICE_DTS).dts)
  KERNEL := kernel-bin | strip-kernel | patch-cmdline
  IMAGES := sysupgrade.tar
  IMAGE/sysupgrade.tar/squashfs := append-rootfs | pad-extra 128k | sysupgrade-tar rootfs=$$$$@
  IMAGE/sysupgrade.tar := sysupgrade-tar
endef

define Build/strip-kernel
	# Workaround pre-SDK-1.9.0 u-boot versions not handling the .notes section
	$(TARGET_CROSS)strip -R .notes $@ -o $@.stripped && mv $@.stripped $@
endef

define Build/append-dtb-to-elf
	$(TARGET_CROSS)objcopy --update-section .appended_dtb=$(KDIR)/image-$(firstword $(DEVICE_DTS)).dtb $@
endef

define Device/generic
  FILESYSTEMS := ext4
  DEVICE_TITLE := Generic
endef
TARGET_DEVICES += generic

ER_CMDLINE:=-mtdparts=phys_mapped_flash:640k(boot0)ro,640k(boot1)ro,64k(eeprom)ro root=/dev/mmcblk0p2 rootfstype=squashfs,ext4 rootwait
define Device/er
  CMDLINE := $(ER_CMDLINE) 
  DEVICE_DTS_DIR := $(DTS_DIR)/cavium-octeon
  DEVICE_DTS := ubnt_e100
  KERNEL := kernel-bin | append-dtb-to-elf | strip-kernel | patch-cmdline
  DEVICE_TITLE := Ubiquiti EdgeRouter
endef
TARGET_DEVICES += er

ERLITE_CMDLINE:=-mtdparts=phys_mapped_flash:512k(boot0)ro,512k(boot1)ro,64k(eeprom)ro root=/dev/sda2 rootfstype=squashfs,ext4 rootwait
define Device/erlite
  CMDLINE := $(ERLITE_CMDLINE) 
  DEVICE_TITLE := Ubiquiti EdgeRouter Lite
endef
TARGET_DEVICES += erlite

define Device/vforce1408
  DEVICE_TITLE := NexG VForce1408
  DEVICE_DTS_DIR := ../files-4.14/arch/mips/boot/dts/cavium-octeon
  DEVICE_DTS := nexg_vforce1408
  DEVICE_PACKAGES += ethtool kmod-hwmon-core kmod-hwmon-lm83 kmod-rtc-ds1307
  KERNEL := kernel-bin | append-dtb-to-elf | strip-kernel
endef
TARGET_DEVICES += vforce1408

$(eval $(call BuildImage))
