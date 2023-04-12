Package/gm20b-firmware = $(call Package/firmware-default,GM20B Video Driver firmware)
define Package/gm20b-firmware/install
	$(INSTALL_DIR) $(1)/lib/firmware/nvidia/gm20b/acr
	$(INSTALL_DIR) $(1)/lib/firmware/nvidia/gm20b/gr
	$(INSTALL_DIR) $(1)/lib/firmware/nvidia/gm20b/pmu
	$(CP) \
	$(PKG_BUILD_DIR)/nvidia/gm20b/acr/*.bin \
		$(1)/lib/firmware/nvidia/gm20b/acr
	$(CP) \
		$(PKG_BUILD_DIR)/nvidia/gm20b/gr/*.bin \
		$(1)/lib/firmware/nvidia/gm20b/gr
	$(CP) \
		$(PKG_BUILD_DIR)/nvidia/gm200/gr/sw_method_init.bin \
		$(1)/lib/firmware/nvidia/gm20b/gr
	$(CP) \
		$(PKG_BUILD_DIR)/nvidia/gm20b/pmu/*.bin \
		$(1)/lib/firmware/nvidia/gm20b/pmu
endef
$(eval $(call BuildPackage,gm20b-firmware))

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
