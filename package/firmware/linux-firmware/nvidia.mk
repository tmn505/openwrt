Package/t210-usb-firmware = $(call Package/firmware-default,nVidia T210 USB firmware)
define Package/t210-usb-firmware/install
	$(INSTALL_DIR) $(1)/lib/firmware/nvidia/tegra210
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/nvidia/tegra210/xusb.bin \
		$(1)/lib/firmware/nvidia/tegra210
endef
$(eval $(call BuildPackage,t210-usb-firmware))

Package/t210-vic-firmware = $(call Package/firmware-default,nVidia T210 VIC firmware)
define Package/t210-vic-firmware/install
	$(INSTALL_DIR) $(1)/lib/firmware/nvidia/tegra210
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/nvidia/tegra210/vic04_ucode.bin \
		$(1)/lib/firmware/nvidia/tegra210
endef
$(eval $(call BuildPackage,t210-vic-firmware))
