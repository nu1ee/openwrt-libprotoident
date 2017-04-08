include $(TOPDIR)/rules.mk

PKG_NAME:=libprotoident
PKG_VERSION:=2.0.10
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/wanduow/libprotoident.git
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_VERSION:=HEAD
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/uclibc++.mk
include $(INCLUDE_DIR)/package.mk

define Package/libprotoident
	SECTION:=net
	CATEGORY:=nulee
	SUBMENU:=Network
  TITLE:=Libprotoident is a library that performs application layer protocol identification for flows.
  URL:=https://research.wand.net.nz/software/libprotoident.php
  DEPENDS:=+libtrace +libflowmanager $(CXX_DEPENDS)
endef

define Package/libprotoident/description	
	Unlike many techniques that require capturing the entire packet payload,
	only the first four bytes of payload sent in each direction,
	the size of the first payload-bearing packet in each direction and
	the TCP or UDP port numbers for the flow are used by libprotoident.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/bin
	$(CP) $(PKG_INSTALL_DIR)/bin/* $(1)/bin/
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libprotoident.{a,la,so*} $(1)/usr/lib/
endef

define Package/libprotoident/install 
	$(INSTALL_DIR) $(1)/bin
	$(INSTALL_DIR) $(PKG_INSTALL_DIR)/bin/* $(1)/bin/
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/libprotoident.a $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/libprotoident.la $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/libprotoident.so $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/libprotoident.so.* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libprotoident))

