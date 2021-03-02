THEOS_PACKAGE_DIR_NAME = debs
TARGET = iphone:clang
# TARGET = simulator:clang::7.0
ARCHS = arm64 arm64e
# i386 slice is required for 32-bit iOS Simulator (iPhone 5, etc.)
DEBUG = 0
PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)

THEOS_DEVICE_IP = 192.168.243.193
THEOS_DEVICE_PORT = 22

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ShortcutsExtender
ShortcutsExtender_FILES = ShortcutsExtender.xm
ShortcutsExtender_CFLAGS = -fobjc-arc -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/tweak.mk

ifneq (,$(filter x86_64 i386,$(ARCHS)))
setup:: clean all
	@rm -f /opt/simject/$(TWEAK_NAME).dylib
	@cp -v $(THEOS_OBJ_DIR)/$(TWEAK_NAME).dylib /opt/simject/$(TWEAK_NAME).dylib
	@codesign -f -s - /opt/simject/$(TWEAK_NAME).dylib
	@cp -v $(PWD)/$(TWEAK_NAME).plist /opt/simject
endif