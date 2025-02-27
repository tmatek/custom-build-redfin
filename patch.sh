#!/bin/bash

# https://github.com/PixelExperience/build/commit/8d0487a778a78a37866aa71d4305ebbc97ae8861
git -C $AOSP_DIR/build/tools restore releasetools/sign_target_files_apks.py
git -C $AOSP_DIR/build/tools apply $PWD/patches/patch_sign_target_files_apks.diff

# patch location of proprietary blobs
git -C $AOSP_DIR/device/google/redfin restore aosp_redfin.mk
git -C $AOSP_DIR/device/google/redfin apply $PWD/patches/patch_redfin_device_mkfile.diff
