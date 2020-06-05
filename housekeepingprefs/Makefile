include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = HouseKeepingPrefs

HouseKeepingPrefs_FILES = PTDRootListController.m
HouseKeepingPrefs_INSTALL_PATH = /Library/PreferenceBundles
HouseKeepingPrefs_FRAMEWORKS = UIKit
HouseKeepingPrefs_PRIVATE_FRAMEWORKS = Preferences
HouseKeepingPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/HouseKeepingPrefs.plist$(ECHO_END)
