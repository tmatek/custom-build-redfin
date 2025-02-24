#!/bin/bash

$AOSP_DIR/out/soong/host/linux-x86/bin/avbtool extract_public_key --key $KEYS_DIR/releasekey.key --output $DIST_DIR/pkmd.bin

$AOSP_DIR/out/soong/host/linux-x86/bin/img_from_target_files $AOSP_DIR/out/signed-target-files.zip $DIST_DIR/redfin-signed.zip
