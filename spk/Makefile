SPK_NAME = mihomo
SPK_VERS = 1.19.5
SPK_REV = 1
SPK_ICON = src/mihomo.png

DEPENDS = cross/mihomo

MAINTAINER = wangbin1989
MAINTAINER_URL = https://github.com/wangbin1989

DESCRIPTION = "Meta Kernel"
DISPLAY_NAME = Mihomo
CHANGELOG = "Initial package release."
STARTABLE = yes

LICENSE  = GPLv3

REQUIRED_MIN_DSM = 7.0

SPK_DEPENDS = WebStation

include ../../mk/spksrc.archs.mk

UNSUPPORTED_ARCHS = $(PPC_ARCHS) $(i686_ARCHS) $(ARMv5_ARCHS) $(ARMv7L_ARCHS)

CONF_DIR = src/conf/
DSM_UI_DIR = app
DSM_UI_CONFIG = src/app/config

SERVICE_USER = auto
SERVICE_SETUP = src/service-setup.sh
SERVICE_PORT = 7890
SERVICE_PORT_TITLE = Mihomo fixed port

include ../../mk/spksrc.spk.mk
