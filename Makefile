LOCAL_CONFIG_MK = $(CURDIR)/local.mk
ifneq ($(wildcard $(LOCAL_CONFIG_MK)),)
include $(LOCAL_CONFIG_MK)
endif

SPK_NAME = mihomo
SPK_VERS = 1.19.8
SPK_REV = 2
CROSS_DIR = $(SPKSRC_DIR)/cross/$(SPK_NAME)
SPK_DIR = $(SPKSRC_DIR)/spk/$(SPK_NAME)
PKG_DIR = $(SPKSRC_DIR)/packages
PKG_DIST_NAME = $(SPK_NAME)_$(ARCH)-$(TCVERSION)_$(SPK_VERS)-$(SPK_REV).spk

DEFAULT_ARCH = x64
DEFAULT_TCVERSION = 7.0

default: package

setup: local.mk

local.mk:
	@echo "Creating local configuration \"local.mk\"..."
	@echo "SPKSRC_DIR = /toolkit/spksrc" > $@
	@echo "ARCH = $(DEFAULT_ARCH)" >> $@
	@echo "TCVERSION = $(DEFAULT_TCVERSION)" >> $@

update-version:
	@echo "=====> run update version <====="
	@sed -i 's/PKG_VERS = .*/PKG_VERS = $(SPK_VERS)/g' cross/Makefile
	@sed -i 's/SPK_VERS = .*/SPK_VERS = $(SPK_VERS)/g' spk/Makefile
	@sed -i 's/SPK_REV = .*/SPK_REV = $(SPK_REV)/g' spk/Makefile

clean:

cross-clean:
	@echo "remove $(CROSS_DIR)"
	@if [ -e $(CROSS_DIR) ]; then rm -rf $(CROSS_DIR); fi

cross-copy: cross-clean
	cp -a cross $(CROSS_DIR)

cross: cross-copy
	cd $(CROSS_DIR) && make clean && make arch-$(ARCH)-$(TCVERSION)

digests: cross-copy
	cd $(CROSS_DIR) && make clean && make digests
	cp -a $(CROSS_DIR)/digests cross/digests

spk-clean:
	@echo "remove $(SPK_DIR)"
	@if [ -e $(SPK_DIR) ]; then rm -rf $(SPK_DIR); fi

spk-copy: spk-clean
	cp -a spk $(SPK_DIR)

spk: cross-copy spk-copy
	cd $(SPK_DIR) && make clean && make arch-$(ARCH)-$(TCVERSION)

package: spk
	@mkdir -p packages
	@cp -a $(PKG_DIR)/$(PKG_DIST_NAME) packages/
