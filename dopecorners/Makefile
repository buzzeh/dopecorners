include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = dopecorners
dopecorners_FILES = dopecornersRootListController.m $(wildcard *.m)
dopecorners_INSTALL_PATH = /Library/PreferenceBundles
dopecorners_FRAMEWORKS = UIKit
dopecorners_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/dopecorners.plist$(ECHO_END)
