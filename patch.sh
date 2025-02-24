#!/bin/bash

# https://github.com/PixelExperience/build/commit/8d0487a778a78a37866aa71d4305ebbc97ae8861
git -C $AOSP_DIR/build/tools restore releasetools/sign_target_files_apks.py
git -C $AOSP_DIR/build/tools apply $PWD/patches/patch_sign_target_files_apks.diff

# https://groups.google.com/g/clang-built-linux/c/RbwKbwkBok8/m/rGUo8gUWBgAJ
git -C $KERNEL_DIR/private/msm-google restore Makefile
git -C $KERNEL_DIR/private/msm-google apply $PWD/patches/patch_kernel_Makefile.diff
