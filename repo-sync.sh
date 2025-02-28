#!/bin/bash

# aosp
(cd $AOSP_DIR && repo init -u https://android.googlesource.com/platform/manifest -b android-11.0.0_r46 --depth=1)
(cd $AOSP_DIR && repo sync -c)

# driver binaries
curl https://dl.google.com/dl/android/aosp/google_devices-redfin-rq3a.211001.001-bd720345.tgz > google_redfin.tgz
curl https://dl.google.com/dl/android/aosp/qcom-redfin-rq3a.211001.001-71f56923.tgz > qcom_redfin.tgz

tar -xzvf google_redfin.tgz && rm google_redfin.tgz
mv extract-google_devices-redfin.sh $AOSP_DIR
(cd $AOSP_DIR && ./extract-google_devices-redfin.sh)

tar -xzvf qcom_redfin.tgz && rm qcom_redfin.tgz
mv extract-qcom-redfin.sh $AOSP_DIR
(cd $AOSP_DIR && ./extract-qcom-redfin.sh)

# kernel
(cd $KERNEL_DIR && repo init -u https://android.googlesource.com/kernel/manifest -b android-msm-redbull-4.19-android11-qpr3)
(cd $KERNEL_DIR && repo sync -c)

# kernel build tools
(cd $KERNEL_DIR/prebuilts && mkdir gas)
(cd $KERNEL_DIR/prebuilts/gas && git clone https://android.googlesource.com/platform/prebuilts/gas/linux-x86 -b android-msm-redbull-4.19-android12-qpr1)
