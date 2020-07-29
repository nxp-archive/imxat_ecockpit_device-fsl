LOCAL_PATH := $(call my-dir)

include device/fsl/common/build/kernel.mk
ifneq ($(PRODUCT_IMX_ECO),true)
include device/fsl/common/build/uboot.mk
endif
include device/fsl/common/build/dtbo.mk
include device/fsl/common/build/imx-recovery.mk
include device/fsl/common/build/gpt.mk
include $(LOCAL_PATH)/AndroidUboot.mk
include $(FSL_PROPRIETARY_PATH)/fsl-proprietary/media-profile/media-profile.mk
ifneq ($(PRODUCT_IMX_CAR),true)
include $(FSL_PROPRIETARY_PATH)/fsl-proprietary/sensor/fsl-sensor.mk
endif
