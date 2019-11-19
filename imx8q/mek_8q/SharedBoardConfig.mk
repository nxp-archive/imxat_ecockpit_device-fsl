# after selecting the target by "lunch" command, TARGET_PRODUCT will be set
ifeq ($(TARGET_PRODUCT),mek_8q_car)
  PRODUCT_IMX_CAR := true
  PRODUCT_IMX_CAR_M4 := true
endif
ifeq ($(TARGET_PRODUCT),mek_8q_car2)
  PRODUCT_IMX_CAR := true
  # the env setting in mek_8q_car to make the build without M4 image
  PRODUCT_IMX_CAR_M4 := false
endif

ifeq ($(PRODUCT_IMX_CAR),true)
  KERNEL_NAME := Image.lz4
else
  KERNEL_NAME := Image
endif
TARGET_KERNEL_ARCH := arm64

#Enable this to include trusty support
PRODUCT_IMX_TRUSTY := true

BOARD_VENDOR_KERNEL_MODULES += \
    $(KERNEL_OUT)/drivers/net/wireless/broadcom/brcm80211/brcmfmac/brcmfmac.ko \
    $(KERNEL_OUT)/drivers/net/wireless/broadcom/brcm80211/brcmutil/brcmutil.ko

ifeq ($(PRODUCT_IMX_CAR),true)
BOARD_VENDOR_KERNEL_MODULES += \
                            $(KERNEL_OUT)/drivers/extcon/extcon-ptn5150.ko \
                            $(KERNEL_OUT)/drivers/usb/roles/roles.ko \
                            $(KERNEL_OUT)/drivers/usb/typec/tcpci.ko \
                            $(KERNEL_OUT)/drivers/usb/typec/tcpm.ko \
                            $(KERNEL_OUT)/drivers/usb/cdns3/cdns3.ko \
                            $(KERNEL_OUT)/drivers/usb/chipidea/ci_hdrc.ko \
                            $(KERNEL_OUT)/drivers/usb/chipidea/ci_hdrc_imx.ko \
                            $(KERNEL_OUT)/drivers/usb/chipidea/usbmisc_imx.ko \
                            $(KERNEL_OUT)/drivers/usb/common/ulpi.ko \
                            $(KERNEL_OUT)/drivers/usb/host/xhci-hcd.ko \
                            $(KERNEL_OUT)/drivers/usb/host/ehci-hcd.ko \
                            $(KERNEL_OUT)/drivers/usb/storage/usb-storage.ko \
                            $(KERNEL_OUT)/drivers/usb/typec/typec.ko \
                            $(KERNEL_OUT)/drivers/scsi/sd_mod.ko \
                            $(KERNEL_OUT)/drivers/bluetooth/mx8_bt_rfkill.ko \
                            $(KERNEL_OUT)/drivers/hid/hid-multitouch.ko

ifeq ($(PRODUCT_IMX_CAR_M4),true)
BOARD_VENDOR_KERNEL_MODULES += \
                            $(KERNEL_OUT)/drivers/media/platform/imx8/max9286_gmsl.ko \
                            $(KERNEL_OUT)/drivers/media/platform/imx8/mxc-mipi-csi2.ko \
                            $(KERNEL_OUT)/drivers/media/platform/imx8/mxc-media-dev.ko \
                            $(KERNEL_OUT)/drivers/media/platform/imx8/mxc-capture.ko
endif
endif

