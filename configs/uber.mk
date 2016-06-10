# Written for UBER toolchains (UBERTC)
# Requires a Linux Host

UNAME := $(shell uname -s)
ifeq (Linux,$(UNAME))
  HOST_OS := linux
endif

# Disable jack building to fix clang errors
export ANDROID_COMPILE_WITH_JACK := false

ifeq (linux,$(HOST_OS))
ifeq (arm,$(TARGET_ARCH))

# NDK TOOLCHAIN INFO
ifdef TARGET_NDK_VERSION_EXP
NDK_TC_PATH := prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-$(TARGET_NDK_VERSION_EXP)
NDK_TC_VERSION := $(shell prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-$(TARGET_NDK_VERSION_EXP)/bin/arm-linux-androideabi-gcc --version 2>&1)
NDK_TC_VERSION_NUMBER := $(shell prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-$(TARGET_NDK_VERSION_EXP)/bin/arm-linux-androideabi-gcc -dumpversion 2>&1)
NDK_TC_DATE := $(filter 20150% 20151% 20160% 20161%,$(NDK_TC_VERSION))
ifneq ($(filter (UBERTC%),$(NDK_TC_VERSION)),)
  NDK_TC_NAME := UberTC
else
  NDK_TC_NAME := GCC
endif
ARM_NDK_PROP :=  $(NDK_TC_VERSION_NUMBER)-$(NDK_TC_NAME)-$(NDK_TC_DATE)
export $(ARM_NDK_PROP)
ADDITIONAL_BUILD_PROPERTIES += ro.tc.ndk=$(ARM_NDK_PROP)
endif

# GCC TOOLCHAIN INFO
ifdef TARGET_GCC_VERSION_EXP
GCC_TC_PATH := prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-$(TARGET_GCC_VERSION_EXP)
GCC_TC_VERSION := $(shell prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-$(TARGET_GCC_VERSION_EXP)/bin/arm-linux-androideabi-gcc --version 2>&1)
GCC_TC_VERSION_NUMBER := $(shell prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-$(TARGET_GCC_VERSION_EXP)/bin/arm-linux-androideabi-gcc -dumpversion 2>&1)
GCC_TC_DATE := $(filter 20150% 20151% 20160% 20161%,$(GCC_TC_VERSION))
ifneq ($(filter (UBERTC%),$(GCC_TC_VERSION)),)
  GCC_TC_NAME := UberTC
else
  GCC_TC_NAME := GCC
endif
ARM_GCC_PROP :=  $(GCC_TC_VERSION_NUMBER)-$(GCC_TC_NAME)-$(GCC_TC_DATE)
export $(ARM_GCC_PROP)
ADDITIONAL_BUILD_PROPERTIES += ro.tc.android=$(ARM_GCC_PROP)
endif

# KERNEL TOOLCHAIN INFO
ifdef TARGET_KERNEL_CROSS_COMPILE_PREFIX
ifdef TARGET_KERNEL_VERSION_EXP
TARGET_GCC_VERSION_EXP := $(TARGET_KERNEL_VERSION_EXP)
endif
KERNEL_TC_PATH := prebuilts/gcc/linux-x86/arm/$(TARGET_KERNEL_CROSS_COMPILE_PREFIX)$(TARGET_GCC_VERSION_EXP)
KERNEL_TC_VERSION := $(shell prebuilts/gcc/linux-x86/arm/$(TARGET_KERNEL_CROSS_COMPILE_PREFIX)$(TARGET_GCC_VERSION_EXP)/bin/$(TARGET_KERNEL_CROSS_COMPILE_PREFIX)gcc --version 2>&1)
KERNEL_TC_VERSION_NUMBER := $(shell prebuilts/gcc/linux-x86/arm/$(TARGET_KERNEL_CROSS_COMPILE_PREFIX)$(TARGET_GCC_VERSION_EXP)/bin/$(TARGET_KERNEL_CROSS_COMPILE_PREFIX)gcc -dumpversion 2>&1)
KERNEL_TC_DATE := $(filter 20150% 20151% 20160% 20161%,$(KERNEL_TC_VERSION))
ifneq ($(filter (UBERTC%),$(KERNEL_TC_VERSION)),)
  KERNEL_TC_NAME := UberTC
else
  KERNEL_TC_NAME := GCC
endif
ARM_KERNEL_PROP :=  $(KERNEL_TC_VERSION_NUMBER)-$(KERNEL_TC_NAME)-$(KERNEL_TC_DATE)
export $(ARM_KERNEL_PROP)
ADDITIONAL_BUILD_PROPERTIES += ro.tc.kernel=$(ARM_KERNEL_PROP)
endif

# UBERTC OPTIMIZATIONS 
ifeq (true,$(STRICT_ALIASING))
  OPT1 := (strict)
endif
ifeq (true,$(GRAPHITE_OPTS))
  OPT2 := (graphite)
endif
ifeq (true,$(KRAIT_TUNINGS))
  OPT3 := ($(TARGET_CPU_VARIANT))
endif
ifeq (true,$(ENABLE_GCCONLY))
  OPT4 := (gcconly)
endif
ifeq (true,$(CLANG_O3))
  OPT5 := (clang_O3)
endif
ifeq (true,$(CORTEX_TUNINGS))
  OPT6 := (CORTEX)
endif
ifeq (true,$(USE_PIPE))
  OPT7 := (pipe)
endif
ifeq (true,$(ENABLE_SANITIZE))
  OPT8 := (mem-sanitize)
endif

GCC_OPTIMIZATION_LEVELS := $(OPT1)$(OPT2)$(OPT3)$(OPT4)$(OPT5)$(OPT6)$(OPT7)$(OPT8)
ifneq (,$(GCC_OPTIMIZATION_LEVELS))
ADDITIONAL_BUILD_PROPERTIES += \
    ro.uber.flags=$(GCC_OPTIMIZATION_LEVELS)
endif

endif
endif


