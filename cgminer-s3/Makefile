#
# Author: L. D. Pinney <ldpinney@gmail.com>
# Address: 13Q6f7DqiZkqkS6WwMtdiRBEF35eMTk59a
# Date: 13 July 2015
#
# This is free and unencumbered software released into the public domain.
# For details see the UNLICENSE file at the root of the source tree.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=cgminer
PKG_VERSION:=4.9.2
PKG_REV:=3f70e48cc7a590b4dac407fd002159bab2428ccd
# PKG_REV:=94e04f6ffc5e14c4d55190727f367a78941b057d
PKG_RELEASE:=7
PKG_INSTALL:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_REV).tar.bz2
PKG_SOURCE_URL:=git://github.com/ckolivas/cgminer.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/cgminer-s3
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=cgminer-s3 (ASIC Miner)
	URL:=https://github.com/ckolivas/cgminer
	DEPENDS:=+libcurl +libpthread +jansson +udev +libncurses
endef

define Package/cgminer-s3/description
Cgminer build for the Bitmain Antminer S3. Do not use on multiple block chains at the same time!
endef

	CONFIGURE_ARGS += --disable-opencl --disable-adl --disable-nurses --enable-ants3
	TARGET_LDFLAGS += -Wl,-rpath-link=$(STAGING_DIR)/usr/lib

define Build/Compile
	$(call Build/Compile/Default)
	(cd $(PKG_BUILD_DIR) && \
	  $(TARGET_CC) -Icompat/jansson-2.6/src -Icompat/libusb-1.0/libusb \
	  api-example.c -o cgminer-api;)
endef


define Package/cgminer-s3/install
	$(INSTALL_DIR) $(1)/usr/bin $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/etc/config

	$(INSTALL_BIN) $(PKG_BUILD_DIR)/cgminer-api			$(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/cgminer	$(1)/usr/bin
	$(INSTALL_BIN) $(FILES_DIR)/cgminer-monitor			$(1)/usr/bin
	$(INSTALL_BIN) $(FILES_DIR)/s3_cgminer.init			$(1)/etc/init.d/cgminer

	mkdir -p $(1)/usr/lib/lua/luci/model/cbi/cgminer
	mkdir -p $(1)/usr/lib/lua/luci/controller
	mkdir -p $(1)/etc/uci-defaults

	$(CP)	$(FILES_DIR)/01-cgminer					$(1)/etc/uci-defaults/01-cgminer
	$(CP)	$(FILES_DIR)/s3_cgminer.config			$(1)/etc/config/cgminer
	$(CP)	$(FILES_DIR)/s3_cgminer.control.lua		$(1)/usr/lib/lua/luci/controller/cgminer.lua
	$(CP)	$(FILES_DIR)/s3_cgminer.lua				$(1)/usr/lib/lua/luci/model/cbi/cgminer/cgminer.lua
	$(CP)	$(FILES_DIR)/s3_cgminerstatus.lua		$(1)/usr/lib/lua/luci/model/cbi/cgminer/cgminerstatus.lua
	$(CP)	$(FILES_DIR)/s3_asic-freq.config		$(1)/etc/config/asic-freq
	
	rm -rf $(1)/usr/bin/compile_time
	date >> $(1)/usr/bin/compile_time
	echo $(MINER_TYPE)
	echo $(MINER_TYPE) >> $(1)/usr/bin/compile_time
endef

$(eval $(call BuildPackage,cgminer-s3))
