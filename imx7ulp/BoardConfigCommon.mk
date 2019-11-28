#
# SoC-specific compile-time definitions.
#

BOARD_SOC_TYPE := IMX7ULP
BOARD_HAVE_VPU := false
HAVE_FSL_IMX_GPU2D := true
HAVE_FSL_IMX_GPU3D := true
HAVE_FSL_IMX_IPU := false
HAVE_FSL_IMX_PXP := false
BOARD_KERNEL_BASE := 0x62800000
LOAD_KERNEL_ENTRY := 0x60008000
TARGET_GRALLOC_VERSION := v3
TARGET_HIGH_PERFORMANCE := false
# HWComposer version depends on this.
TARGET_USES_HWC2 := true
TARGET_HWCOMPOSER_VERSION := v2.0
USE_OPENGL_RENDERER := true

SOONG_CONFIG_NAMESPACES += IMXPLUGIN
SOONG_CONFIG_IMXPLUGIN += BOARD_PLATFORM \
NUM_FRAMEBUFFER_SURFACE_BUFFERS \
BOARD_USE_SENSOR_FUSION \
BOARD_SOC_TYPE \
BOARD_SOC_CLASS \
HAVE_FSL_IMX_GPU3D \
TARGET_HWCOMPOSER_VERSION \
TARGET_GRALLOC_VERSION \
BOARD_USE_LEGACY_SENSOR \
BOARD_USE_SENSOR_PEDOMETER \
HAVE_FSL_IMX_IPU \
PREBUILT_FSL_IMX_GPU \
PRODUCT_MANUFACTURER \
BOARD_HAVE_VPU

SOONG_CONFIG_IMXPLUGIN_BOARD_PLATFORM = imx7
SOONG_CONFIG_IMXPLUGIN_NUM_FRAMEBUFFER_SURFACE_BUFFERS = 3
SOONG_CONFIG_IMXPLUGIN_BOARD_USE_SENSOR_FUSION = true
SOONG_CONFIG_IMXPLUGIN_BOARD_SOC_TYPE = IMX7ULP
SOONG_CONFIG_IMXPLUGIN_BOARD_SOC_CLASS = IMX7
SOONG_CONFIG_IMXPLUGIN_HAVE_FSL_IMX_GPU3D = true
SOONG_CONFIG_IMXPLUGIN_TARGET_HWCOMPOSER_VERSION = v2.0
SOONG_CONFIG_IMXPLUGIN_TARGET_GRALLOC_VERSION = v3
SOONG_CONFIG_IMXPLUGIN_BOARD_USE_LEGACY_SENSOR  = false
SOONG_CONFIG_IMXPLUGIN_BOARD_USE_SENSOR_PEDOMETER = true
SOONG_CONFIG_IMXPLUGIN_HAVE_FSL_IMX_IPU = false
SOONG_CONFIG_IMXPLUGIN_PRODUCT_MANUFACTURER = freescale
SOONG_CONFIG_IMXPLUGIN_BOARD_HAVE_VPU = false

#
# Product-specific compile-time definitions.
#

TARGET_BOARD_PLATFORM := imx7
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a7

TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := false
TARGET_NO_RECOVERY := false
TARGET_NO_RADIOIMAGE := true

BOARD_BOOTIMG_HEADER_VERSION := 1
BOARD_MKBOOTIMG_ARGS = --header_version $(BOARD_BOOTIMG_HEADER_VERSION)

BOARD_SOC_CLASS := IMX7

#BOARD_USES_GENERIC_AUDIO := true
BOARD_USES_ALSA_AUDIO := true
BOARD_HAVE_BLUETOOTH := true
USE_CAMERA_STUB := false
BOARD_CAMERA_LIBRARIES := libcamera

BOARD_HAVE_WIFI := true

