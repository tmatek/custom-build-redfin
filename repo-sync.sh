#!/bin/bash

# aosp
(cd $AOSP_DIR && repo init -u https://android.googlesource.com/platform/manifest -b android-11.0.0_r46 --depth=1)
(cd $AOSP_DIR && repo sync -c)

# kernel
(cd $KERNEL_DIR && repo init -u https://android.googlesource.com/kernel/manifest -b android-msm-redbull-4.19-android11-qpr3)
(cd $KERNEL_DIR && repo sync -c)

# kernel build tools
(cd $KERNEL_DIR/prebuilts && mkdir gas)
(cd $KERNEL_DIR/prebuilts/gas && git clone https://android.googlesource.com/platform/prebuilts/gas/linux-x86 -b android-msm-redbull-4.19-android12-qpr1)
