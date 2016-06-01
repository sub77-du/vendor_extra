
########################################
############## Packages ################
########################################

# Add wanted packages
PRODUCT_PACKAGES += \
		Matlog \
		KernelAdiutor

# APP REMOVAL SCRIPT
PRODUCT_COPY_FILES += \
		vendor/extra/prebuilt/common/addon.d/60-removal.sh:system/addon.d/60-removal.sh

# Viper4Android
PRODUCT_COPY_FILES += \
		vendor/extra/prebuilt/common/bin/audio_policy.sh:system/audio_policy.sh \
		vendor/extra/prebuilt/common/addon.d/95-LolliViPER.sh:system/addon.d/95-LolliViPER.sh \
		vendor/extra/prebuilt/common/su.d/50viper.sh:system/su.d/50viper.sh \
		vendor/extra/prebuilt/common/apk/Viper4Android/Viper4Android.apk:system/priv-app/Viper4Android/Viper4Android.apk 


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
