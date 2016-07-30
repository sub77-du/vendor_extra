
########################################
############## Packages ################
########################################

# APP REMOVAL SCRIPT
REMOVE_PACKAGES += \
    Chromium

# Add wanted packages
PRODUCT_PACKAGES += \
    KernelAdiutor \
    EnhancedIME \

PRODUCT_COPY_FILES += \
        vendor/extra/prebuilt/common/addon.d/60-removal.sh:system/addon.d/60-removal.sh

# ViPER4Android
#ifeq (true, $(strip $(VIPER_AUDIO_MOD)))
#ifdef VIPER_AUDIO_MOD
PRODUCT_COPY_FILES += \
    vendor/extra/prebuilt/common/bin/audio_policy.sh:system/audio_policy.sh \
    vendor/extra/prebuilt/common/addon.d/95-LolliViPER.sh:system/addon.d/95-LolliViPER.sh \
    vendor/extra/prebuilt/common/su.d/50viper.sh:system/su.d/50viper.sh \
    vendor/extra/prebuilt/common/apk/ViPER4Android.apk:system/priv-app/ViPER4Android/ViPER4Android.apk \
    vendor/extra/prebuilt/common/viper/etc/audio_effects.conf:system/etc/audio_effects.conf \
    vendor/extra/prebuilt/common/viper/lib/soundfx/libeffectproxy.so:system/lib/soundfx/libeffectproxy.so \
    vendor/extra/prebuilt/common/viper/lib/soundfx/libv4a_fx_ics.so:system/lib/soundfx/libv4a_fx_ics.so \
    vendor/extra/prebuilt/common/viper/vendor/etc/audio_effects.conf:system/vendor/etc/audio_effects.conf
#else
# MusicFX
#PRODUCT_PACKAGES += \
#    MusicFX
#endif

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# OpenDelta
PRODUCT_PACKAGES += \
    OpenDelta

PRODUCT_COPY_FILES += \
    vendor/extra/prebuilt/common/apk/RomAddon.apk:system/priv-app/RomAddon/RomAddon.apk

# Nano
PRODUCT_PACKAGES += \
    nano
    
# Gello
PRODUCT_PACKAGES += \
    Gello

########################################
############# Settings #################
########################################

# Disable SELinux
#PRODUCT_PROPERTY_OVERRIDES := $(subst selinux=1,selinux=0,$(PRODUCT_PROPERTY_OVERRIDES))

# Enable data roaming
#PRODUCT_PROPERTY_OVERRIDES := $(subst dataroaming=false,dataroaming=true,$(PRODUCT_PROPERTY_OVERRIDES))

# Disable multiuser
#PRODUCT_PROPERTY_OVERRIDES += fw.show_multiuserui=0

# Updates overlay settings
#PRODUCT_PACKAGE_OVERLAYS += vendor/extra/overlay/common