BOARD_NOT_HAVE_MODEM := false
BOARD_MODEM_VENDOR := HUAWEI
BOARD_MODEM_ID := EM750M
BOARD_MODEM_HAVE_DATA_DEVICE := true
BOARD_HAVE_IMX_CAMERA := true
BOARD_HAVE_USB_CAMERA := false

TARGET_USERIMAGES_BLOCKS := 204800

# Enable dex-preoptimization to speed up first boot sequence
ifeq ($(HOST_OS),linux)
   ifeq ($(TARGET_BUILD_VARIANT),user)
	ifeq ($(WITH_DEXPREOPT),)
	   WITH_DEXPREOPT := true
        endif
   endif
endif
# for ums config, only export one partion instead of the whole disk
UMS_ONEPARTITION_PER_DISK := true

PREBUILT_FSL_IMX_CODEC := true
PREBUILT_FSL_IMX_OMX := false
PREBUILT_FSL_IMX_GPU := true
SOONG_CONFIG_IMXPLUGIN_PREBUILT_FSL_IMX_GPU = true

# override some prebuilt setting if DISABLE_FSL_PREBUILT is define
ifeq ($(DISABLE_FSL_PREBUILT),GPU)
PREBUILT_FSL_IMX_GPU := false
SOONG_CONFIG_IMXPLUGIN_PREBUILT_FSL_IMX_GPU = false
else ifeq ($(DISABLE_FSL_PREBUILT),ALL)
PREBUILT_FSL_IMX_GPU := false
SOONG_CONFIG_IMXPLUGIN_PREBUILT_FSL_IMX_GPU = false
endif

# Indicate use vivante drm based egl and gralloc
BOARD_GPU_DRIVERS := vivante

# Indicate use NXP libdrm-imx or Android external/libdrm
BOARD_GPU_LIBDRM := libdrm_imx

# for kernel/user space split
# comment out for 1g/3g space split
# TARGET_KERNEL_2G := true

BOARD_DTBOIMG_PARTITION_SIZE := 4194304
BOARD_BOOTIMAGE_PARTITION_SIZE :=  50331648
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 50331648

BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1879048192
BOARD_CACHEIMAGE_PARTITION_SIZE := 444596224
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_PARTITION_SIZE := 117440512
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE = ext4
TARGET_COPY_OUT_VENDOR := vendor
TARGET_RELEASETOOLS_EXTENSIONS := device/fsl/imx7ulp

# product.img
BOARD_USES_PRODUCTIMAGE := true
BOARD_PRODUCTIMAGE_PARTITION_SIZE := 536870912
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_PRODUCT := product

BOARD_FLASH_BLOCK_SIZE := 4096
TARGET_RECOVERY_UI_LIB := librecovery_ui_imx

# kernel module's copy to vendor need this folder setting
KERNEL_OUT ?= $(OUT_DIR)/target/product/$(PRODUCT_DEVICE)/obj/KERNEL_OBJ

# if kernel binary file does not exist, need to output help info to tell users to use imx-make.sh to build the android images
ifneq ($(shell test -e $(OUT_DIR)/target/product/$(PRODUCT_DEVICE)/obj/KERNEL_OBJ/arch/$(TARGET_KERNEL_ARCH)/boot/$(KERNEL_NAME); echo $$? ),0)
  $(error Use "./imx-make.sh" to build the Android images to solve dependency on uboot/kernel. Use "./imx-make.sh -h" or refer to "i.MX Android User's Guide" for details)
endif

PRODUCT_COPY_FILES += \
    $(OUT_DIR)/target/product/$(PRODUCT_DEVICE)/obj/KERNEL_OBJ/arch/$(TARGET_KERNEL_ARCH)/boot/$(KERNEL_NAME):kernel

-include device/google/gapps/gapps_config.mk
-include $(FSL_RESTRICTED_CODEC_PATH)/fsl-restricted-codec/fsl_ms_codec/BoardConfig.mk
-include $(FSL_RESTRICTED_CODEC_PATH)/fsl-restricted-codec/fsl_real_dec/BoardConfig.mk
