#
# Copyright (C) 2017 The LineageOS Project
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

### INHERIT FROM YOSHIRO
include device/samsung/exynos9820-common/BoardConfigPlatform.mk
include vendor/samsung/beyond1lte/BoardConfigVendor.mk

DEVICE_PATH := device/samsung/beyond1lte

PRODUCT_PLATFORM := exynos9820

TARGET_OTA_ASSERT_DEVICE := beyond1,beyond1lte,beyond1ltexx

TARGET_SPECIFIC_HEADER_PATH += $(DEVICE_PATH)/hardware/include

### KERNEL
ifeq ($(WITH_MAGISK),true)
  TARGET_KERNEL_CONFIG := exynos9820-beyond1lte_magisk_defconfig
else
  TARGET_KERNEL_CONFIG := exynos9820-beyond1lte_defconfig
endif

BOARD_KERNEL_CMDLINE += androidboot.boot_devices=13d60000.ufs

### PARTITIONS
# /proc/partitions shows the size in 1024-byte blocks
BOARD_BOOTIMAGE_PARTITION_SIZE := 57671680 # 56 MB
BOARD_DTBOIMG_PARTITION_SIZE := 8388608 # 8 MB
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67633152 # 66 MB
BOARD_CACHEIMAGE_PARTITION_SIZE := 629145600 # 614 MB
BOARD_PRODUCTIMAGE_PARTITION_SIZE := 650117120 # 634 MB

# Rename BOARD_SYSTEMIMAGE_PARTITION_SIZE to BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE.
BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE := 5976883200 # 5 GB

# Rename BOARD_VENDORIMAGE_PARTITION_SIZE to BOARD_SUPER_PARTITION_VENDOR_DEVICE_SIZE
BOARD_SUPER_PARTITION_VENDOR_DEVICE_SIZE := 1153433600 # 1 GB

### Dynamic Partitions
BOARD_SUPER_PARTITION_BLOCK_DEVICES := system vendor
BOARD_SUPER_PARTITION_METADATA_DEVICE := system

# This is BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE + BOARD_SUPER_PARTITION_VENDOR_DEVICE_SIZE
BOARD_SUPER_PARTITION_SIZE := 7130316800

# Configuration for dynamic partitions. 
BOARD_SUPER_PARTITION_GROUPS := samsung_dymamic_partitions
BOARD_SAMSUNG_DYNAMIC_PARTITIONS_SIZE := 7126122496 # BOARD_SUPER_PARTITION_SIZE - overhead(4MB)
BOARD_SAMSUNG_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor product

# Reserve space for data encryption (119126622208 - 20480)
BOARD_USERDATAIMAGE_PARTITION_SIZE := 119126601728

# blockdev --getbsz /dev/block/sda
BOARD_FLASH_BLOCK_SIZE := 4096

### DISPLAY
TARGET_SCREEN_DENSITY := 560

### SYSTEM PROPS
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

### VENDOR SECURITY PATCH DATE
VENDOR_SECURITY_PATCH := 2020-09-01

### VENDOR PROPS
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
