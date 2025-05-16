PKG_NAME = mihomo
PKG_VERS = 1.19.5
PKG_EXT = gz
PKG_DIST_NAME = $(PKG_NAME)-linux-$(PKG_DIST_ARCH)-v$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://github.com/MetaCubeX/mihomo/releases/download/v$(PKG_VERS)
PKG_DIR = mihomo

DEPENDS =

HOMEPAGE = https://github.com/MetaCubeX/mihomo/tree/v$(PKG_VERS)
COMMENT  = Another Mihomo Kernel.
LICENSE  = GPLv3

REQUIRED_MIN_DSM = 7

include ../../mk/spksrc.archs.mk

UNSUPPORTED_ARCHS = $(PPC_ARCHS) $(i686_ARCHS) $(ARMv5_ARCHS) $(ARMv7L_ARCHS)

PKG_DIST_ARCH_LIST = amd64-compatible arm64 armv7

ifeq ($(findstring $(ARCH),$(x64_ARCHS)),$(ARCH))
PKG_DIST_ARCH = amd64-compatible
else ifeq ($(findstring $(ARCH),$(ARMv8_ARCHS)),$(ARCH))
PKG_DIST_ARCH = arm64
else ifeq ($(findstring $(ARCH),$(ARMv7_ARCHS)),$(ARCH))
PKG_DIST_ARCH = armv7
endif

ifeq ($(PKG_DIST_ARCH),)
$(info PKG_DIST_ARCH is null. ARCH = [$(ARCH)])
ifneq ($(findstring $(ARCH),$(UNSUPPORTED_ARCHS)),$(ARCH))
$(error Unsupported ARCH $(ARCH))
endif
endif

EXTRACT_PATH = $(WORK_DIR)/$(PKG_NAME)

EXTRACT_TARGET = mihomo_custom_extract
INSTALL_TARGET = mihomo_custom_install

include ../../mk/spksrc.install-resources.mk

.PHONY: mihomo_custom_extract
mihomo_custom_extract:
	@mkdir -p $(EXTRACT_PATH)
	gzip -dkfc $(DIST_FILE) > $(EXTRACT_PATH)/mihomo
	chmod u+x $(EXTRACT_PATH)/mihomo

.PHONY: mihomo_custom_install
mihomo_custom_install: 
	@mkdir -p $(STAGING_INSTALL_PREFIX)/usr/local/bin
	tar -cf - -C $(EXTRACT_PATH) . | tar -xf - -C $(STAGING_INSTALL_PREFIX)/usr/local/bin
	@install -m 755 -d $(STAGING_INSTALL_PREFIX)/usr/local/etc
	@install -m 644 src/config.yaml $(STAGING_INSTALL_PREFIX)/usr/local/etc/config.yaml
