# Written for DragonTC toolchains (DragonTC)
# Requires a Linux Host

UNAME := $(shell uname -s)
ifeq (Linux,$(UNAME))
  HOST_OS := linux
endif

# Disable jack building to fix clang errors
# export ANDROID_COMPILE_WITH_JACK := false

ifeq (linux,$(HOST_OS))
ifeq (arm,$(TARGET_ARCH))


# CLANG TOOLCHAIN INFO
ifeq (1,$(words $(filter 3.9,$(TARGET_CLANG_VERSION_EXP))))
	TARGET_DRAGONTC_VERSION := $(TARGET_CLANG_VERSION_EXP)
	DTC_PATH := prebuilts/clang/linux-x86/host/$(TARGET_DRAGONTC_VERSION)
	DTC_VER := $(shell cat $(DTC_PATH)/VERSION)
	export $(DTC_VER)
	PRODUCT_PROPERTY_OVERRIDES += ro.dtc.version=$(DTC_VER)
endif

endif
endif
