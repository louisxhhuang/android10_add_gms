# LH2020: config.mk is pre-processed by soong, and it does not recognize
# $(info) makefile command hence if we add info print here it will cause
# error in soong process. By tracing code, CALLED_FROM_SETUP environment
# variable is defined in soong process, so we use it to isolate $(info)

#LH2020
ifndef CALLED_FROM_SETUP
$(info $@ mygms before: PRODUCT_PACKAGES=$(PRODUCT_PACKAGES))
$(info mygms after: PRODUCT_PACKAGE_OVERLAYS=$(PRODUCT_PACKAGE_OVERLAYS))
endif

# To add Pixel launcher into AOSP, makefile needs to add:
# 1. The prebuilt binary located in certain folder e.g. vendor/google/prebuilt/priv-app/NexusLauncherRelease
# 2. The xml file for granting permissions for priv-app (otherwise it is stuck on boot up)
# 3. An Android.mk located at the same folder of "NexusLauncherRelease" folder. The relative folder path in Android.mk starts from here.
#    This makefile will be used by AOSP make system to match "NexusLauncherRelease" and "com.google.android.apps.nexuslauncher.xml",
#    then execute the rules for them. 
# 2020-04-16: use one permission XML to contain all permissions required for installed priv apps

#
# Some apks are signed with platform key e.g. SettingsGoogle.apk, it cannot be used on AOSP build directly. Need to sign it
# with platform key (otherwise during loading, error with occur due to this apk claims "sharedUserId" config in Manifest)
# In Android.mk for this prebuilt, set "LOCAL_CERTIFICATE := platform", then this apk will be re-signed with platform key
# before copied to product partition intermediates
#
PRODUCT_PACKAGES += \
    NexusLauncherRelease \
    GoogleServicesFramework \
    PrebuiltGmsCore \
    Phonesky \
    mygms.xml \
#    SettingsGoogle \
#    com.android.settings.xml

# Put in /product/overlay instead of /vendor/overlay, as vendor.img is a prebuilt for crosshatch
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/google/overlay

#LH2020
ifndef CALLED_FROM_SETUP
$(info mygms after: PRODUCT_PACKAGES=$(PRODUCT_PACKAGES))
$(info mygms after: PRODUCT_PACKAGE_OVERLAYS=$(PRODUCT_PACKAGE_OVERLAYS))
endif