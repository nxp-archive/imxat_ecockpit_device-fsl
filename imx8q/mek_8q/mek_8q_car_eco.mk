# This is NXP eCockpit Android Autotmotive variant based on i.MX8QM MEK board
# It will inherit from FSL core product which in turn inherit from Google generic

IMX_DEVICE_PATH := device/fsl/imx8q/mek_8q

PRODUCT_IMX_CAR := true

include device/fsl/imx8q/mek_8q/mek_8q_eco.mk
# Include keystore attestation keys and certificates.
#-include $(IMX_SECURITY_PATH)/attestation/imx_attestation.mk

# Overrides
PRODUCT_NAME := mek_8q_car_eco
PRODUCT_PACKAGE_OVERLAYS := $(IMX_DEVICE_PATH)/overlay_car packages/services/Car/car_product/overlay

PRODUCT_COPY_FILES += \
    packages/services/Car/car_product/init/init.bootstat.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.bootstat.rc \
    packages/services/Car/car_product/init/init.car.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.car.rc \
    system/core/rootdir/init.zygote_auto.rc:root/init.zygote_auto.rc \

# ONLY devices that meet the CDD's requirements may declare these features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.screen.landscape.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.screen.landscape.xml \
    frameworks/native/data/etc/android.hardware.type.automotive.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.type.automotive.xml \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.freeform_window_management.xml

# Add Google prebuilt services
PRODUCT_PACKAGES += \
    GoogleSearchEmbedded \
    GoogleDemandspace \
    GoogleMaps \
    GooglePlayStore \
    GoogleGmscore_demo \
    GoogleServicesFramework_demo \
    GoogleLoginService_demo \
    GoogleExtServices_demo \
    GoogleExtShared_demo \
    GooglePartnerSetup_demo \
    HeadUnit

# Add Car related HAL
PRODUCT_PACKAGES += \
    libion \
    vehicle.default \
    android.hardware.automotive.vehicle@2.0-service

# Use special ro.zygote to make default init.rc didn't load default zygote rc
PRODUCT_PRODUCT_PROPERTIES += ro.zygote=zygote_auto

# Simulate the vehical rpmsg register event for non m4 car image
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.vehicle.register=1 \
    vendor.evs.video.ready=1

