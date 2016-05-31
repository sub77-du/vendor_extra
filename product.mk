
########################################
############## Packages ################
########################################

# Add wanted packages
PRODUCT_PACKAGES += \
		Matlog \
		OpenCamera

# APP REMOVAL SCRIPT
PRODUCT_COPY_FILES += \
		vendor/extra/prebuilt/common/addon.d/60-removal.sh:system/addon.d/60-removal.sh

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
