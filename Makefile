ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = HouseKeeping

HouseKeeping_FILES = Tweak.xm
HouseKeeping_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += housekeepingprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
