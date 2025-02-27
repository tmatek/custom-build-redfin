LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),redfin)

$(call add-radio-file,proprietary/bootloader.img)
$(call add-radio-file,proprietary/radio.img)

endif
