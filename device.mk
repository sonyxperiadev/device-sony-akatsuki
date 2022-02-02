# Copyright 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Device path
DEVICE_PATH := device/sony/akatsuki

DEVICE_PACKAGE_OVERLAYS += \
    device/sony/akatsuki/overlay

# Vibrator
TARGET_VIBRATOR_V1_2 := true

# Device Specific Permissions
PRODUCT_COPY_FILES := \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.software.device_id_attestation.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.device_id_attestation.xml \
    frameworks/native/data/etc/android.software.verified_boot.xml:system/etc/permissions/android.software.verified_boot.xml

# Sensors
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/vendor/etc/sensors/config/sdm845_lsm6dsm_0_somc_product.json:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/config/sdm845_lsm6dsm_0_somc_product.json \
    $(DEVICE_PATH)/rootdir/vendor/etc/sensors/config/sdm845_ak991x_0_somc_product.json:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/config/sdm845_ak991x_0_somc_product.json

# Audio Configuration
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/vendor/etc/mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths.xml

# Audio calibration
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/vendor/etc/acdbdata/Bluetooth_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/Bluetooth_cal.acdb \
    $(DEVICE_PATH)/rootdir/vendor/etc/acdbdata/General_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/General_cal.acdb \
    $(DEVICE_PATH)/rootdir/vendor/etc/acdbdata/Global_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/Global_cal.acdb \
    $(DEVICE_PATH)/rootdir/vendor/etc/acdbdata/Handset_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/Handset_cal.acdb \
    $(DEVICE_PATH)/rootdir/vendor/etc/acdbdata/Hdmi_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/Hdmi_cal.acdb \
    $(DEVICE_PATH)/rootdir/vendor/etc/acdbdata/Headset_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/Headset_cal.acdb \
    $(DEVICE_PATH)/rootdir/vendor/etc/acdbdata/Speaker_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/Speaker_cal.acdb \
    $(DEVICE_PATH)/rootdir/vendor/etc/acdbdata/workspaceFile.qwsp:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/workspaceFile.qwsp \
    $(DEVICE_PATH)/rootdir/vendor/etc/acdbdata/adsp_avs_config.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/adsp_avs_config.acdb

# NFC Configuration
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/vendor/etc/libnfc-nxp.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nxp.conf

# BT/Wifi patch file
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/vendor/firmware/bdwlan.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/bdwlan.bin

# Atmel TS
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/vendor/firmware/touch_module_id_0x01.img:$(TARGET_COPY_OUT_VENDOR)/firmware/touch_module_id_0x01.img

# FPC Gestures
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/vendor/usr/keylayout/uinput-fpc.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/uinput-fpc.kl

# Device Init
PRODUCT_PACKAGES += \
    fstab.akatsuki \
    init.recovery.akatsuki \
    init.akatsuki

# Keymaster 4 passthrough service init file
# (executable is on odm)
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.0-service-qti.rc \
    android.hardware.keymaster@4.1.vendor

PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.keymaster.version=v4

DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/vintf/android.hw.keymaster_v4.xml

# NFC config
PRODUCT_PACKAGES += \
    nfc_nci.akatsuki

# Telephony Packages (AOSP)
PRODUCT_PACKAGES += \
    InCallUI \
    Stk

# SAR
PRODUCT_PACKAGES += \
    TransPowerSensors

PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREBUILT_DPI := xxhdpi xhdpi hdpi
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

PRODUCT_PROPERTY_OVERRIDES := \
    ro.sf.lcd_density=560 \
    ro.usb.pid_suffix=1FF

# Inherit from those products. Most specific first.
$(call inherit-product, device/sony/tama/platform.mk)

# copy NFC firmware
$(call inherit-product-if-exists, vendor/nxp/nxp-vendor.mk)

# include board vendor blobs
$(call inherit-product-if-exists, vendor/sony/tama-common/tama-partial.mk)
