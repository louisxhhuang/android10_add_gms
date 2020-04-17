## Based on Android 10 AOSP, and binaries for Pixel 3 XL (crosshatch, 2019-12-05)
Refer to OpenGApps (https://opengapps.org), aosp_build git. An experimental study to integrate Pixel launcher and GMS Core into AOSP. As I am unsure of the license status for apks retrieved from Pixel, they are not collected in this repo. APKs can be found from OpenGApps download.

The first repo (2020-04-17) works with NexusLauncherRelease, PrebuiltGmsCore, GoogleServicesFramework and Phonesky apks. Create the folders under ```prebuilt/priv-app``` with above names and the corresponding apks with same names inside (one folder holds one apk). Checkout the repo under a ```google``` folder created under ```vendor``` folder of the AOSP source tree.

Need to modify device.mk in AOSP source tree device/google/crosshatch, add below line at the end of file:
```
$(call inherit-product, vendor/google/build/mygms.mk)
```
