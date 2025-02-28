#!/bin/bash

cp -a $KERNEL_DIR/out/android-msm-pixel-4.19/dist/. $AOSP_DIR/device/google/redbull/

source $AOSP_DIR/build/envsetup.sh

(cd $AOSP_DIR && lunch aosp_redfin-user && make target-files-package otatools > $LOGS_DIR/build-aosp.txt 2>&1 &)

echo "Build started. Logs in $LOGS_DIR/build-aosp.txt"
